import UIKit
import RealmSwift

protocol FourthControllerDelegate{
  func setProduct(_ product: NSDictionary)
}


class FourthViewController: UIViewController {

  @IBOutlet weak var imagesCollection: UICollectionView!
  var images: [UIImage] = []
  var allImages: [NSDictionary] = []
  var productInfo : NSDictionary = [:]
  var offers: [NSDictionary] = []
  var currentSize: String?
  @IBOutlet weak var pageController: UIPageControl!
  @IBOutlet weak var decsLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var butButton: UIButton!
  @IBOutlet weak var pickerSize: UIPickerView!
 
  var delegate: BusketViewController?
  
  
  @IBAction func goToBusket(_ sender: Any) {
  }
  
  
  @IBAction func tapButton(_ sender: Any) {
//    delegate?.setProduct(productInfo)
    BusketProduct.shared.add(newDict: productInfo, size: currentSize ?? nil)
    let Realmproducts = try! Realm().objects(ProductRealm.self)
    for temp in Realmproducts{
          delegate?.products.append(temp) 
          delegate?.allPrice
         }
    delegate?.busketTableView.reloadData()
  }
  
  
  var currentIndex = 0
  
  override func viewDidLoad() {
        super.viewDidLoad()
      for (index, _) in allImages.enumerated(){
        let stringModel = allImages[index]["imageURL"] as! String
        let url = URL(string: "https://blackstarshop.ru/" + stringModel)
        let data = try? Data(contentsOf: url!)
        let tempImage = UIImage(data: data!)
          images.append(tempImage!)
        }
      self.offers = productInfo["offers"] as! [NSDictionary]
    currentSize = self.offers[0]["size"] as! String
      let newPrice = productInfo["price"] as! String
      priceLabel.text = newPrice.removeCharsFromEnd(count: ".0000".length()) +  " ₽"
      decsLabel.text = productInfo["description"] as! String
      imagesCollection.reloadData()
      pageController.numberOfPages = images.count
      pickerSize.dataSource = self
      pickerSize.delegate = self
    }
  
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//      if let cell = sender as? UIBarButtonItem, let vc = segue.destination as? BusketViewController{
//        //print("pressed on \(subCategories[index.row]["name"])")
//        vc.product = (subCategories[index.row]["id"] as? String) ?? ""
//        vc.allProduct = subCategories[index.row]
//      }
//  }
    
}


extension FourthViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return allImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
        cell.images.image = images[indexPath.item]
        return cell
    }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    currentIndex = Int(scrollView.contentOffset.x / imagesCollection.frame.size.width)
    pageController.currentPage = currentIndex
  }

}

extension FourthViewController: UIPickerViewDataSource, UIPickerViewDelegate{
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return offers.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return offers[row]["size"] as! String
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    currentSize = offers[row]["size"] as! String
  }
}


extension String {
    func removeCharsFromEnd(count:Int) -> String{
        let stringLength = self.count

        let substringIndex = (stringLength < count) ? 0 : stringLength - count

        let index: String.Index = self.index(self.startIndex, offsetBy: substringIndex)

        return String(self[..<index])
    }

    func length() -> Int {
        return self.count
    }
}
