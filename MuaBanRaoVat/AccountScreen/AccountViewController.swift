//
//  AccountViewController.swift
//  MuaBanRaoVat
//
//  Created by Thanh Nguyen on 3/26/23.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataInterface_Delegate {
    func sendData(user: LoginStruct) {
        
        loadData()
    }
    
    func sendText(text: String) {
        
    }
    
    func sendData(data: Data) {
        
    }
    
    func popScene() {
        tabBarController?.selectedIndex = 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listStoryOwe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = storyOwnTable.dequeueReusableCell(withIdentifier: "OWESTORY") as! OweTableViewCell
        let item = listStoryOwe[indexPath.row]
        cell.setName(name: item.title)
        cell.setImage(url: item.image)
        return cell
    }
    
    @IBOutlet weak var storyOwnTable: UITableView!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtPhone: UILabel!
    @IBOutlet weak var UserNametxt: UILabel!
    @IBOutlet weak var UserAvatar: UIImageView!
    
    var listStoryOwe: [Story] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyOwnTable.dataSource = self
        storyOwnTable.delegate = self
        loadData()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        gotoLogin()
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
    
    func loadData(){
        bindUser()
        HttpData.getMyPost(success: {data in
            self.bindStoryResponse(data: data)
        }, error: {erMsg in
            
        })
    }
    
    @IBAction func LogInOutAction(_ sender: Any) {
        DeviceData.clearToken()
        DeviceData.clearUser()
        bindUser()
        listStoryOwe = []
        self.storyOwnTable.reloadData()
      
        gotoLogin()
    }
    
    func bindStoryResponse(data: Data){
        let jsondecoder = JSONDecoder()
        if let data = try? jsondecoder.decode(StoryRespnse.self, from: data){
       print(data)
            if let d = data.data{
                self.listStoryOwe = d
                DispatchQueue.main.async {
                    self.storyOwnTable.reloadData()
                }
            }
        }
    }
    
    func bindUser(){
        if let user = DeviceData.getUser(){
            if let user = try? JSONDecoder().decode(LoginStruct.self, from: user)
            {
                txtEmail.text = user.data.email
                txtPhone.text = user.data.phone
                UserNametxt.text = user.data.userName
                if let imageUrl = user.data.avatar {
                    UserAvatar.setImage(url: imageUrl)
                }
            }
        }else {
            txtEmail.text = "email.com"
            txtPhone.text = "my_pho"
            UserNametxt.text = "userName"
            UserAvatar.image = nil
        }
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
