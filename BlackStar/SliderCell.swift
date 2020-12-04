import UIKit

class SliderCell: UICollectionViewCell {
  @IBOutlet weak var images: UIImageView!
    
  var image: UIImage! {
    didSet{
      images.image = image
    }
  }
}
