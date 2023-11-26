//
//  BackendService.swift
//  clientApp
//
//  Created by Andrey Matveev on 26.11.2023.
//

import Foundation
import UIKit

enum ImageError: Error {
    case encodingFailed
}

final class BackendService {
    private var email: String = "some@gmail.com"
    private var backendUrl = "http://172.60.8.14:8080"
    
    init(email: String) {
        self.email = email
    }
    
    func setEmail(email: String) {
        self.email = email
    }
    
    enum NetworkingError: Error { case badResponse, badData, encodingError }

    func postData(_ data: Data, to url: URL) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(self.email, forHTTPHeaderField: "email")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        let (data, _) = try await URLSession.shared.upload(for: request, from: data)
        return data
    }

    func createTag(lon: Double, lat: Double, title: String, description: String, owner: String, prize: Int) async throws -> Data {
        let id = UUID()
        let url = URL(string: backendUrl + "/tags")!

        let json: [String: Any] = [
            "id": id.uuidString,
            "lon": lon,
            "lat": lat,
            "title": title,
            "description": description,
            "owner": owner,
            "prize": prize
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: json)
        let data = try await postData(jsonData, to: url)
        return data
    }
    
    func fetchData(from request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError()
        }
        return data
    }

    func getTags() async throws -> [Tag] {
        let url = URL(string: backendUrl + "/tags")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(self.email, forHTTPHeaderField: "email")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let data = try await fetchData(from: request)
        let tags = try JSONDecoder().decode([Tag].self, from: data)
        return tags
    }
    
    func getAccount() async throws -> Account {
        let url = URL(string: backendUrl + "/accounts")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(self.email, forHTTPHeaderField: "email")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let data = try await fetchData(from: request)
        let account = try JSONDecoder().decode(Account.self, from: data)
        return account
    }
    
    func getNfts() async throws -> [NftAsset] {
        let account = try await getAccount()
        return account.nfts.map { nft in
            NftAsset(imageName: nft.id, text: String(nft.value))
        }
    }
    
    func addPhotoToTag(id: String, photoData: String) async throws -> String {
        let url = URL(string: backendUrl + "/\(id)/photos")!

        let json: [String: Any] = [
            "data": photoData
        ]

        let jsonData = try JSONSerialization.data(withJSONObject: json)
        let data = try await postData(jsonData, to: url)
        return String(data: data, encoding: .utf8) ?? ""
    }
    
    func addCommentToTag(id: String, commentData: String) async throws {
        let url = URL(string: backendUrl + "/\(id)/comments")!

        let json: [String: Any] = [
            "data": commentData
        ]

        let jsonData = try JSONSerialization.data(withJSONObject: json)
        let _ = try await postData(jsonData, to: url)
    }
    
    func voteForTag(id: String, amount: Int) async throws {
        let url = URL(string: backendUrl + "/\(id)/vote")!
        
        struct TagVoteRequest: Encodable {
            let amount: Int
        }

        let voteRequest = TagVoteRequest(amount: amount)
        let jsonData = try JSONEncoder().encode(voteRequest)

        let _ = try await postData(jsonData, to: url)
    }
    
    func makeDecisionForTag(id: String, decision: Bool) async throws {
        let url = URL(string: backendUrl + "/\(id)/decision")!
        
        struct TagDecisionRequest: Encodable {
            let decision: Bool
        }

        let decisionRequest = TagDecisionRequest(decision: decision)
        let jsonData = try JSONEncoder().encode(decisionRequest)
        let _ = try await postData(jsonData, to: url)
    }

    func claimTag(id: String, photoUrls: [String]) async throws {
        let url = URL(string: backendUrl + "/\(id)/claim")!
        
        struct ClaimTagBodyRequest: Encodable {
            let photoUrls: [String]
        }

        let claimRequest = ClaimTagBodyRequest(photoUrls: photoUrls)
        let jsonData = try JSONEncoder().encode(claimRequest)

        let _ = try await postData(jsonData, to: url)
    }
    
    func getAllChallenges() async throws -> [Challenge] {
        let url = URL(string: backendUrl + "/challenges")! // Please replace with your actual endpoint
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(self.email, forHTTPHeaderField: "email")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let data = try await fetchData(from: request)
        let challenges = try JSONDecoder().decode([Challenge].self, from: data)
        return challenges
    }
    
    func createChallenge(challenge: Challenge) async throws {
        let url = URL(string: backendUrl + "/challenges")!

        let jsonData = try JSONEncoder().encode(challenge)
        let _ = try await postData(jsonData, to: url)
    }
    
    func createTagWithImages(lon: Double,
                             lat: Double,
                             title: String,
                             description: String,
                             prize: Int,
                             images: [UIImage]) async throws {
        let tagInfoData = try await createTag(lon: lon, lat:lat, title: title, description: description, owner: email, prize: prize)
        let tagInfo = try JSONDecoder().decode(Tag.self, from: tagInfoData)
        guard let uploadUrl = URL(string: "http://172.60.8.14:8081/upload") else { return }
        let id = tagInfo.id
        
        var imageUrlPromises = [String]()
            
            for image in images {
                let url = try await uploadImage(image, to: URL(string: "http://172.60.8.14:8081/upload")!)
                imageUrlPromises.append(url)
            }
            
        for url in imageUrlPromises {
            try await addPhotoToTag(id: id, photoData: url)
        }
    }
    
    func uploadImage(_ image: UIImage, to url: URL) async throws -> String {
        guard let imageData = image.pngData() else { throw ImageError.encodingFailed }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"photo.png\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.upload(for: request, from: body)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkingError.badResponse
        }
        
        struct Hobana: Decodable {
            let url: String
        }
        
        return try JSONDecoder().decode(Hobana.self, from: data).url
    }
    
}
