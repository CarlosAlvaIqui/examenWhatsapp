//
//  ListaUsuariosViewController.swift
//  WhatsAppIOS2
//
//  Created by MAC11 on 29/05/19.
//  Copyright © 2019 Carlos Alvarez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SDWebImage

class ListaUsuariosViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var listaUsuarios: UITableView!
    var usuarios:[Usuario] = []
    
    @IBAction func cerrarSesionTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let usuario = usuarios[indexPath.row]
        let usuarioactual = ((Auth.auth().currentUser?.email)!)
//        cell.textLabel?.text = usuario.email
//        cell.imageView?.sd_setImage(with: URL(string: usuario.photoURL), completed: nil)

        if usuarioactual == usuario.email {
            usuarios.remove(at: indexPath.row)
            listaUsuarios.deleteRows(at: [indexPath], with: .fade)
            cell.textLabel?.text = usuario.email
            cell.imageView?.sd_setImage(with: URL(string: usuario.photoURL), completed: nil)
            self.listaUsuarios.reloadData()
        }else{
            cell.textLabel?.text = usuario.email
            cell.imageView?.sd_setImage(with: URL(string: usuario.photoURL), completed: nil)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let aya = usuarios[indexPath.row]
        performSegue(withIdentifier: "seguesnapero", sender: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaUsuarios.delegate = self
        listaUsuarios.dataSource = self
        
        Database.database().reference().child("usuarios").observe(DataEventType.childAdded, with: {(snapshot) in
            print(" gaaa \(snapshot)")
            let usuario = Usuario()
            usuario.email = (snapshot.value as! NSDictionary)["email"] as! String
            usuario.uid = snapshot.key
            usuario.photoURL = (snapshot.value as! NSDictionary)["photoURL"] as! String
            
            self.usuarios.append(usuario)
            self.listaUsuarios.reloadData()

        })
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
