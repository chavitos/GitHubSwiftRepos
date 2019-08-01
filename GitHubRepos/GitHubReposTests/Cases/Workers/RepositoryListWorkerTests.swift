//
//  RepositoryListWorkerTests.swift
//  GitHubReposTests
//
//  Created by Tiago Chaves on 01/08/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import XCTest
@testable import GitHubRepos

class RepositoryListWorkerTests: XCTestCase {

	var sut: RepositoryListWorker!
	
    override func setUp() {
        super.setUp()
		sut = RepositoryListWorker(worker: RepositoryListNetworkWorkerMock())
    }

    override func tearDown() {
        sut = nil
		super.tearDown()
    }
	
	func testWorker_callGetRepositoriesFromWorker() {
		
		let exp = expectation(description: "fetching repos")
		
		sut.getRepositories(usingQuery: .language(language: .swift), sotedBy: .stars, orderedBy: .desc, inPage: 1) { (result, error) in
			
			exp.fulfill()
		}
		
		waitForExpectations(timeout: 1)
		
		let worker = sut.worker as! RepositoryListNetworkWorkerMock
		XCTAssertTrue(worker.calledGetRepositories)
	}
}
