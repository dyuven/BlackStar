import Foundation
import Alamofire

class CategoriesLoader{
  
//  var categoriesData = CategoriesInfo()
//  var categories:[CategoriesInfo] = []
  
//  func loadCategories(completion: @escaping([CategoriesInfo]) -> Void){
//    var categories:[CategoriesInfo] = []
//    Alamofire.request("https://blackstarshop.ru/index.php?route=api/v1/categories").responseJSON { (response) in
//      print("loadCategories is start")
//        print(response.value)
//        print("respnce is coming")
//        if let objects = response.result.value,
//            let jsonDict = objects as? NSDictionary{
//            do {
//                print("do start")
//                for (_, data) in jsonDict where data is NSDictionary{
//                    if let category = CategoriesInfo(data: data as! NSDictionary){
//                        print("data")
//                        categories.append(category)
//                    }
//                }
//                print(categories)
//                print(categories.count)
//                 DispatchQueue.main.async {
//                    completion(categories)
//              }
//            } catch { print(error) }
//          }
//      }
//    }
    
    
    func loadCategories2(completion: @escaping([NSDictionary]) -> Void){
    Alamofire.request("https://blackstarshop.ru/index.php?route=api/v1/categories").responseJSON { (response) in
      print("loadCategories2 is start")
        var categortData:[NSDictionary] = []
        if let objects = response.result.value,
            let jsonDict = objects as? NSDictionary{
            do {
                for (_, data) in jsonDict where data is NSDictionary{
                        categortData.append(data as! NSDictionary)
                }
             //   print(categortData)
                for _ in 1...4 {
                 //   print(i)
                    for (index, _) in categortData.enumerated(){
                        if  categortData[index]["name"] as? String == "Marketplace" || categortData[index]["name"] as? String == "Коллекции" || categortData[index]["name"] as? String == "Предзаказ" {
                            print("index = " + String(index))
                            print(categortData.count)
                            categortData.remove(at: index)
                            print(categortData.count)
                            break
                        }
                    }
                }
                
               // print(categortData)
    
                 DispatchQueue.main.async {
                    completion(categortData)
              }
            } catch { print(error) }
          }
      }
    }
}


//                self.categoriesData = try JSONDecoder().decode(CategoriesInfo.self, from: objects as! Data )
//                self.categories.append(self.categoriesData)
