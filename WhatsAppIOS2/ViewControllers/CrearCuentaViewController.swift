//
//  CrearCuentaViewController.swift
//  WhatsAppIOS2
//
//  Created by MAC11 on 29/05/19.
//  Copyright © 2019 Carlos Alvarez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class CrearCuentaViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var btnusuario: UITextField!
    @IBOutlet weak var btnpassword: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var imagenID = NSUUID().uuidString
    
    
    @IBAction func btncancelar(_ sender: Any) {
        
        let alerta = UIAlertController(title: "Desea salir de la creacion de Usuario?", message: "No te vallas chavito", preferredStyle: .alert)
        
        let btnOK = UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
            self.performSegue(withIdentifier: "segueregresar", sender: nil)
        })
        
        let btncancel = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alerta.addAction(btnOK)
        alerta.addAction(btncancel)
        
        self.present(alerta, animated: true)
    }
    
    @IBAction func btnescojerimagen(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func btncrearusuarionuevo(_ sender: Any) {
        let imagenesFolder = Storage.storage().reference().child("imagenes")
        let imagenData = imageView.image?.jpegData(compressionQuality: 0.50)
        let cargarImagen = imagenesFolder.child("\(imagenID).jpg")

        cargarImagen.putData(imagenData!, metadata: nil) {
            (metadata, error) in
            if error != nil {
                
                print("ocurrio un error al subir la imagen \(error)")
            }else{
                cargarImagen.downloadURL(completion: { (url, error) in
                    guard let enlaceURL = url else{
                        return
                    }
                    //self.performSegue(withIdentifier: "seleccionarContactoSegue", sender: url?.absoluteString)
                    print("correcto")
                    
                    Auth.auth().createUser(withEmail: self.btnusuario.text!, password: self.btnpassword.text!, completion: { (user,error) in
                        print("intentemos crear  un nuevo usaurio")
                        if error != nil {
                            print("se presento el siguiente error al crear el usuario: \(error)")
                        }else{
                            print("El usuario fue creado exitosamente")
                            
                            Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                            Database.database().reference().child("usuarios").child(user!.user.uid).child("photoURL").setValue(url?.absoluteString)
                            
                            let alerta = UIAlertController(title: "Se crea un usuario en firebase?", message: "Usuario: \(self.btnusuario.text!) Se creo correctamente.", preferredStyle: .alert)
                            
                            let btnOK = UIAlertAction(title: "Crear", style: .default, handler: { (UIAlertAction) in
                                self.performSegue(withIdentifier: "seguesecreousuario", sender: nil)
                            })
                            
                            let btncancel = UIAlertAction(title: "Cancelar", style: .cancel)
                            
                            alerta.addAction(btnOK)
                            alerta.addAction(btncancel)
                            
                            self.present(alerta, animated: true)
                        }
                    })

                })
            }
        }
            }
    
    
    @IBAction func btnregresar(_ sender: Any) {
        performSegue(withIdentifier: "segueregresar", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
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
