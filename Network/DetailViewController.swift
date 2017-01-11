//
//  DetailViewController.swift
//  Network
//
//  Created by mreport on 2017/1/10.
//  Copyright © 2017年 Beijing Minority Report Information Technology Co., Ltd. All rights reserved.
//

import Alamofire
import UIKit

class DetailViewController: UITableViewController {

    enum Section : Int {
        case headers, body
    }
    
    var request: Alamofire.Request? {
        didSet {
            oldValue?.cancel()
            
            title = request?.description
            refreshControl?.endRefreshing()
            headers.removeAll()
            body = nil
            elapsedTime = nil
        }
    }
    
    var headers: [String: String] = [:]
    var body: String?
    var elapsedTime: TimeInterval?
    var segueIdentifier: String?
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle  = .decimal
        return formatter
    } ()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.blue
        refreshControl?.addTarget(self, action: #selector(DetailViewController.refresh), for: .valueChanged)
        
        self.tableView = UITableView(frame:CGRect(x: 0, y: 20, width: 100, height: 200), style:UITableViewStyle.plain)
//        self.tableView =
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        refresh()
    }

    func refresh() {
        guard let request = request else {
            return
        }
        
        refreshControl?.beginRefreshing()
        let start = CACurrentMediaTime()
        
        let requestComplete: (HTTPURLResponse?, Result<String>) -> Void = { response, result in
            let end = CACurrentMediaTime()
            self.elapsedTime = end - start
            if let response = response {
                for (field, value) in response.allHeaderFields {
                    self.headers["\(field)"] = "\(value)"
                }
            }
            
            if  let segueIdentifier = self.segueIdentifier {
                switch segueIdentifier {
                case "GET", "POST", "PUT", "DELETE":
                    self.body = result.value
                case "DOWNLOAD":
                    self.body = self.downloadedBodyString()
                default:
                    break
                }
            }
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
        
        if let request = request as? DataRequest {
            request.responseString { response in
                requestComplete(response.response, response.result)
            }
        } else if let request = request as? DownloadRequest {
            request.responseString { responses in
                requestComplete(responses.response, responses.result)
            }
        }
        
    }
    
    private func downloadedBodyString() -> String {
        let fileManager = FileManager.default
        let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        
        do {
            let contents = try fileManager.contentsOfDirectory(at: cachesDirectory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            if let fileURL = contents.first, let data = try? Data(contentsOf: fileURL) {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                let prettyData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                
                if let prettyString = String(data: prettyData, encoding: String.Encoding.utf8) {
                    try fileManager.removeItem(at: fileURL)
                    return prettyString
                }
            }
            
        } catch {
            // No-op
        }
        return ""
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch Section(rawValue: section)! {
        case .headers:
            return headers.count
        case .body:
            return body == nil ? 0 : 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch Section(rawValue: (indexPath as NSIndexPath).section)! {
        case .headers:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header")!
            let field = headers.keys.sorted(by: <)[indexPath.row]
            let value = headers[field]
            
            cell.textLabel?.text = field
            cell.detailTextLabel?.text = value
            
            return cell
        case .body:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Body")!
            cell.textLabel?.text = body
            
            return cell
        }
    }
 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.tableView(tableView, numberOfRowsInSection: section) == 0 {
            return ""
        }
        switch Section(rawValue: section)! {
        case .headers:
            return "Headers"
        case .body:
            return "Body"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Section(rawValue: (indexPath as NSIndexPath).section)! {
        case .body:
            return 300
        default:
            return tableView.rowHeight
        }
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if Section(rawValue: section) == .body, let elapsedTime = elapsedTime {
            let elapsedTimeText = DetailViewController.numberFormatter.string(from: elapsedTime as NSNumber) ?? "???"
            return "Elapsed Time: \(elapsedTimeText) sec"
        }
        return ""
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
