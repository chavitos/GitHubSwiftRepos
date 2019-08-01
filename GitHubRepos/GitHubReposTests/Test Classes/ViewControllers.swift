//
//  ViewControllers.swift
//  GitHubReposTests
//
//  Created by Tiago Chaves on 01/08/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit
@testable import GitHubRepos

func loadRepositoryListViewController() -> RepositoryListViewController {
	
	let window = UIApplication.shared.windows.first
	return window?.rootViewController?.children.first { $0 is RepositoryListViewController } as! RepositoryListViewController
}

