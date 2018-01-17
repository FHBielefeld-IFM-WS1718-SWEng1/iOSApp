//
//  TasksViewController.swift
//  Papla
//
//  Created by Dario Leunig on 17.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit

/**
    # EventsViewController
    Steuert den TableView mit der Liste an Events
 */
class EventsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    final let url = URL(string: "http://api.dleunig.de/party?creator=true&api=\(String(describing: myUser.key!))")

    private var events = [Event]()
    
    /**
        # refreshControl
        Initialisiert ein Aktualisieren des TableView Inhalts
     */
    lazy var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action:
            #selector(EventsViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        
        refreshControl.tintColor = UIColor.darkGray
        
        return refreshControl
    }()
    
    /**
        # handleRefresh
        Wird durch refreshControl aufgerufen. Downloaded JSON erneut und lädt den Inhalt der TableView neu
     */
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        downloadJSON()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.addSubview(self.refreshControl)
        downloadJSON()
    }
    
    /**
        # downloadJSON
        Laedt JSON herrunter und parsed den Inhalt in Objekte
     */
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
                let downloadedEvents = try decoder.decode(Events.self, from: data)
                self.events = downloadedEvents.parties
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("something wrong after downloaded")
            }
            }.resume()
    }
    
    /**
        Zaehlt die Anzahlt der durch den Parser erstelle Events im Array
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    /**
        Fuellt die TableView Zellen mit Inhalt
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as? EventCell else {return UITableViewCell()}
        
        cell.nameLbl.text = events[indexPath.row].name
        cell.whoLbl.text = events[indexPath.row].location
        cell.dateLbl.text = events[indexPath.row].startDate
        cell.descTextView.text = events[indexPath.row].description
        
    /// Code zum Laden Bilder mit einer URL
    /*
        if let imageURL = URL(string: events[indexPath.row].img) {
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
    */
        return cell
    }
}
