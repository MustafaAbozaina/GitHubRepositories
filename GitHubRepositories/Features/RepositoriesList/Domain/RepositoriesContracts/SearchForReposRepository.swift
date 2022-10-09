//
//  SearchForReposRepository.swift
//  GitHubRepositories
//
//  Created by mustafa salah eldin on 10/9/22.
//

import Foundation

protocol SearchForReposRepository: Repository {
    func searchForRepos(keyword: String)
}

protocol SearchForReposRepositoryOutput {
    func repos(_ repos: [Repo])
}
