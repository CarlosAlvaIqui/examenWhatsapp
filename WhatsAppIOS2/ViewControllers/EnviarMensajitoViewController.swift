//
//  EnviarMensajitoViewController.swift
//  WhatsAppIOS2
//
//  Created by MAC11 on 30/05/19.
//  Copyright © 2019 Carlos Alvarez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SDWebImage


class EnviarMensajitoViewController: UIViewController {
    
    var dat_user = Usuario()
    
 
    /*
    
*/
    @IBOutlet weak var txtMensaje: UITextField!
    
    /*@IBAction func btnEnviarMensaje(_ sender: Any) {
        let snap = ["from" : Auth.auth().currentUser?.email ,"mensajes" : txttextoenviar.text!]
        print("5")
        Database.database().reference().child("usuarios").child(dat_user.uid).child("snaps").childByAutoId().setValue(snap)
        print("6")
        self.performSegue(withIdentifier: "segueregresar", sender: nil)    }

*/
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func EnviarMensajeTapped(_ sender: Any) {
        let date = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let horatotal:String = "\(hour):\(minutes):\(seconds)"
        
        let snap = ["from" : Auth.auth().currentUser?.email ,"mensajes" : txtMensaje.text!, "Fecha" : result, "Hora" : horatotal]
       
        Database.database().reference().child("usuarios").child(dat_user.uid).child("snaps").childByAutoId().setValue(snap)
        
        print("6")
       
        self.performSegue(withIdentifier: "segueregresar", sender: nil)
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
