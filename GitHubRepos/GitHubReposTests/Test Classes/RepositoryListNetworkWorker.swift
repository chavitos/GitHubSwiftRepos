//
//  RepositoryListNetworkWorker.swift
//  GitHubReposTests
//
//  Created by Tiago Chaves on 01/08/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation
@testable import GitHubRepos

class RepositoryListNetworkWorkerMock: RepositoryListNetworkWorker {
	
	var calledGetRepositories = false
	
	override func getRepositories(usingQuery query: Query, sotedBy sort: Sort, orderedBy order: Order = .desc, inPage page: Int, completion: @escaping ((RepositoryList?, RepositoryListErrors?) -> Void)) {
		
		self.calledGetRepositories = true
		completion(nil,nil)
	}
}
