//
//  SearchForARepositoryUseCaseOutput.swift
//  GitHubRepositories
//
//  Created by mustafa salah eldin on 10/5/22.
//

import Foundation

protocol SearchForReposUseCaseOutput: ReposListOutput {
    func searchCharacterShouldBeAtLeast2Characters()
}
