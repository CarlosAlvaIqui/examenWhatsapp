//
//  ViewController.swift
//  WhatsAppIOS2
//
//  Created by MAC11 on 29/05/19.
//  Copyright © 2019 Carlos Alvarez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SDWebImage



class IniciarSesionViewController: UIViewController {
   

    @IBAction func btnseguecrearcuenta(_ sender: Any) {
        performSegue(withIdentifier: "seguecrearusuario", sender: nil)
    }
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
   
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
            print("Intentamos iniciar sesion")
            if error != nil {
                print("Se presento el siguiente error: \(error)")
                
                let alerta = UIAlertController(title: "El usuario no existe desea crear uno?", message: "Usuario: \(self.emailTextField.text!) Se creo correctamente.", preferredStyle: .alert)
                
                let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: { (UIAlertAction) in
                    self.performSegue(withIdentifier: "seguecrearusuario", sender: nil)
                })
                
                let btnCancelation = UIAlertAction(title: "Cancelar", style: .cancel)
                
                alerta.addAction(btnCancelation)
                alerta.addAction(btnOK)
                self.present(alerta, animated: true)
                
            }else{
                print(" Inicio de sesion exitoso")
                self.performSegue(withIdentifier: "seguelogueo", sender: nil)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }



}

