import UIKit

class SecondViewController: UIViewController {
    var categories2: [NSDictionary] = []
    @IBOutlet weak var CategoriesTabel: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoriesTabel.rowHeight = 100
       // CategoriesTabel.layer.
        CategoriesLoader().loadCategories2{categories in
            self.categories2 = categories
            self.CategoriesTabel.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let index = CategoriesTabel.indexPath(for: cell), let vc = segue.destination as? ThirdViewController{
            print("pressed on \(categories2[index.row]["subcategories"])")
            vc.subCategories = categories2[index.row]["subcategories"] as! [NSDictionary]
        }
    }
}


extension SecondViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CategoriesTableViewCell
        let model = categories2[indexPath.row]
        cell.nameLabel.text = model["name"] as? String
    //    cell.sortOrderLabel.text = model["sortOrder"] as? String
        let stringModel = model["image"] as! String
        let url = URL(string: "https://blackstarshop.ru/" + stringModel)
        let data = try? Data(contentsOf: url!)
        cell.categoriesImage.image = UIImage(data: data!)
        return cell
    }
    
}

