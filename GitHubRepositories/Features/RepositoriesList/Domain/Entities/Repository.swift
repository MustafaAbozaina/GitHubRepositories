//
//  Repository.swift
//  GitHubRepositories
//
//  Created by mustafa salah eldin on 10/5/22.
//

import Foundation

protocol Repo {
    var name: String? {get}
    var owner: String? {get}
    var avatar: String? {get}
    var date: String? {get}
    var dateType: RepoCreationDate {get}
}

enum RepoCreationDate {
    case lessThan6Months
    case greaterThan6Months
}
