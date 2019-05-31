//
//  VerImagenyMensajeViewController.swift
//  WhatsAppIOS2
//
//  Created by MAC11 on 31/05/19.
//  Copyright © 2019 Carlos Alvarez. All rights reserved.
//

import UIKit
import Firebase


class VerImagenyMensajeViewController: UIViewController {

    @IBOutlet weak var lbMensajeTexto: UILabel!
    @IBOutlet weak var ImagenSnap: UIImageView!
    
    
    @IBOutlet weak var fechasnap: UILabel!
    @IBOutlet weak var Horasnap: UILabel!
    @IBAction func btnRegresar(_ sender: Any) {
        let alerta = UIAlertController(title: "Eliminar mensaje", message: "Desea eliminar el mensaje?", preferredStyle: .alert)
        
        let btnOK = UIAlertAction(title: "Si, eliminar", style: .default, handler: {
            (UIAlertAction) in
            Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("snaps").child(self.snap.id).removeValue()
            
           
            Storage.storage().reference().child("imagenes").child("\(self.snap.imagenID).jpg").delete{
                (error) in
                print("Se elimino la imagen correctamente")
                self.navigationController?.popViewController(animated: true)
            }
        })
        
        let btnCon = UIAlertAction(title: "Mantener", style: .default, handler: {
            (UIAlertAction) in
           Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("snaps").child(self.snap.id).child("visto").setValue("false")
             self.navigationController?.popViewController(animated: true)
            
        })
        
        alerta.addAction(btnOK)
        alerta.addAction(btnCon)
        
        self.present(alerta, animated: true)
    }
 
    var snap = Snap()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbMensajeTexto.text = "Mensaje es :" + snap.mensajes
        ImagenSnap.sd_setImage(with: URL(string: snap.imagenURL), completed: nil)
        fechasnap.text = "la fecha de envio :" + snap.fecha
        Horasnap.text = "la Hora de envio " + snap.hora
        // Do any additional setup after loading the view.
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
