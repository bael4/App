import UIKit
import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager()

    let context: NSManagedObjectContext

    private let hasDataKey = "hasData"

    private init() {

        var appDelegate = UIApplication.shared.delegate as? AppDelegate

           guard let delegate = appDelegate else {
               fatalError("Unable to retrieve shared app delegate.")
           }

           context = delegate.persistentContainer.viewContext

       }

    func saveProductsToCoreData(products: [ProductModel], completion: @escaping () -> Void) {

        let defaults = UserDefaults.standard

        if defaults.bool(forKey: hasDataKey) {
            completion()
            return
        }

        var productEntities: [Product] = []

        // Создаем все объекты Product
        for product in products {
            let productEntity = Product(context: context)
            productEntity.id = Int16(Int64(product.id ?? 0))
            productEntity.title = product.title
            productEntity.price = product.price ?? 0.0
            productEntity.descriptionn = product.description
            productEntity.category = product.category
            productEntity.image = product.image
            productEntity.isSelected = false

            if let ratingModel = product.rating {
                let rating = Rating(context: context)
                rating.rate = ratingModel.rate ?? 0.0
                rating.count = Int16(ratingModel.count ?? 0)
                productEntity.rating = rating
            }
            
            productEntities.append(productEntity)
        }
        
        // Сохраняем все объекты в контексте Core Data
        do {
            try context.save()
            completion()
            defaults.set(true, forKey: hasDataKey)
            print("Products saved successfully to Core Data")
        } catch let error as NSError {
            print("Error saving products to Core Data: \(error.localizedDescription)")
        }
    }
    
    func fetchAllCharactersBaseMain() -> [Product] {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        let sortDescriptorCreationDate = NSSortDescriptor(key: "id", ascending: false)
        let sortDescriptorLastUpdatedDate = NSSortDescriptor(key: "price", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptorCreationDate, sortDescriptorLastUpdatedDate]
        
        do {
            let characters = try context.fetch(fetchRequest)
            return characters
        } catch {
            print("Failed to fetch characters: \(error)")
            return []
        }
    }
    
    func toggleSelectionForItem(withID id: Int) {
            let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", id)
            
            do {
                if let item = try context.fetch(fetchRequest).first {

                    item.isSelected.toggle()

                    try context.save()
                    print("Item with ID \(id) selection status toggled successfully.")
                } else {
                    print("Item with ID \(id) not found.")
                }
            } catch {
                print("Failed to toggle selection for item with ID \(id): \(error)")
            }
        }
    
    func fetchAllFavorites() -> [Product] {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        let sortDescriptorCreationDate = NSSortDescriptor(key: "id", ascending: false)
        let sortDescriptorLastUpdatedDate = NSSortDescriptor(key: "price", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptorCreationDate, sortDescriptorLastUpdatedDate]
        
        do {
            let characters = try context.fetch(fetchRequest)
            return characters.filter { $0.isSelected == true }
        } catch {
            print("Failed to fetch characters: \(error)")
            return []
        }
    }


}

