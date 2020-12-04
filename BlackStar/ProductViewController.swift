import UIKit

class ProductViewController: UIViewController {
    var allProduct: NSDictionary = [:]
    var product: String = ""
    var product2: [NSDictionary] = []
    @IBOutlet weak var collectionViewProduct: UICollectionView!
  
    override func viewDidLoad() {
      super.viewDidLoad()
      ProductLoader().loadProduct(id: product) { (product2) in
        self.product2 = product2
        print(product2)
        print("------------------")
        print(self.allProduct)
        self.collectionViewProduct.reloadData()
      }
      print("adassadasdasdsa")
      print(product)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let cell = sender as? UICollectionViewCell, let index = collectionViewProduct.indexPath(for: cell), let vc = segue.destination as? FourthViewController{
          print("pressed on \(product2[index.row])")
          vc.allImages = (product2[index.row]["productImages"]) as! [NSDictionary]
          print(vc.allImages)
          vc.productInfo = product2[index.row]
//        vc.allProduct = subCategories[index.row]
      }
  }
  
  @IBAction func buyButton(_ sender: Any) {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if let cell = sender as? UICollectionViewCell, let index = collectionViewProduct.indexPath(for: cell), let vc = segue.destination as? FourthViewController{
              print("pressed on \(product2[index.row])")
              vc.allImages = (product2[index.row]["productImages"]) as! [NSDictionary]
              print(vc.allImages)
              vc.productInfo = product2[index.row]
    //        vc.allProduct = subCategories[index.row]
          }
      }
  }
  
}


extension ProductViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
           let w = UIScreen.main.bounds.width / 2 - 20
           return CGSize(width: w, height: w + 40)
           
       }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return product2.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
      
      let model = product2[indexPath.row]
      cell.descriptionLabel.text = model["name"] as? String
      let newPrice = model["price"] as! String
      cell.priceLabel.text = newPrice.removeCharsFromEnd(count: ".0000".length()) +  " ₽"
      let stringModel = model["mainImage"] as! String
      let url = URL(string: "https://blackstarshop.ru/" + stringModel)
      let data = try? Data(contentsOf: url!)
      cell.imageProduct.image = UIImage(data: data!)
        return cell
    }


}
