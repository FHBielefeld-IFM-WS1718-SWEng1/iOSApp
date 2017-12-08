//
//  ViewController.swift
//  JSONTest
//
//  Created by Dario Leunig on 01.12.17.
//  Copyright © 2017 Papla. All rights reserved.
//
// Tutorial: https://www.youtube.com/watch?v=YY3bTxgxWss
// Tutorial: https://www.youtube.com/watch?v=d9LtFtia4vc&t=1132s

import UIKit

class PartyViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    final let url = URL(string: "file:///Users/dleunig/Desktop/test.json")
    private var parties = [Party]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON()
    }
    
    func downloadJSON() {
        /* "guard" ist wie eine if-Abfrage, ist die Bedingung nicht erfuellt, wird die Funktion vorzeitig beendet.
         * Beispiel:
         *
         * guard x < 150 else {
         * return
         * }
         *
         * Quelle: https://codingtutor.de/swift-2-0-guard-statements-so-validierst-du-variablen/
         */
        
        //guard let url = URL(string: jsonUrlString) else { return }
        guard let downloadURL = url else { return }
        
        /* URLSession -> Bietet zahlreiche Möglichkeiten mit Netzwerkprotokollen zu kommunizieren
         * shared -> Lädt den Inhalt einer URL in den Speicher
         * dataTask -> Ruft den Inhalt der URL auf
         */
        
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("something is wrong")
                return
            }
            print("downloaded")
            do
            {
                let decoder = JSONDecoder()
                let downloadedParties = try decoder.decode(Parties.self, from: data)
                self.parties = downloadedParties.values
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("something wrong after downloaded")
            }
            }.resume()
    }
    
    
    // Diese beiden Methoden werden benoetigt, um UITableViewDataSource verwenden zu koennen.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PartyCell") as? PartyCell else {return UITableViewCell()}
        
        cell.nameLbl.text = parties[indexPath.row].name
        cell.whoLbl.text = parties[indexPath.row].who
        cell.dateLbl.text = parties[indexPath.row].date
        cell.descTextView.text = parties[indexPath.row].description
        
        if let imageURL = URL(string: parties[indexPath.row].img) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imgImageView.image = image
                    }
                }
            }
        }
        
        return cell
    }
}
