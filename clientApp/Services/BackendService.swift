//
//  BackendService.swift
//  clientApp
//
//  Created by Andrey Matveev on 26.11.2023.
//

import Foundation

final class BackendService {
    private var email: String = "some@gmail.com"
    
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

    func createTag(lon: Double, lat: Double, title: String, description: String, owner: String, prize: Int) async throws {
        let id = UUID()
        let url = URL(string: "http://172.60.8.14:8080/tags")!

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
        let _ = try await postData(jsonData, to: url)
    }
    
    func fetchData(from request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError()
        }
        return data
    }

    func getTags() async throws -> [Tag] {
        let url = URL(string: "http://172.60.8.14:8080/tags")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("some@gmail.com", forHTTPHeaderField: "email")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let data = try await fetchData(from: request)
        let tags = try JSONDecoder().decode([Tag].self, from: data)
        return tags
    }
    
    func getAccount() async throws -> Account {
        let url = URL(string: "http://172.60.8.14:8080/accounts")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("some@gmail.com", forHTTPHeaderField: "email")
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
    
}
