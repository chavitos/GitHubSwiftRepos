//
//  Owner.swift
//  GitHubRepos
//
//  Created by Tiago Chaves on 29/07/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

struct Owner: Codable, CustomStringConvertible {
	
	var name		: String?
	var photoUrl	: String?
	
	enum CodingKeys:String,CodingKey{
		
		case name 		= "login"
		case photoUrl 	= "avatarUrl"
	}
	
	var description: String {
		return "\(name ?? "no one")"
	}
}
