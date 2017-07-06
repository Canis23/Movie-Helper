//
//  MovieTableViewController.swift
//  Movie Helper
//
//  Created by Canis on 2017/6/22.
//  Copyright © 2017年 Canis. All rights reserved.
//

import UIKit


//這個地方要列出現在有什麼電影上影喔～
class MovieTableViewController: UITableViewController, UISearchResultsUpdating{
    

    
    var searchController:UISearchController!
    
    var searchResults:[Movie] = []
    
    //測試用電影陣列
    var movies:[Movie] = [Movie(name: "Maleficent", image: "http://web.vscinemas.com.tw/upload/film/film_20170621006.jpg")]
        /*, Movie(name: "ENEMY", image: "ENEMY.jpg"), Movie(name: "天后開麥拉", image: "天后開麥拉.jpg"), Movie(name: "神偷奶爸3", image: "神偷奶爸3.jpg"), Movie(name: "變形金剛5", image: "變形金剛5.jpg"), Movie(name: "死小孩", image: "死小孩.jpg"), Movie(name: "接線員", image: "接線員.jpg")]*/
    
    //
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        navigationController?.hidesBarsOnSwipe = true
    }
    
    //應該跟在main.storyboard能做的事情差不多ㄏ
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //searchControllor
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search movies..."
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.black
    }
    
    //

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    //Section:cell的分類?
    //此處沒有分類所以return 1
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //有幾個cell , 根據陣列長度回傳
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if searchController.isActive{
            return searchResults.count
        }
        else{
            return movies.count
        }
    }
    
    //Cell裡面要放什麼毛
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell
        
        // Configure the cell...
        //  cell.accessoryType = .disclosureIndicator
        
        //let movie = (searchController.isActive) ? searchResults[indexPath.row] : movies[indexPath.row]
        
        //Label setting
        cell.nameLabel?.text = movies[indexPath.row].name
        cell.nameLabel.layer.cornerRadius = 10
        cell.nameLabel.layer.backgroundColor = UIColor.gray.cgColor
        
        //imageView Setting
        cell.movieImageView.image = UIImage(data: movies[indexPath.row].imageData as Data)
        
        
        
        //cell.movieImageView?.image = UIImage(named: movies[indexPath.row].image)
        
        return cell
    }
    
    //Cell點選後會幹三小
    //showMovieDetail: Main.storyboard 兩個view之間的箭頭 , 他的identifier
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! MovieDetailViewController
                destinationController.movie = (searchController.isActive) ? searchResults[indexPath.row] : movies[indexPath.row]
                self.searchController.isActive = false
                //destinationController.movie = movies[indexPath.row]
                //MovieDetailViewController那邊有一個movie 把這邊的movie丟過去
            }
        }
    }
    
    //search動作
    func filterContent(for searchText: String) {
        searchResults = movies.filter({ (movie) -> Bool in
            let name = movie.name
            let isMatch = name.localizedCaseInsensitiveContains(searchText)
            return isMatch
        })
    }
    
    //search動作後更新View
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        if searchController.isActive {
            return false
        }
        else{
            return true
        }
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
