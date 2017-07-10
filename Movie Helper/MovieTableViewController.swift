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
    
    var movies:[Movie] = []
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        navigationController?.hidesBarsOnSwipe = true
    }
    
    
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
        connectServer(success: done)
    }
    
    func connectServer(success: @escaping((_ data:[Any]) -> ())){
        let url = URL(string: "http://selab2.ahkui.com:1000/api/MovieHelper/moviebug/movieid")
        let task = URLSession.shared.dataTask(with: url!){  data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else{
                print("data is empty")
                return
            }
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            //            print(json)
            //        if let data = json as! String {
            success(json as! [Any])
            //        }
            
        }
        task.resume()
    }
    func done(_ data:[Any]){
        for i in data {
            let dataa:Movie = Movie()
            
            let onedata = i as! [String:Any]
            if let id = onedata["id"] as? String {
                dataa.id = id
            }
            if let lenth = onedata["lenth"] as? String {
                if(lenth == ""){
                    dataa.time = "-"
                }
                else{
                    dataa.time = lenth
                }
            }
            if let imgurl = onedata["imgurl"] as? String {
                dataa.image = imgurl
                dataa.toNSData()
            }
            if let title = onedata["title"] as? String {
                dataa.name = title
            }
            if let type = onedata["type"] as? [String] {
                if(type[0] == "general"){
                    dataa.rating[0] = "普遍級"
                }
                else if(type[0] == "childview"){
                    dataa.rating[0] = "護片級"
                }
                else if(type[0] == "bigchild"){
                    dataa.rating[0] = "輔導級12+"
                }
                else if(type[0] == "teenager"){
                    dataa.rating[0] = "輔導級15+"
                }
                //else if(type[0] == ""){
                //    dataa.rating[0] = ""
                //}
                else{
                    dataa.rating[0] = "-"
                }
            }
            movies.append(dataa)
            
            //print(dataa.id)
        }
        //print(movies.count)
        tableView.reloadData()
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
        
        var movie = movies[indexPath.row]
        
        movie = (searchController.isActive) ? searchResults[indexPath.row] : movies[indexPath.row]
        
        //Label setting
        cell.nameLabel?.text = movie.name
        cell.nameLabel.layer.cornerRadius = 10
        //cell.nameLabel.layer.backgroundColor = UIColor.gray.cgColor
        
        //imageView Setting
        cell.movieImageView.image = UIImage(data: movie.imageData as Data)
        
        cell.timeLabel?.text = " 片長: \(movie.time)"
        cell.typeLabel?.text = movie.rating[0]
        
        
        
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
