//
//  ViewController.swift
//  VargasSnapchat
//
//  Created by Albert Vargas on 16/10/24.
//

import UIKit
import FirebaseAuth
import Darwin


class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!,password: passwordTextField.text!) {(user, error) in print("Intentando iniciar sesion")
            if error != nil {
                print("Se presento el siguiente error: \(String(describing: error) )")
                
            }else{
                print("Inicio de sesion exitoso")
            }
        }
        
    }


}

