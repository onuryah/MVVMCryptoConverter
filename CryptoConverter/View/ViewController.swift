//
//  ViewController.swift
//  CryptoConverter
//
//  Created by Ceren Çapar on 1.11.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var cryptoListViewModel : CryptoListViewModel!
    var colorArray = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        self.colorArray = [
            UIColor(red: 104/255, green: 156/255, blue: 145/255, alpha: 1.0),
            UIColor(red: 123/255, green: 134/255, blue: 176/255, alpha: 1.0),
            UIColor(red: 154/255, green: 123/255, blue: 154/255, alpha: 1.0),
            UIColor(red: 165/255, green: 112/255, blue: 123/255, alpha: 1.0),
            UIColor(red: 123/255, green: 167/255, blue: 176/255, alpha: 1.0),
            UIColor(red: 154/255, green: 143/255, blue: 143/255, alpha: 1.0),
        ]
        
        getData()

    }
    
    func getData() {
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        
        Webservice().downloadCurrencies(url: url) { cryptos in
            if let cryptos = cryptos {
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CryptoTableViewCell
        let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(indexPath.row)
        
        cell.priceLabel.text = cryptoViewModel.price
        cell.currencyLabel.text = cryptoViewModel.name
        cell.backgroundColor = self.colorArray[indexPath.row % 6]
        return cell
    }
}

