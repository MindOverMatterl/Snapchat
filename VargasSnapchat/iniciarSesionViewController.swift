import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn

class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var signInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureGoogleSignIn()
    }
    
   
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print("Intentando iniciar sesión")
            if error != nil {
                print("Se presentó el siguiente error: \(String(describing: error))")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: {(user, error) in
                    print("Intentando crear un usuario")
                    if error != nil{
                        print("Se presento el siguiente error al crear el usuario: \(error)")
                    }else{
                        print("El usuario fue creado exitosamente")
                    }
                })
            } else {
                print("Inicio de sesión exitoso")
            }
        }
    }
    

    func configureGoogleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }


        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }
    
    
    @IBAction func botongoogle(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                print("Error al iniciar sesión con Google: \(String(describing: error))")
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                print("Error al obtener el ID Token de Google")
                return
            }

            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)

  
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Error al autenticar con Firebase: \(error.localizedDescription)")
                    return
                }

                print("Inicio de sesión con Google exitoso")
            }
        }
    }
    
   
   
}
