//
//  RepositoryListViewController.swift
//  GitHubRepos
//
//  Created by Tiago Chaves on 31/07/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit

enum AppState {
	case fetching
	case done
	case refreshing
}

class RepositoryListViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	var repositories:[Repository] = []
	var nextPage:Int = 0
	var state:AppState = .done {
		
		willSet(newValue) {
			
			if newValue == .done {
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		}
	}
	
	let cellIdentifier = "RepositoryCell"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		getRepositories()
	}
	
	private func getRepositories() {
		
		state = .fetching
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
			self.state = .done
		}
	}
}

extension RepositoryListViewController:UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.repositories.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let repository = repositories[indexPath.row]
		
		if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RepositoryTableViewCell {
			
			cell.config(withRepository: repository)
			
			return cell
		}
		
		return UITableViewCell()
	}
}
