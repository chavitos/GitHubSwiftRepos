//
//  Repository.swift
//  GitHubRepos
//
//  Created by Tiago Chaves on 29/07/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

//Exibir nome do repo, quantidade de estrelas, foto e nome do autor

struct Repository:Codable, CustomStringConvertible {
	
	var name	: String?
	var stars	: Int?
	var owner	: Owner?
	
	enum CodingKeys:String,CodingKey{
		
		case name
		case owner
		case stars 	= "stargazers_count"
	}
	
	var description: String {
		return "\(name ?? "?") is a repository owned by \(owner?.name ?? "no one")!"
	}
}
