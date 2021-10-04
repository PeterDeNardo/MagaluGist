//
//  GistModel.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 29/09/21.
//

import Foundation

struct DashGistModel: Decodable, Encodable {
    let url: String
    let forks_url: String?
    let commit_url: String?
    let id: String
    let nodeId: String?
    let gitPullUrl: String?
    let gitPushUrl: String?
    let htmlUrl: String?
    let files: DashGistFiles
    let publicValue: Bool?
    let createdAt: String?
    let updatedAt: String?
    let description: String?
    let comments: Int?
    //let user: 
    let commentsUrl: String?
    let owner: DashGistOwner
    let truncated: Bool?
    var favorited: Bool? = false
    
    private enum CondingKeys: String, CodingKey {
        case url
        case foorksUrl = "forks_url"
        case commitUrl = "commit_url"
        case id
        case nodeId = "node_id"
        case gitPullUrl = "git_pull_url"
        case gitPushUrl = "git_push_url"
        case htmlUrl = "html_url"
        case files
        case publicValue = "public"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case description
        case comments
        case commentsUrl = "comments_url"
        case owner
        case truncated
    }
}

struct DashGistFiles: Decodable, Encodable {
    var randomId: RandomID?
    struct RandomID: Decodable, Encodable {
        let filename: String
        let type: String
        let language: String?
        let rawUrl: String?
        let size: Int?
        
        private enum CondingKeys: String, CodingKey {
            case filename
            case type
            case language
            case rawUrl = "raw_url"
            case size
        }
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CondingKeys.self)
        for key in container.allKeys {
            randomId = try? container.decode(RandomID.self, forKey: key)
        }
        struct CondingKeys: CodingKey {
            
            var stringValue: String
            init?(stringValue string: String) {
                self.stringValue = string
            }
            var intValue: Int?
            init?(intValue int: Int) {
                return nil
            }
        }
    }
}

struct DashGistOwner: Decodable, Encodable {
    let login: String
    let id: Int?
    let nodeId: String?
    let avatarUrl: String?
    let gravatarId: String?
    let url: String?
    let htmlUrl: String?
    let followerUrl: String?
    let followingUrl: String?
    let gistsUrl: String?
    let starredUrl: String?
    let subscriptionUrl: String?
    let organizationUrl: String?
    let reposUrl: String?
    let eventsUrl: String?
    let receivedEventsUrl: String?
    let type: String?
    let siteAdmin: Bool?
    
    private enum CondingKeys: String, CodingKey {
        case login
        case id
        case nodeId = "node_id"
        case url
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case htmlUrl = "html_url"
        case followerUrl = "follower_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case starredUrl = "starred_url"
        case subscriptionUrl = "subscription_url"
        case organizationUrl = "organization_url"
        case reposUrl = "repos_url"
        case eventsUrl = "events_Url"
        case receivedEventsUrl = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}
