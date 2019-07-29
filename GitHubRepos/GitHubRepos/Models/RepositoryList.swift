//
//  RepositoryList.swift
//  GitHubRepos
//
//  Created by Tiago Chaves on 29/07/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

struct RepositoryList: Decodable, CustomStringConvertible {
	
	var total	: Int?
	var items	: [Repository]?
	var message	: String?
	
	enum CodingKeys:String,CodingKey{
		
		case total = "total_count"
		case items
		case message
	}
	
	var description: String {
		return "\(total ?? 0) item(s)."
	}
}
