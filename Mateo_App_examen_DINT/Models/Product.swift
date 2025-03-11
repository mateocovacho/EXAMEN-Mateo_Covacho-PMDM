import Foundation

// MARK: - Product Model
struct Product: Identifiable, Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating?
    
    // The API provides rating info as a nested object:
    struct Rating: Codable {
        let rate: Double
        let count: Int
    }
}