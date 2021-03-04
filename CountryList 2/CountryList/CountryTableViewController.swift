//
//  CountryTableViewController.swift
//  FoodTracker
//
//  Created by Eric on 4/15/19.
//

import UIKit
import os.log


class CountryTableViewController: UITableViewController {

    //MARK: Properties
    
    var countries = [Country]() // intializes an empty array of country objects
    var numEntries = 200 // number of entries to be displayed
    var isLoadingCountries = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        loadCountries()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // it will only have 1 section
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CountryTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        
        // Fetches the appropriate country for the data source layout.
        let country = countries[indexPath.row]
        
        cell.idLabel.text = country.id
        cell.nameLabel.text = country.name
        cell.citizenLabel.text = country.citizen
        cell.datesLabel.text = country.dates
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        }
        
        return cell

    }
    
/*
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            countries.remove(at: indexPath.row)
            saveCountries()
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

    
    
    //MARK: Private Methods
    
    
    // Loads the country data from the API
    func loadCountries() {
        self.isLoadingCountries = true
        let link: String = "https://country.register.gov.uk/records.json?page-size=" + String(self.numEntries)
        makeGetCall(link: link)
    }
    
    // updates the data table - has to be its own function so that it can be executed
    // right after the completion handler has retrieved the data
    // idea from https://grokswift.com/completion-handler-faqs/#data_out
    func updateDataTable(data: [String: Any]) {
        for key: String in data.keys {
            let id: String = key
            guard let elem: [String: Any] = data[key]! as? [String : Any] else {
                print("Error: could not get elem")
                return
            }
            guard let itemList: [[String: Any]] = elem["item"]! as? [[String: Any]] else {
                print("Error: could not get itemList")
                return
            }
            let item: [String: Any] = itemList[0]
            guard let name: String = item["official-name"] as? String else {
                print("Error: could not get name")
                return
            }
            guard let citizen: String = item["citizen-names"] as? String else {
                print("Error: could not get citizen")
                return
            }
            let start: String = item["start-date"] as? String ?? "unknown"
            let end: String = item["end-date"] as? String ?? "present"
            let dates: String = start + " to " + end
            
            guard let country = Country(id: id, name: name, citizen: citizen, dates: dates) else {
                fatalError("Unable to instantiate country " + key)
            }
            countries += [country]
        }
        self.isLoadingCountries = false
        DispatchQueue.main.async { // the following line has to be in this statement - from https://stackoverflow.com/questions/44767778/main-thread-checker-ui-api-called-on-a-background-thread-uiapplication-appli
            self.tableView.reloadData()
        }
    }
    
    // from https://gist.github.com/cmoulton/149b03b5ea2f4c870a44526a02618a30
    func makeGetCall(link: String) {
        // Set up the URL request
        let todoEndpoint: String = link
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) { // completionHandler code is implied
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else {
                    print("error trying to convert data to JSON")
                    return
                }
                // now we have the todo
                self.updateDataTable(data: todo)
                
                // the todo object is a dictionary from String's to Any's
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
    }
  

    
    
}
