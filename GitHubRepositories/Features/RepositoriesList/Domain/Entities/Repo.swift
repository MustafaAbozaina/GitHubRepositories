//
//  Repository.swift
//  GitHubRepositories
//
//  Created by mustafa salah eldin on 10/5/22.
//

import Foundation

protocol Repo {
    var name: String? {get}
    var ownerName: String? {get}
    var avatar: String? {get}
    var creationDate: String? {get}
    var creationDuration: RepoCreationDuration {get}
}

enum RepoCreationDuration {
    case lessThan6Months
    case greaterThan6Months
}
