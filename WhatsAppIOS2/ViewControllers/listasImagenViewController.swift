//
//  enviarImagenViewController.swift
//  WhatsAppIOS2
//
//  Created by MAC11 on 29/05/19.
//  Copyright © 2019 Carlos Alvarez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SDWebImage

class listasImagenViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var listaimagen: UITableView!
    var usuarios:[Usuario] = []
    var usuario = Usuario()


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let usuario = usuarios[indexPath.row]
        cell.textLabel?.text = usuario.email
        cell.imageView?.sd_setImage(with: URL(string: usuario.photoURL), completed: nil)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        usuario = usuarios[indexPath.row]
        performSegue(withIdentifier: "segueimagen", sender: usuario)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        listaimagen.delegate = self
        listaimagen.dataSource = self
        
        Database.database().reference().child("usuarios").observe(DataEventType.childAdded, with: {(snapshot) in
            print(" gaaa \(snapshot)")
            let usuario = Usuario()
            usuario.email = (snapshot.value as! NSDictionary)["email"] as! String
            usuario.uid = snapshot.key
            usuario.photoURL = (snapshot.value as! NSDictionary)["photoURL"] as! String
            
            self.usuarios.append(usuario)
            self.listaimagen.reloadData()
        })
        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueimagen"{
            let sigueguienteVC = segue.destination as! EnviarImagencitaViewController
            sigueguienteVC.dat_user = usuario
            //let siguienteVC = segue.destination as! EnviarMensajitoViewController
            //siguienteVC.dat_user = usuario
        }
    }


}
