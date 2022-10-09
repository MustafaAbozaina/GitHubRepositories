//
//  ListAllRepositoriesUseCaseTests.swift
//  GitHubRepositoriesTests
//
//  Created by mustafa salah eldin on 10/5/22.
//

import XCTest
@testable import GitHubRepositories

class SearchForReposUseCaseTests: XCTestCase {
    
    func test_differentiateRepoCreationDuration_dependingOnMonthsCount() {
        let reposRepository = MockSearchRepository()
        let sut = DefaultSearchForReposUseCase(repository: reposRepository)
        reposRepository.output = sut
        let useCaseClient = MockSearchForReposClient(useCase: sut as UseCase)
        sut.output = useCaseClient
        
        sut.start()
    }
    
}

class MockSearchRepository: SearchForReposRepository {
    var output: SearchForReposRepositoryOutput?
    func searchForRepos(keyword: String) {
        self.output?.repos(buildReposModels())
    }
    
    private func buildReposModels() -> [RepoModel] {
        let createdAtDates = ["2022-06-05T09:03:57Z", "2022-01-05T09:03:57Z", "2022-02-05T09:03:57Z", "2022-10-05T09:03:57Z", "2022-09-05T09:03:57Z"]
        var repos = [RepoModel]()
        for i in 0..<5 {
            let owner =  RepoOwnerModel(login: "owner\(i)", avatarUrl: "avatar_url")
            repos.append(RepoModel(name: "owner\(i)", owner: owner, createdAt: createdAtDates[i]) )
        }
        return repos
    }
}

class MockSearchForReposClient {
    let listAllReposUseCase: UseCase
    init(useCase: UseCase) {
        self.listAllReposUseCase = useCase
    }
}

extension MockSearchForReposClient: ListReposUseCaseOutput {
    func reposOutput(_ repos: [Repo]) {
        let expectedResult: [RepoCreationDuration] = [.lessThan6Months, .greaterThan6Months, .greaterThan6Months, .lessThan6Months, .lessThan6Months]
        for i in 0..<repos.count {
            XCTAssertEqual(repos[i].creationDuration, expectedResult[i])
        }
    }
    
}
