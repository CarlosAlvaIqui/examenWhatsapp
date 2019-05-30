//
//  EnviarImagencitaViewController.swift
//  WhatsAppIOS2
//
//  Created by MAC11 on 30/05/19.
//  Copyright © 2019 Carlos Alvarez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class EnviarImagencitaViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    var imagePicker = UIImagePickerController()
    var imagenID = NSUUID().uuidString
    var dat_user = Usuario()

    @IBAction func btnChooseImage(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var ImagenViews: UIImageView!
    

    @IBAction func btnEnviarImagen(_ sender: Any) {
        let imagenesFolder = Storage.storage().reference().child("imagenes")
        
        let imagenData = ImagenViews.image?.jpegData(compressionQuality: 0.50)
        
        let cargarImagen = imagenesFolder.child("\(imagenID).jpg")
        
        
        let date = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let horatotal:String = "\(hour):\(minutes):\(seconds)"
        
        cargarImagen.putData(imagenData!, metadata: nil) {
            (metadata, error) in
            if error != nil {
               print("ocurrio un error al subir la imagen \(error)")
            }else{
                cargarImagen.downloadURL(completion: { (url, error) in
                    guard let enlaceURL = url else{
                        print("Ocurrio un error al obtener informacion de imagen  \(error)  ")
                        return
                    }
                    let snap = ["from" : Auth.auth().currentUser?.email  ,"imagenes" : url?.absoluteString, "Fecha" : result, "Hora" : horatotal, "mensajes" : "" ]
                    Database.database().reference().child("usuarios").child(self.dat_user.uid).child("snaps").childByAutoId().setValue(snap)
                    self.performSegue(withIdentifier: "segueregresar2", sender: nil)

                    
                }
               
                )
                
            }
        }
        
        
        
        
        
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
        ImagenViews.image = image
        ImagenViews.backgroundColor = UIColor.clear
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
