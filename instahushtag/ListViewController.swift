//
//  ListViewController.swift
//  instahushtag
//
//  Created by 江森みずほ on 2016/11/03.
//  Copyright © 2016年 江森みずほ. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
    
//    @IBOutlet var titlename : UILabel!
//    @IBOutlet var subtitle : UILabel!
    
    var index : Int = 0
    var tag : Int = 0
    
    //StoryBoardで扱うTable Viewを宣言
    @IBOutlet var table:UITableView!
    
    //タイトルを入れるための配列
    var listNameArray = [String]()
    
    //サブタイトルを入れるための配列
     var subTitleArray = [String]()
    
    //中身を入れるための配列
    var nakamiArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Table VIewのデータベースメソッドはViewControllerクラスに書くよ、という設定
        table.dataSource = self
        table.delegate = self
        
        //listNameArrayに名前を入れていく　
        listNameArray = ["日本食","イタリアン","フレンチ","タイ","インド","中華","韓国"]
        subTitleArray = ["#Japanese","#Italian","#French","#Thai","#Indian","#Chiniese","#Korean"]
        
        nakamiArray = ["#日本食#日本#和食#japaneselife#japanesestyle#japanesefood#japan#japanese","#イタリアン#イタリア#italia#talian#talianfood#italiancooking","#フレンチ#france#french","#タイ料理#タイ#タイフード#thai#thaifood","#インド#インド料理#india#indian#indianfood","#中華#中華料理#中国#china#chinese#chinesefood#chinesestyle","#韓国#korea#koreanfood#korean#韓国料理"]
        // Do any additional setup after loading the view.
        
        
        
//        titlename.text = listNameArray[index]
//        subtitle.text = nakamiArray[index]

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
//        cell?.textLabel?.text = listNameArray[indexPath.row]
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
        performSegue(withIdentifier: "toTagDetail" , sender: nil)
        
        print(index)
        
    }
    
    @IBAction func copyButton(button : UIButton){
        
                let pasteboard = UIPasteboard.general
        
        // 文字列をコピーする
        pasteboard.setValue(nakamiArray[index], forPasteboardType: "public.text")
        
        // コピーした文字列を取り出し
        let copiedText = pasteboard.value(forPasteboardType: "public.text") as! String
        print(copiedText)
        
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
    }
    
    @IBAction func fav(button: UIButton){
        
        
        print(nakamiArray[index])
        print("をお気に入りに追加しました")
    
        
        button.setTitle("❤︎", for: UIControlState.normal)
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tagsViewController : TagsViewController = segue.destination as! TagsViewController
        tagsViewController.index = index
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
