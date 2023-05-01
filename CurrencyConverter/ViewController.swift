//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Roman on 30/04/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var uahLabel: UILabel!
    @IBOutlet weak var plnLabel: UILabel!
    @IBOutlet weak var czklAbel: UILabel!
    @IBOutlet weak var rubLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        let symbols = "CAD,UAH,USD,RUB,CZK,PLN"
        let url = "https://api.apilayer.com/fixer/latest?symbols=\(symbols)&base=EUR"
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue("DWm6b8lAshFUypie2rmY9dAZT40InP3X", forHTTPHeaderField: "apikey")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data,
                                       options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                
                DispatchQueue.main.async {
                    if let rates = jsonResponse["rates"] as? [String : Any] {
                        if let cad = rates["CAD"] as? Double {
                            self.cadLabel.text = String("CAD: \(cad)")
                        }
                        if let uah = rates["UAH"] as? Double {
                            self.uahLabel.text = String("UAH: \(uah)")
                        }
                        if let usd = rates["USD"] as? Double {
                            self.usdLabel.text = String("USD: \(usd)")
                        }
                        if let rub = rates["RUB"] as? Double {
                            self.rubLabel.text = String("RUB: \(rub)")
                        }
                        if let czk = rates["CZK"] as? Double {
                            self.czklAbel.text = String("CZK: \(czk)")
                        }
                        if let pln = rates["PLN"] as? Double {
                            self.plnLabel.text = String("PLN: \(pln)")
                        } 
                    }
                }
                
            } catch {
                print("error")
            }
            
        }

        task.resume()
    }
    
}

