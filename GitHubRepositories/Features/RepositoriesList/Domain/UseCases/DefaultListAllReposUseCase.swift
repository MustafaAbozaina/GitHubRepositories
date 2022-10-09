//
//  DefaultListAllRepositoriesUseCase.swift
//  GitHubRepositories
//
//  Created by mustafa salah eldin on 10/5/22.
//

import Foundation


class DefaultListAllReposUseCase: ListAllReposUseCase {
    var output: ReposListOutput?
    var repository: ListAllReposRepository
    
    init(repository: ListAllReposRepository) {
        self.repository = repository
    }
    
    func start() {
        repository.loadAllRepos()
    }
}

