import UIKit

class WarehouseScreen: UIViewController {
    
    var warehouse_info : [String: Any]?
    var filteredProducts = [[String: Any]]()
    var products = [[String: Any]]()
    
    lazy var searchController : UISearchController = {
        let search = UISearchController()
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search for an Item"
        search.searchBar.sizeToFit()
        search.searchBar.searchBarStyle = .prominent
        search.searchBar.delegate = self
        return search
    }()
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(InventoryCell.self, forCellReuseIdentifier: InventoryCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        view.backgroundColor = .black
        navigationItem.searchController = searchController
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // attaching our table view all over our screen
        tableView.frame = view.bounds
    }
}

extension WarehouseScreen: UITableViewDataSource, UITableViewDelegate {
    // number of rows
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if isFiltering() {
             return filteredProducts.count
         }
         return products.count
     }

    // setting upthe row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // this is our cell function for each cell in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // creating and setting up the cell based on our cusom cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InventoryCell.identifier,
                                                       for: indexPath) as? InventoryCell else { return UITableViewCell() }
         var currentProduct: String
        cell.backgroundColor = .black
         if isFiltering() {
            currentProduct = filteredProducts[indexPath.row]["Name"] as! String
             cell.configure(text: currentProduct)
         } else {
            cell.configure(text: products[indexPath.row]["Name"] as! String)
         }
        return cell
    }
    /*
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if isFiltering() {
             delegate.retractMajor(majorName: filteredMajors[indexPath.row])
         } else {
             delegate.retractMajor(majorName: majors[indexPath.row])
         }
         navigationController?.popViewController(animated: true)
     }
*/
}

extension WarehouseScreen: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContent(searchText: searchBar.text!)
    }
}

extension WarehouseScreen: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContent(searchText: searchBar.text!)
    }
}

extension WarehouseScreen {
    func filterContent (searchText: String) {
        filteredProducts = products.filter({ (str: [String: Any]) -> Bool in
            if isSearchBarEmpty() {
                filteredProducts = products
                return false
            } else {
                let updated = str["Name"] as! String
                return updated.lowercased().contains(searchText.lowercased())
            }
        })
        // reloading the table
        tableView.reloadData()
    }
    // check if search abr is empty
    func isSearchBarEmpty () -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
}

// checking if the searchbar is active
extension WarehouseScreen {
    func isFiltering() -> Bool {
        return searchController.isActive && !isSearchBarEmpty()
    }
}
