//
//  LoginViewController.swift
//  MuaBanRaoVat
//
//  Created by Thanh Nguyen on 4/3/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    
    var listenerData: DataInterface_Delegate!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func RegisterAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vcRegister = storyboard.instantiateViewController(identifier: "REGIS") as RegisterViewController
        
        self.navigationController?.pushViewController(vcRegister, animated: true)
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        let pass = txtPassword.text!
        let username = txtUsername.text!
        HttpData.loginRequest(data: "username=\(username)&password=\(pass)", success: { data in
            let jsonDecoder = JSONDecoder()
            print(data)
            if let dataUser = try? jsonDecoder.decode(LoginStruct.self, from: data)
            {
                DeviceData.saveToken(token: dataUser.message)
                DeviceData.saveUser(user: data)
                DispatchQueue.main.async {
                    self.listenerData.sendData(user: dataUser)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }, error: {erMsg in
            print(erMsg)
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

    @IBAction func backHomeAction(_ sender: Any) {
        listenerData.popScene()
            self.navigationController?.popViewController(animated: false)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
}
