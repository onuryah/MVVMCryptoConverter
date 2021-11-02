//
//  WebService.swift
//  CryptoConverter
//
//  Created by Ceren Çapar on 1.11.2021.
//

import Foundation

class Webservice {
    func downloadCurrencies(url : URL, completion : @escaping([CryptoCurrency]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }else {
                if let data = data {
                   let cryptoList = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
                    
                    if let cryptoList = cryptoList {
                        completion(cryptoList)
                    }
                }
            }
        }.resume()
    }
}
