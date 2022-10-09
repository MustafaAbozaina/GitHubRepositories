//
//  ListAllReposRepository.swift
//  GitHubRepositories
//
//  Created by mustafa salah eldin on 10/9/22.
//

import Foundation

protocol ListAllReposRepository: Repository {
    func loadAllRepos()
}
