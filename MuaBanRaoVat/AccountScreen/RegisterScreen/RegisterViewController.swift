//
//  RegisterViewController.swift
//  MuaBanRaoVat
//
//  Created by Thanh Nguyen on 4/6/23.
//

import UIKit

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    
    @IBOutlet weak var upLoadButton: UIButton!
    var avatar: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
    }
    @IBAction func registerAction(_ sender: Any) {
        if !avatar.isEmpty &&
            !txtName.text!.isEmpty && !txtEmail.text!.isEmpty &&
            !txtUserName.text!.isEmpty && !txtPass.text!.isEmpty
        {
            let usn = txtUserName.text!
            let pass = txtPass.text!
            let email = txtEmail.text!
            let name = txtName.text!
            let phone = txtPhone.text!
            let data = "username=\(usn)&pass=\(pass)&&email=\(email)&&name=\(name)&&phone=\(phone)&&avatar=\(avatar)"
            HttpData.registerAccount(data: data, success: {data in
                let jsondecoder = JSONDecoder()
                
                if let respons = try? jsondecoder.decode(ResponseCategory.self, from: data)
                {
                    print(respons.message)
                    if respons.result == 1{
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: false)
                        }
                    }
                }
            }, error: {errorMsg in
                
            })
        }else {
          
            if avatar.isEmpty{
                    self.present(UiHelpers.createAlert(title: "missing image", message: "vui long upload Image truoc khi post"), animated:  false)
            }
            else
            {
            let alert1 = UiHelpers.createAlert(title: "warning missing fields", message: "please fill in missing fields ", buttons: [UIAlertAction(title: "OK", style: UIAlertAction.Style.default)])
            self.present(alert1, animated: true)}
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage
        {
            imageView.image = img
            self.enableUpload()
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func selectImage(_ sender: Any) {
        let img = UIImagePickerController()
        img.delegate = self
        img.sourceType = .photoLibrary
        img.allowsEditing = false
        self.present(img, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func UploadImageAction(_ sender: Any) {
        if imageView.image != nil {
            HttpData.uploadImage(paramName: "avatar", image: imageView.image!,callBack:  {filename in
                
                    self.avatar = filename
                DispatchQueue.main.async {
                    self.upLoadButton.setTitle("đã upload", for: UIControl.State.disabled)
                    self.upLoadButton.isEnabled = false
                }
                
            })
        }
    }
    
    func enableUpload(){
        self.upLoadButton.isEnabled = true
        upLoadButton.setTitle("Avatar upload image", for: UIControl.State.normal)
    }
    
}
