//
//  ViewController.swift
//  GitHubRepos
//
//  Created by Tiago Chaves on 27/07/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var repositories:[Repository] = []
	var nextPage:Int = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		getRepositories()
	}
	
	private func getRepositories() {
		
		RepositoryListNetworkWorker().getRepositories(usingQuery: .language(language: .swift), sotedBy: .stars, inPage: nextPage) { (result, error) in
		
			if error == nil, let result = result, let repositories = result.items, repositories.count > 0 {
				
				self.repositories += repositories
			}else{
				
				if let error = error {
					
					let alert = UIAlertController(title: "Error", message: error.desc, preferredStyle: .alert)
					
					let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
					alert.addAction(action)
					
					self.present(alert, animated: true)
				}
			}
		}
	}
}

