//
//  ContactsViewController.swift
//  Papla
//
//  Created by Dario Leunig on 15.12.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit
import os.log

/**
    # ContactsViewController
    Steuert den TableView mit der Liste an Kontakten
 */
class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    final let url = URL(string: "http://api.dleunig.de/user/contact?api=\(String(describing: myUser.key!))")
    
    /// Verkettet die URL mit dem Token welcher beim Anmelden zurückgegeben wird.
    //final let url = URL(string: "http://api.dleunig.de/party?api=\(String(describing: myUser.key!))")
    
    private var contacts = [Contact]()
    
    /**
        # refreshControl
        Initialisiert ein Aktualisieren des TableView Inhalts
     */
    lazy var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action:
            #selector(ContactsViewController.handleRefresh(_:)),
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                let downloadedContacts = try decoder.decode(Contacts.self, from: data)
                self.contacts = downloadedContacts.contacts
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
        return contacts.count
    }
    
    /**
        Fuellt die TableView Zellen mit Inhalt
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as? ContactCell else {return UITableViewCell()}
        cell.nameButton.setTitle(contacts[indexPath.row].name, for: .normal)
        cell.contactId = contacts[indexPath.row].id
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "addContact":
            os_log("Adding a new contact.", log: OSLog.default, type: .debug)
        case "showContact":
            guard let ShowContactsViewController = segue.destination as? ShowContactsViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedcontactCell = sender as? ContactCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedcontactCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedContact = contacts[indexPath.row]
            ShowContactsViewController.contact = selectedContact
        default:
            break
        }
    }
}
