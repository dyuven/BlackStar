import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var subcategoriesTable: UITableView!
    var subCategories: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subcategoriesTable.rowHeight = 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let index = subcategoriesTable.indexPath(for: cell), let vc = segue.destination as? ProductViewController{
            print("pressed on \(subCategories[index.row]["name"])")
          vc.product = (subCategories[index.row]["id"] as? String) ?? ""
          vc.allProduct = subCategories[index.row]
        }
    }
}


extension ThirdViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subcategoriesCell") as! SubcategoriesTableViewCell
        let model = subCategories[indexPath.row]
        cell.subcategoriesLabel.text = model["name"] as? String
        let stringModel = model["iconImage"] as! String
        let url = URL(string: "https://blackstarshop.ru/" + stringModel)
        let data = try? Data(contentsOf: url!)
        cell.subcategoriesImage.image = UIImage(data: data!)
        return cell
    }
    
}

