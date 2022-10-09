//
//  RepoModel.swift
//  GitHubRepositories
//
//  Created by mustafa salah eldin on 10/9/22.
//

import Foundation

struct RepoModel: Codable {
    var name: String?
    var owner: RepoOwnerModel?
    var createdAt: String?
    
    private enum CodingKeys: String, CodingKey {
        case name, owner
        case createdAt = "created_at"
    }
    
}
