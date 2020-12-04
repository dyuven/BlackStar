import Foundation
import Alamofire

class ProductLoader{
  
  func loadProduct(id: String, completion: @escaping([NSDictionary]) -> Void){
      Alamofire.request("https://blackstarshop.ru/index.php?route=api/v1/products&cat_id=" + id).responseJSON { (response) in
      print("loadProdyct is start")
        var productData:[NSDictionary] = []
        if let objects = response.result.value,
            let jsonDict = objects as? NSDictionary{
            do {
                for (_, data) in jsonDict where data is NSDictionary{
                        productData.append(data as! NSDictionary)
                }
             //   print(Data)
                 //   print(i)
//                    for (index, _) in productData.enumerated(){
//                      let tempImages = productData[index]["productImages"]
//                          productData.remove(at: index)
//                        }
              
                 DispatchQueue.main.async {
                    completion(productData)
              }
            } catch { print(error) }
          }
      }
    }
}
