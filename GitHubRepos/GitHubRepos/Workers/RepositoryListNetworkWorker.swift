//
//  RepositoryListNetworkWorker.swift
//  GitHubRepos
//
//  Created by Tiago Chaves on 29/07/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

class RepositoryListNetworkWorker:RepositoryListWorkerProtocol {
	
	func getRepositories(usingQuery query:Query, sotedBy sort:Sort, orderedBy order:Order = .desc, inPage page:Int, completion: @escaping ((RepositoryList?,RepositoryListErrors?) -> Void)) {
		
		let request = GitHubReposRequests.getRepositories(query: query, sort: sort, order: order, page: page)
		
		NetworkManager.request(withURL: request) { (data, response, error) in
			
			if error == nil, let data = data {
				
				do {
					let decoder = JSONDecoder()
					decoder.keyDecodingStrategy = .convertFromSnakeCase
					let result = try decoder.decode(RepositoryList.self, from: data)
					
					completion(result, nil)
				} catch let error {
					
					let repoError = RepositoryListErrors.getReposError(desc: error.localizedDescription)
					completion(nil, repoError)
				}
			} else {
				
				let repoError = RepositoryListErrors.getReposError(desc: error?.localizedDescription ?? "Error!" )
				completion(nil, repoError)
			}
		}
	}
}


enum RepositoryListErrors:Error {
	
	case getReposError(desc:String)
	
	var desc:String {
		
		switch self {
		case .getReposError(let desc):
			return "Error ao tentar recuperar os repositórios: \(desc)"
		}
	}
}
