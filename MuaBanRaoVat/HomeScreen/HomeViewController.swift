//
//  HomeViewController.swift
//  MuaBanRaoVat
//
//  Created by Thanh Nguyen on 3/26/23.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listStories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listStoriesTable.dequeueReusableCell(withIdentifier: "HomeStoryCell") as! StoryCellHomeTableViewCell
        let item = listStories[indexPath.row]
        
        cell.setImage(url: item.image)
        cell.setName(name: item.title)
        cell.setPrice(price: item.price)
        cell.idStory = item._id
        
        return cell
    }
    

    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var listStoriesTable: UITableView!
    
    var listStories: [Story] = []
    var listCate: [String] = ["Tất cả"]
    var menuSelected = "Tất cả"
    
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
        if menuId != "" {
            menuSelected = menuId.replacingOccurrences(of: " ", with: "_")
        }
        if(menuId == "Tất cả" || menuId == ""){
            HttpData.getPost(success: {data in
                self.bindStoryResponse(data: data)
            }, error: {errmsg in
                
            })
        } else {
            HttpData.getPostByCate(cate: menuSelected, success: {data in
                self.bindStoryResponse(data: data)
            }, error: {erMsg in
                
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listStoriesTable.dataSource = self
        listStoriesTable.delegate = self
        self.setupMenuButton()
        callInitialApi()
        // Do any additional setup after loading the view.
    }
    
    func callInitialApi(){
        HttpData.getCategory(success: {data in
            self.bindCategory(data: data)
        }, error: {ermsg in
            self.setupMenuButton()
            let alert = UiHelpers.createAlert(title: "Error", message: "can not connect to Endpoint", buttons: [UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)])
            self.present(alert, animated: true)
            
        })
        
        HttpData.getPost(success: {data in
            self.bindStoryResponse(data: data)
        }, error: {errmsg in
            
        })
    }
    
    func bindStoryResponse(data: Data){
        let jsondecoder = JSONDecoder()
        if let data = try? jsondecoder.decode(StoryRespnse.self, from: data){
            
            if let d = data.data{
                self.listStories = d
                DispatchQueue.main.async {
                    self.listStoriesTable.reloadData()
                }
            }
        }
    }
    
    func bindCategory(data: Data){
        let jsondecoder = JSONDecoder()
        if let data2 = try? jsondecoder.decode(ResponseCategory.self, from: data)
        {
            DeviceData.saveMenus(menu: data)
            if let d = data2.data {
                self.listCate.append(contentsOf: d)
                DispatchQueue.main.async {
                    self.setupMenuButton()
                }
            }
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
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

}
