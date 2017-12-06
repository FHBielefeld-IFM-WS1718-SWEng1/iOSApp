//
//  ViewController.swift
//  JSONTest
//
//  Created by Dario Leunig on 01.12.17.
//  Copyright © 2017 Papla. All rights reserved.
//
// Tutorial: https://www.youtube.com/watch?v=YY3bTxgxWss

import UIKit

struct Partylist: Decodable {
    let name: String
    let values: [Course]
}

// ? macht die Variablen optional, wenn sie also nicht uebergeben werden, koennen sie nil sein.
struct Course: Decodable{
    let id: Int?
    let name: String?
    let description: String?
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
                let partylist = try
                    JSONDecoder().decode(Partylist.self, from: data)
                for element in partylist.values {
                    print(element)
                }
                // print("ID:", partylist.values[0].id, "Name:",  partylist.values[0].name, "Beschreibung:", partylist.values[0].description)
                
                //let courses = try
                //    JSONDecoder().decode([Course].self, from: data)
                //print(courses)
            } catch let jsonERR {
                print("Error serializing json: ", jsonERR)
            }
            }.resume()
    }
}
