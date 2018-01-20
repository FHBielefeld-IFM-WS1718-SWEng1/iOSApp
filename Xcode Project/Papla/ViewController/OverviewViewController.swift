//
//  ViewController.swift
//  Papla
//
//  Created by Dario Leunig on 17.11.17.
//  Copyright © 2017 Papla. All rights reserved.
//

import UIKit

/**
 View, der das Dashboard beinhaltet
 */
class OverviewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var leadingContraint: NSLayoutConstraint!
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    var menuShowing = false
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    final let url = URL(string: "http://api.dleunig.de/party?api=\(String(describing: myUser.key!))")
    
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
        
        setMenuProperties()
        
        //setCustomBackground()
        setCustomShadow()
        setCustomBackImage()
        self.tableView.addSubview(self.refreshControl)
        downloadJSON()
        
        if(myUser.profilepicture != nil) {
            setProfilePicture(pictureId: myUser.profilepicture!)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userNameLabel.text = myUser.name
    }
    
    func setProfilePicture(pictureId: String) {
        let headers = [
            "Cache-Control": "no-cache",
            "Postman-Token": "e342f642-1863-4f89-6eb6-933b8609ca24"
        ]
        
        var urlString: String = "http://api.dleunig.de/image/" + pictureId + "?api=" + myUser.key!
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil, response != nil else {
                print("something is wrong")
                return
            }
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse)
            print("downloaded")
            var picture: String = ""
            do {
                let decoder = JSONDecoder()
                let downloadedPicture = try decoder.decode(Picture.self, from: data)
                picture = downloadedPicture.data
                
            }catch {
                print("JSON Error")
                return
            }
            
            DispatchQueue.main.async {
                let dataDecoded : Data = Data(base64Encoded: picture, options: .ignoreUnknownCharacters)!
                let decodedimage = UIImage(data: dataDecoded)
                self.profilePicture.image = decodedimage
            }
        })
        
        dataTask.resume()
    }
    
    /**
     Ausloggen des Benutzers und rückkehr zum Startbildschirm
     JM
    */
    @IBAction func logoutButton(_ sender: Any) {
        let headers = [
            "Cache-Control": "no-cache",
            "Postman-Token": "374d7602-d864-f029-bc2e-544308d23924"
        ]
        let myUrl :String = "http://api.dleunig.de/logout?api=" + myUser.key!
        let request = NSMutableURLRequest(url: NSURL(string: myUrl)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "logout", sender: self)
                }
            }
        })
        
        dataTask.resume()
    }
    
    /**
    Aktion beim Klick auf den Dashboard Button
    */
    @IBAction func showDashboard(_ sender: Any) {
        closeMenu()
    }
    
    
    /**
    Aktion beim Klick auf den Menubutton
    */
    @IBAction func MenuButton(_ sender: Any) {
        if(menuShowing) {
            closeMenu()
        }else {
            openMenu()
        }
    }
    
    // MARK: - Menu
    
    /**
    Oeffnet das Menue mit einer Animation
    */
    func openMenu() {
        leadingContraint.constant = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        menuShowing = !menuShowing
    }
    
    /**
    Schliesst das Menue mit einer Animation
    */
    func closeMenu() {
        leadingContraint.constant = -340
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        menuShowing = !menuShowing
    }
    
    /**
    Schatten des Menues
    */
    func setMenuProperties() {
        menuView.layer.shadowOpacity = 0.5
        menuView.layer.shadowRadius = 6
    }
    
    // MARK: - Navigation
    
    /**
    Veraendert den Text bei zurueck Button auf "", damit nur der Pfeil angezeigt wird.
    */
    func setCustomBackImage() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    /**
    Hintergrundbild der Navigation.
    */
    func setCustomBackground() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navbar_background.png"), for: .default)
    }
    
    /**
    Schatten unter der Navigation durch leeres Bild ersetzten, somit wird kein Schatten angezeigt.
    */
    func setCustomShadow() {
        navigationController?.navigationBar.shadowImage = UIImage()
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
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "showMyParty":
            guard let PartyViewController = segue.destination as? PartyViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedEventCell = sender as? EventCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            guard let indexPath = tableView.indexPath(for: selectedEventCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedEvent = events[indexPath.row]
            PartyViewController.event = selectedEvent
            
            
        default:
            break
        }
    }
}
