//
//  RepositoryListWorker.swift
//  GitHubRepos
//
//  Created by Tiago Chaves on 01/08/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

typealias completionClosure = (RepositoryList?,RepositoryListErrors?) -> Void

protocol RepositoryListWorkerProtocol {
	func getRepositories(usingQuery query:Query, sotedBy sort:Sort, orderedBy order:Order, inPage page:Int, completion: @escaping completionClosure)
}

class RepositoryListWorker {
	
	var worker:RepositoryListWorkerProtocol
	
	init(worker:RepositoryListWorkerProtocol) {
		self.worker = worker
	}
	
	func getRepositories(usingQuery query:Query, sotedBy sort:Sort, orderedBy order:Order = .desc, inPage page:Int, completion: @escaping completionClosure) {
		
		self.worker.getRepositories(usingQuery: query, sotedBy: sort, orderedBy: order, inPage: page) { (result, error) in
			
			completion(result,error)
		}
	}
}
