//
//  enviarMensajeViewController.swift
//  WhatsAppIOS2
//
//  Created by MAC11 on 29/05/19.
//  Copyright © 2019 Carlos Alvarez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SDWebImage

class listasMensajeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var kistamensaje: UITableView!
    var usuarios:[Usuario] = []
    var usuario = Usuario()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let usuario = usuarios[indexPath.row]
        let usuarioactual = ((Auth.auth().currentUser?.email)!)
        
        if usuarioactual == usuario.email {
            usuarios.remove(at: indexPath.row)
            kistamensaje.deleteRows(at: [indexPath], with: .fade)
            cell.textLabel?.text = usuario.email
            cell.imageView?.sd_setImage(with: URL(string: usuario.photoURL), completed: nil)
            self.kistamensaje.reloadData()
        }else{
            cell.textLabel?.text = usuario.email
            cell.imageView?.sd_setImage(with: URL(string: usuario.photoURL), completed: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //usuarito = usuarios[indexPath.row]
        usuario = usuarios[indexPath.row]
        
        performSegue(withIdentifier: "seguemensaje", sender: usuario)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kistamensaje.delegate = self
        kistamensaje.dataSource = self
        
        Database.database().reference().child("usuarios").observe(DataEventType.childAdded, with: {(snapshot) in
            print(" gaaa \(snapshot)")
            let usuario = Usuario()
            usuario.email = (snapshot.value as! NSDictionary)["email"] as! String
            usuario.uid = snapshot.key
            usuario.photoURL = (snapshot.value as! NSDictionary)["photoURL"] as! String
            
            self.usuarios.append(usuario)
            self.kistamensaje.reloadData()
})
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguemensaje"{
            let sigueguienteVC = segue.destination as! EnviarMensajitoViewController
            sigueguienteVC.dat_user = usuario
            //let siguienteVC = segue.destination as! EnviarMensajitoViewController
            //siguienteVC.dat_user = usuario
        }
    }
 

}
