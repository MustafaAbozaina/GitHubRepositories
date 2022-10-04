//
//  RepositoriesUseCase.swift
//  GitHubRepositories
//
//  Created by mustafa salah eldin on 10/5/22.
//

import Foundation

protocol RepositoriesUseCase: UseCase {
    func repositories(_ repos: [Repository])
}
