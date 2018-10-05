//
//  ShelterTableViewController.swift
//  Earthquake
//
//  Created by D7703_17 on 2018. 10. 5..
//  Copyright © 2018년 D7703_17. All rights reserved.
//

import UIKit

class ShelterTableViewController: UITableViewController, XMLParserDelegate{
      
      @IBOutlet var shelterTableView: UITableView!
      var item:[String:String] = [:]
      var elements:[[String:String]] = []
      var currentElement = ""

    override func viewDidLoad() {
        super.viewDidLoad()
      shelterTableView.delegate = self
      shelterTableView.dataSource = self
      
      if let path = Bundle.main.url(forResource: "Shelter", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                  parser.delegate = self
                  
                  if parser.parse() {
                        print("parse succeed")
                        print(elements)
                  } else {
                        print("parse failed")
                  }
            }
      } else {
            print("xml file not found")
      }
    }
      
      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return elements.count
      }
      
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = shelterTableView.dequeueReusableCell(withIdentifier: "Shelter", for: indexPath)
            
            let myItem = elements[indexPath.row]
            
            let ctprvn_nm = cell.viewWithTag(1) as! UILabel
            let sgg_nm = cell.viewWithTag(2) as! UILabel
            let vt_acmdfclty_nm = cell.viewWithTag(3) as! UILabel
            let dtl_adres = cell.viewWithTag(4) as! UILabel
            let fclty_ar = cell.viewWithTag(5) as! UILabel
            let xcord = cell.viewWithTag(6) as! UILabel
            let ycord = cell.viewWithTag(7) as! UILabel
            let mngps_nm = cell.viewWithTag(8) as! UILabel
            
            ctprvn_nm.text = myItem["ctprvn_nm"]
            sgg_nm.text = myItem["sgg_nm"]
            vt_acmdfclty_nm.text = myItem["vt_acmdfclty_nm"]
            dtl_adres.text = myItem["dtl_adres"]
            fclty_ar.text = myItem["fclty_ar"]
            xcord.text = myItem["xcord"]
            ycord.text = myItem["ycord"]
            mngps_nm.text = myItem["mngps_nm"]
            
            return cell
      }
      
      func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            
            currentElement = elementName
            
            print("currentElement = \(elementName)")
      }
      
      func parser(_ parser: XMLParser, foundCharacters string: String) {
            let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            print("data = \(data)")
            if !data.isEmpty {
                  item[currentElement] = data
            }
      }
      
      func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
            if elementName == "row" {
                  elements.append(item)
            }
      }
}

