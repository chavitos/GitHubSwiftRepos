//
//  RepositoryListNetworkWorker.swift
//  GitHubRepos
//
//  Created by Tiago Chaves on 29/07/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

class RepositoryListNetworkWorker {
	
	func getRepositories(usingQuery query:Query, sotedBy sort:Sort, orderedBy order:Order = .desc, inPage page:Int, completion: @escaping ((RepositoryList?,Error?) -> Void)) {
	
		let request = GitHubReposRequests.getRepositories(query: query, sort: sort, order: order, page: page)
		
		NetworkManager.request(withURL: request) { (data, response, error) in
			
			if error == nil {
				
				if let data = data, let response = response {
					
					
				}
			}else {
				
				
			}
		}
	}
}
