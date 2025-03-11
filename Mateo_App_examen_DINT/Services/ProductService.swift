import Foundation

class ProductService {
    
    // Fetch products for a given category
    func fetchProducts(for category: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        // Convert spaces and apostrophes in the category to URL-friendly encoding
        guard let encodedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let url = URL(string: "https://fakestoreapi.com/products/category/\(encodedCategory)") else {
            let error = NSError(domain: "InvalidURL", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for error
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            // Check for valid data
            guard let data = data else {
                let error = NSError(domain: "NoData", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            // Decode JSON
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(products))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
