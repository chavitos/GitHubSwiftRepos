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
	
	private let refreshControl = UIRefreshControl()
	var repositories:[Repository] = []
	var nextPage:Int = 1
	var total:Int = 0
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
		
		config()
		getRepositories()
	}
	
	private func config() {
		
		if #available(iOS 10.0, *) {
			tableView.refreshControl = refreshControl
		} else {
			tableView.addSubview(refreshControl)
		}
		
		refreshControl.addTarget(self, action: #selector(refreshRepositories), for: .valueChanged)
		refreshControl.attributedTitle = NSAttributedString(string: "Refreshing repositories ...", attributes:nil)
	}
	
	@objc private func refreshRepositories() {
		
		state = .refreshing
		nextPage = 1
		
		getRepositories()
	}
	
	private func getRepositories() {
		
		if state == .done {
			state = .fetching
		}
		
		let repositoryWorker = RepositoryListWorker(worker: RepositoryListNetworkWorker())
		
		repositoryWorker.getRepositories(usingQuery: .language(language: .swift), sotedBy: .stars, inPage: nextPage) { (result, error) in
			
			if error == nil, let result = result, let repositories = result.items, repositories.count > 0 {
				
				if self.state == .fetching {
					self.repositories += repositories
				}else{
					self.repositories = repositories
				}
				self.nextPage += 1
				self.total = result.total ?? 0
			}else{
				
				if let error = error {
					
					let alert = UIAlertController(title: "Error", message: error.desc, preferredStyle: .alert)
					
					let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
					alert.addAction(action)
					
					self.present(alert, animated: true)
				}
			}
			self.refreshControl.endRefreshing()
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
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		
		if state == .done {
			
			if offsetY > contentHeight - scrollView.frame.height {
				
				if GitHubReposRequests.per_page * nextPage < total {
					
					getRepositories()
				}
			}
		}
	}
}
