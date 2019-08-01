//
//  RepositoryListViewControllerTests.swift
//  GitHubReposTests
//
//  Created by Tiago Chaves on 01/08/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import XCTest
@testable import GitHubRepos

class RepositoryListViewControllerTests: XCTestCase {

	var sut: RepositoryListViewController!
	
    override func setUp() {
    	super.setUp()
		sut = loadRepositoryListViewController()
    }

    override func tearDown() {
		
		super.tearDown()
    }
	
	//app calls getRepositories when starts
	func testController_whenAppStarts_stateIsFetching() {
		
		sut.loadViewIfNeeded()
		
		XCTAssertEqual(sut.state, AppState.fetching)
	}

}
