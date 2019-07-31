//
//  RepositoryTableViewCell.swift
//  GitHubRepos
//
//  Created by Tiago Chaves on 30/07/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

	
	@IBOutlet weak var photo: UIImageView!
	
	@IBOutlet weak var repositoryNameLabel: UILabel!
	@IBOutlet weak var repositoryStarsLabel: UILabel!
	@IBOutlet weak var repositoryOwnerLabel: UILabel!
	
	override func prepareForReuse() {
		
		photo.image = nil
		repositoryNameLabel.text = ""
		repositoryOwnerLabel.text = ""
		repositoryStarsLabel.text = ""
	}

	func config(withRepository repository:Repository) {
		
		repositoryNameLabel.text = repository.name ?? "-"
		repositoryStarsLabel.text = "⭐️ \(repository.stars ?? 0)"
		repositoryOwnerLabel.text = "a repository of \(repository.owner?.name ?? "no one")"
		
		if let photoUrl = repository.owner?.photoUrl {
			
			photo.setImage(withUrl: photoUrl)
		}
	}
}
