//
//  ViewController.swift
//  JSONTest
//
//  Created by Dario Leunig on 01.12.17.
//  Copyright © 2017 Papla. All rights reserved.
//
// Tutorial: https://www.youtube.com/watch?v=YY3bTxgxWss

import UIKit

struct Party: Decodable{
    let name: String
    let values: Array<String>
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrlString = "http://api.dleunig.de/parties"
        
        /* "guard" ist wie eine if-Abfrage, ist die Bedingung nicht erfuellt, wird die Funktion vorzeitig beendet.
         * Beispiel:
         *
         * guard x < 150 else {
         * return
         * }
         *
         * Quelle: https://codingtutor.de/swift-2-0-guard-statements-so-validierst-du-variablen/
         */
        
        guard let url = URL(string: jsonUrlString) else {
            return
        }
        
        /* URLSession -> Bietet zahlreiche Möglichkeiten mit Netzwerkprotokollen zu kommunizieren
         * shared -> Lädt den Inhalt einer URL in den Speicher
         * dataTask -> Ruft den Inhalt der URL auf
         */
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else {
                return
            }
            
            /*
             * JSONDecoder -> Decodiert Instanzen aus JSON-Objekten
             * decode -> Gibt gewuenschten Wert aus JSON-Objekt zurueck
             */
            
            do {
                let party = try
                    JSONDecoder().decode(Party.self, from: data)
                print(party.name)
            } catch let jsonERR {
                print("Error serializing json: ", jsonERR)
            }
        }.resume()
    }
}

