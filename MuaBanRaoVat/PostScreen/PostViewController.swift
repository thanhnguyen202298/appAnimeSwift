//
//  PostViewController.swift
//  MuaBanRaoVat
//
//  Created by Thanh Nguyen on 3/26/23.
//

import UIKit

class PostViewController: UIViewController, DataInterface_Delegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func sendText(text: String) {
        
    }
    func popScene() {
        
    }
    
    @IBOutlet weak var author: UITextField!
    @IBOutlet weak var StoryDescriptiontxt: UITextView!
    @IBOutlet weak var BtnUpload: UIButton!
    @IBOutlet weak var Pricetxt: UITextField!
    @IBOutlet weak var StoryNametxt: UITextField!
    var image: String = ""
    var cate: String = ""
    
    @IBOutlet weak var iconStory: UIImageView!
    
    @IBAction func PostStoryAction(_ sender: Any) {
        if(!image.isEmpty && !Pricetxt.text!.isEmpty && !author.text!.isEmpty
           && !StoryNametxt.text!.isEmpty && !cate.isEmpty && !StoryDescriptiontxt.text!.isEmpty){
            let title = StoryNametxt.text!
            let price = Pricetxt.text!
            let desc = StoryDescriptiontxt.text!
            let author = author.text!
          
            HttpData.postStory(data: "title=\(title)&price=\(price)&desc=\(desc)&author=\(author)&cate=\(cate)&image=\(image)", success: {data in
               
                let jsondecode = JSONDecoder()
                if let d = try? jsondecode.decode(ResponseBase.self, from: data)
                {
                    if (d.result == 1){
                        DispatchQueue.main.async {
                            self.StoryNametxt.text = ""
                            self.Pricetxt.text = ""
                            self.StoryDescriptiontxt.text = ""
                            self.author.text = ""
                    
                            
                            self.present(UiHelpers.createAlert(title: "Posted Success", message: "Đã đăng thành công"), animated: false)
                        }
                       
                    }
                }
            }, error: {ermsg in
                
            })
        }
        else {
            if image.isEmpty{
                self.present(UiHelpers.createAlert(title: "missing image", message: "vui long upload Image truoc khi post"), animated:  false)
            }else
            {
            let alert1 = UiHelpers.createAlert(title: "warning missing fields", message: "please fill in missing fields ", buttons: [UIAlertAction(title: "OK", style: UIAlertAction.Style.default)])
            self.present(alert1, animated: true)}
        }
        
    }
    
    func sendData(data: Data) {
        
    }
    
    func sendData(user: LoginStruct) {
        
    }
    
    @IBAction func uploadButton(_ sender: Any) {
        if iconStory.image != nil {
            HttpData.uploadImage(paramName: "avatar", image: iconStory.image!,callBack:  {filename in
                
                    self.image = filename
                
                DispatchQueue.main.async {
                    self.BtnUpload.setTitle("đã upload", for: UIControl.State.disabled)
                    self.BtnUpload.isEnabled = false
                }
                
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gotoLogin()
        // Do any additional setup after loading the view.
        
        UiHelpers.bindMenus(callback: {cats in
            listCate = cats
            DispatchQueue.main.async {
                self.setupMenuButton()
            }
        })
    }
    var listCate: [String] = ["Tất cả"]
    
    @IBOutlet weak var menuButton: UIButton!
    func setupMenuButton(){
        menuButton.setTitle("Categories", for: UIControl.State.normal)
            let listMenu = listCate.map { nameCate in
                UIAction(title: nameCate, handler: closureMenu)
            }
        menuButton.menu = UIMenu(children: listMenu)
    }
    
    func closureMenu(action: UIAction){
        self.updateMenuChanges(menuId: action.title)
     }
    
    func updateMenuChanges(menuId: String){
        cate = menuId.replacingOccurrences(of: " ", with: "_")
        menuButton.setTitle(menuId, for: UIControl.State.normal)
    }

    func gotoLogin(){
        let token = DeviceData.getToken()
        if(token.count > 1){
            return
        }
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = sb.instantiateViewController(identifier: "LOGINVC") as LoginViewController
        loginVC.listenerData = self
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func clickToSelectImage(_ sender: Any) {
        let img = UIImagePickerController()
        img.delegate = self
        img.sourceType = .photoLibrary
        img.allowsEditing = false
        self.present(img, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage
        {
            iconStory.image = img
        }

        self.enableUpload()
        self.dismiss(animated: true)
        
    }
    
    func enableUpload(){
        self.BtnUpload.isEnabled = true
        BtnUpload.setTitle("upload image", for: UIControl.State.normal)
    }
}
