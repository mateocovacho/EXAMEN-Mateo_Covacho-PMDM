import Foundation
import Combine

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var selectedCategory: String = "Electronics"
    
    private let service = ProductService()
    
    // List of categories to display (based on your screenshots)
    let categories: [String] = ["Electronics", "Jewelery", "Men's clothing", "Women's clothing"]
    
    init() {
        fetchProducts() // Fetch default category on initialization
    }
    
    func fetchProducts() {
        service.fetchProducts(for: selectedCategory) { [weak self] result in
            switch result {
            case .success(let products):
                self?.products = products
            case .failure(let error):
                print("Error fetching products:", error.localizedDescription)
                self?.products = []
            }
        }
    }
    
    // If the user changes the category in the picker, fetch new data
    func categoryChanged(to newCategory: String) {
        selectedCategory = newCategory
        fetchProducts()
    }
}
