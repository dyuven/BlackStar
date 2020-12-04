import Foundation
import Alamofire

class CategoriesInfo {
    var sortOrder: String
    var imageURL: String
    var name: String
    
    init?(data: NSDictionary){
        guard let name = data["name"] as? String,
        let sortOrder = data["sortOrder"] as? String,
            let imageURL = data["imageURL"] as? String else {
                return nil
        }
        self.name = name
        self.sortOrder = sortOrder
        self.imageURL = imageURL
    }
}

//struct ArrayCategories: Codable {
//  var  list: [CategoriesInfo] = []
//}
