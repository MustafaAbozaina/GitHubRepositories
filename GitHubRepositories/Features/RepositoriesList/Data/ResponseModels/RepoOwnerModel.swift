//
//  RepoOwnerModel.swift
//  GitHubRepositories
//
//  Created by mustafa salah eldin on 10/9/22.
//

import Foundation


struct RepoOwnerModel: Codable {
    var login: String?
    var avatarUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}
