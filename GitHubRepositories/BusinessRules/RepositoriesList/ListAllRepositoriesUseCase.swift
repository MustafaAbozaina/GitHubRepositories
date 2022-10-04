//
//  ListAllRepositories.swift
//  GitHubRepositories
//
//  Created by mustafa salah eldin on 10/5/22.
//

import Foundation

protocol ListAllRepositoriesUseCase: RepositoriesUseCase { }

protocol Repository {
    var name: String? {get}
    var owner: String? {get}
    var avatar: String? {get}
}
