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
        cell.textLabel?.text = usuario.email
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        listaUsuarios.delegate = self
        listaUsuarios.dataSource = self
        
        Database.database().reference().child("usuarios").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
        })
        /*
        let usuario = Usuario()
    usuario.email = (snapshot.value as! NSDictionary)["email"] as! String
        usuario.uid = snapshot.key
        self.usuarios.append(usuario)
        self.listaUsuarios.roloadData()
        // Do any additional setup after loading the view.*/
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
