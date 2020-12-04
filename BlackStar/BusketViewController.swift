import UIKit
import RealmSwift

let realm = try! Realm()


class BusketViewController: UIViewController {
  
  //var products: [NSDictionary] = []
  var products: [ProductRealm] = []
  
  @IBOutlet weak var allPricelabel: UILabel!
  @IBOutlet weak var busketTableView: UITableView!
  var allPrice = 0
  
    override func viewDidLoad() {
      super.viewDidLoad()
      let Realmproducts = try! Realm().objects(ProductRealm.self)
      for temp in Realmproducts{
      products.append(temp)
      let tempStr = temp.price.removeCharsFromEnd(count: ".0000".length())
      let intPrice = Int(tempStr) ?? 0
      allPrice += intPrice
      print(products)
    }
        
      allPricelabel.text = String(allPrice) +  " ₽"
      busketTableView.reloadData()
    }
    
}


extension BusketViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "busketCell") as! BusketTableViewCell
        let model = products[indexPath.row]
        cell.priceLabel.text = model.price
        cell.colorLabel.text = model.color
        cell.nameLabel.text = model.name
        cell.sizeLabel.text = model.size
        let url = URL(string: "https://blackstarshop.ru/" + model.image)
        let data = try? Data(contentsOf: url!)
        cell.basketImage.image = UIImage(data: data!)
        return cell
    }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete{
      let deleteProduct = products[indexPath.row]
      allPrice -= Int(products[indexPath.row].price.removeCharsFromEnd(count: ".0000".length())) ?? 0
      allPricelabel.text = String(allPrice)
      products.remove(at: indexPath.row)
      try! realm.write {
        realm.delete(deleteProduct)
      }
      tableView.deleteRows(at: [indexPath], with: .top)
    }
  }
    
}


//extension BusketViewController: FourthControllerDelegate{
//  func setProduct(_ product: NSDictionary){
//    products.append(product)
//  }
//}
