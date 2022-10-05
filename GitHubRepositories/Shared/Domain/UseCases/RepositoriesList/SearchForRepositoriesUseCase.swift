//
//  SearchForARepositoryUseCase.swift
//  GitHubRepositories
//
//  Created by mustafa salah eldin on 10/5/22.
//

import Foundation

protocol SearchForARepositoryUseCase: UseCase {
    func searchForRepo(name: String)
}
