import Foundation
import RealmSwift

class ProductRealm: Object{
  
  @objc dynamic var name = ""
  @objc dynamic var price = ""
  @objc dynamic var color = ""
  @objc dynamic var size = ""
  @objc dynamic var image = ""
  //@objc dynamic var realmInfo: NSDictionary = [:]
}


class BusketProduct{
  static let shared = BusketProduct()
  
  private let realm = try! Realm()
  
  func add(newDict: NSDictionary, size: String?){
    if size != nil{
      let productRealm = ProductRealm()
      productRealm.name = newDict["name"] as! String
      productRealm.price = newDict["price"] as! String
      productRealm.color = newDict["colorName"] as! String
      productRealm.size = size!
      productRealm.image = newDict["mainImage"] as! String
      try! realm.write{
        realm.add(productRealm)
      }
      
    } else {return}
  }
  
//  func getAll() -> realm.objects{
//    let allProductsRealm = realm.objects(ProductRealm.self)
//    return  allProductsRealm
//  }
  
  
  
}
