//
//  AddGuestViewController.swift
//  Papla
//
//  Created by Jendrik Müller on 18.01.18.
//  Copyright © 2018 Papla. All rights reserved.
//

import UIKit

class AddGuestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var party: Party!
    
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
        var title: String = contacts[indexPath.row].name!
        for invitation in party.guests! {
            if(invitation.user_id == contacts[indexPath.row].id) {
                title += "👍"
            }
        }
        cell.nameButton.setTitle(title, for: .normal)
        cell.contactId = contacts[indexPath.row].id
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        
        for invitation in party.guests! {
            if(invitation.user_id == contacts[indexPath.row].id) {
                deleteGuest(userId: indexPath.row)
                return
            }
        }
        addGuest(userId: indexPath.row)
    }
    
    func deleteGuest(userId: Int) {
        let headers = [
            "Content-Type": "application/json",
            "Cache-Control": "no-cache",
            "Postman-Token": "8cd4055a-e5b7-ea24-e432-07122ed838d8"
        ]
        let parameters = [
            "userid": userId,
            "partyid": party.id
            ] as [String : Any]
        do {
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            let urlString: String = "http://api.dleunig.de/party/guest?api=" + myUser.key!
            let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "DELETE"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error)
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
            
            dataTask.resume()
        }catch{return}
    }
    
    func addGuest(userId: Int) {
        let headers = [
            "Content-Type": "application/json",
            "Cache-Control": "no-cache",
            "Postman-Token": "8cd4055a-e5b7-ea24-e432-07122ed838d8"
        ]
        let parameters = [
            "userid": userId,
            "partyid": party.id
            ] as [String : Any]
        do {
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            let urlString: String = "http://api.dleunig.de/party/guest?api=" + myUser.key!
            let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error)
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
            
            dataTask.resume()
        }catch{return}
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
