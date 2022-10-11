//
//  DefaultSearchForReposUseCase.swift
//  GitHubRepositories
//
//  Created by mustafa salah eldin on 10/9/22.
//

import Foundation

class DefaultSearchForReposUseCase: SearchForReposUseCase {
    var output: SearchForReposUseCaseOutput?
    var repository: SearchForReposRepository
    var searchKeyword = ""
    
    init(repository: SearchForReposRepository) {
        self.repository = repository
    }
    
    func start() {
        if searchKeyword.count < 2 {
            output?.searchCharacterShouldBeAtLeast2Characters()
            return
        }
        
        self.repository.searchForRepos(keyword: searchKeyword)
    }
}

extension DefaultSearchForReposUseCase: SearchForReposRepositoryOutput {
    
    func repos(_ repos: [Repo]) {
        self.output?.reposOutput(repos)
    }
}


