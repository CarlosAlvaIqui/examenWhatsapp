
import UIKit
import Firebase

class MensajeseImagenesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    

    @IBOutlet weak var tablaSnaps: UITableView!
    var snaps:[Snap] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        let snap = snaps[indexPath.row]
//        cell.textLabel?.text = snap.from
//        return cell
        let cell = UITableViewCell()
        let snap = snaps[indexPath.row]
        if snaps.count == 0{
            cell.textLabel?.text = "No tiene snaps 😭"
            return cell
            
        }else{
            cell.textLabel?.text = snap.from
            return cell
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablaSnaps.delegate = self
        tablaSnaps.dataSource = self
        print((Auth.auth().currentUser?.uid)!)
        Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("snaps").observe(DataEventType.childAdded, with: { (snapshot) in
            print("000000000000000000000")
            let snap = Snap()
            snap.from = (snapshot.value as! NSDictionary)["from"] as! String
            self.snaps.append(snap)
            self.tablaSnaps.reloadData()
        })
        
        
        print("ga3333")
        // Do any additional setup after loading the view.
    }
    
}
