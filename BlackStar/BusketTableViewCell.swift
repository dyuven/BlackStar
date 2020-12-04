import UIKit

class BusketTableViewCell: UITableViewCell {
  
  @IBOutlet weak var basketImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var sizeLabel: UILabel!
  @IBOutlet weak var colorLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
