//
//  FavoriteViewController.swift
//  instahushtag
//
//  Created by 江森みずほ on 2016/11/03.
//  Copyright © 2016年 江森みずほ. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var index : Int = 0
    
    let userDefaults = UserDefaults.standard
    
    
    //StoryBoardで扱うTable Viewを宣言
    @IBOutlet var table:UITableView!
    
    //タイトルを入れるための配列
    var listNameArray = [String]()
    
    //サブタイトルを入れるための配列
    var subTitleArray = [String]()
    
    var nakamiArray = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        //Table VIewのデータベースメソッドはViewControllerクラスに書くよ、という設定
        table.dataSource = self
        table.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //セルの数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //セルの数をsongNameArrayの要素の数にする
        return listNameArray.count
    }

    //ID付きのセルを取得して、セル付属のtextLabelに「テスト」と表示させてみる。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
    
        let titleLabel: UILabel = cell?.viewWithTag(1) as! UILabel
        titleLabel.text = listNameArray[indexPath.row]
        let subTitleLabel: UILabel = cell?.viewWithTag(2) as! UILabel
        subTitleLabel.text = subTitleArray[indexPath.row]
        return cell!
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //情報をもらって保存する
        index = indexPath.row
        
        //画面遷移する
        performSegue(withIdentifier: "toTagDetail2" , sender: nil)
        
        print(index)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tagsViewController : TagsViewController = segue.destination as! TagsViewController
        tagsViewController.index = index
    }

}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
