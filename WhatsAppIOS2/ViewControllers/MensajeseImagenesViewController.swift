
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
            if snap.visto == "false"{
                cell.textLabel?.text = snap.from
                cell.backgroundColor = UIColor.red
            }else{
            if snap.imagenURL == "" {
                cell.textLabel?.text = snap.from
                cell.backgroundColor = UIColor.cyan
                cell.detailTextLabel?.text = "este es una imagen"
            }else{
                cell.textLabel?.text = snap.from
                cell.backgroundColor = UIColor.yellow
                }
            }
            
            return cell
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "segueImageneMensaje", sender: snap)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablaSnaps.delegate = self
        tablaSnaps.dataSource = self
        print((Auth.auth().currentUser?.uid)!)
        Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("snaps").observe(DataEventType.childAdded, with: { (snapshot) in
            print("000000000000000000000")
            let snap = Snap()
            snap.mensajes = (snapshot.value as! NSDictionary)["mensajes"] as! String
            snap.from = (snapshot.value as! NSDictionary)["from"] as! String
            snap.imagenURL = (snapshot.value as! NSDictionary)["imagenes"] as! String
            snap.fecha = (snapshot.value as! NSDictionary)["Fecha"] as! String
            snap.hora = (snapshot.value as! NSDictionary)["Hora"] as! String
            snap.id = snapshot.key
            snap.visto = (snapshot.value as! NSDictionary)["visto"] as! String
            snap.imagenID = (snapshot.value as! NSDictionary)["imagenID"] as! String
            self.snaps.append(snap)
            self.tablaSnaps.reloadData()
            let x =  (snapshot.value as! NSDictionary)["imagenes"] as! String
            print("Esta es la X gaaaaaa \(snap.imagenURL)")
        })
        Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("snaps").observe(DataEventType.childRemoved, with: { (snapshot) in
            var iterator = 0
            for snap in self.snaps{
                if snap.id == snapshot.key{
                    self.snaps.remove(at: iterator)
                }
                iterator += 1
            }
            self.tablaSnaps.reloadData()
        })
        
        
        print("ga3333")
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueImageneMensaje" {
            let siguienteVC = segue.destination as! VerImagenyMensajeViewController
            siguienteVC.snap = sender as! Snap
        }
    }
    
}
