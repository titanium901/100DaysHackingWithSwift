//
//  TableViewController.swift
//  MilestoneProject13-15
//
//  Created by Yury Popov on 05/07/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    
    
    var countries = [Country]()
    var flags = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupUI()
        

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return countries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath) as? CountryTableViewCell else {
            fatalError()
        }

        let country = countries[indexPath.row]
        cell.name.text = country.name
        cell.imageCountry.image = UIImage(named: country.name)
//        cell.imageCountry.layer.backgroundColor = UIColor.lightGray.cgColor
        cell.imageCountry.layer.borderWidth = 5
        cell.imageCountry.layer.borderColor = UIColor.black.cgColor
        cell.capital.text = country.capital
        cell.currency.text = country.currency
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailTableViewController {
            vc.country = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // Достаем данные из json
    func fetchData() {
        guard let path = Bundle.main.path(forResource: "country", ofType: "json") else { return }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return }
        let decoder = JSONDecoder()
        
        if let jsonCounries = try? decoder.decode(Countries.self, from: data) {
            countries = jsonCounries.countries
            saveCountyNames(countryes: countries)
        }
    }
    
    func saveCountyNames(countryes: [Country]) {
        for country in countryes {
            flags.append(country.name)
        }
    }
    
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
