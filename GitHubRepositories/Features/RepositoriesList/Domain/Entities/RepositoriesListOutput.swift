//
//  RepositoriesListOutput.swift
//  GitHubRepositories
//
//  Created by mustafa salah eldin on 10/5/22.
//

import Foundation

protocol RepositoriesListOutput {
    func repositories(_ repos: [Repository])
}
