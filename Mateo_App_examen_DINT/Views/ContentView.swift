import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ProductViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Category Picker
                Picker("Category", selection: $viewModel.selectedCategory) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle()) // or .menu, .wheel, etc.
                .padding()
                .onChange(of: viewModel.selectedCategory) { newCategory in
                    viewModel.categoryChanged(to: newCategory)
                }
                
                // Product List
                List(viewModel.products) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        ProductRow(product: product)
                    }
                }
            }
            .navigationTitle("FakeStore")
        }
    }
}
