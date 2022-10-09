//
//  ReposListResponseModels.swift
//  GitHubRepositories
//
//  Created by mustafa salah eldin on 10/9/22.
//

import Foundation

struct ReposRootModel<T: Codable>: Codable {
    var total_count: Int?
    var items: T?
}
