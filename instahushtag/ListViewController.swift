//
//  ListViewController.swift
//  instahushtag
//
//  Created by 江森みずほ on 2016/11/03.
//  Copyright © 2016年 江森みずほ. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate{
    
//    @IBOutlet var titlename : UILabel!
//    @IBOutlet var subtitle : UILabel!
    
    let userDefaults = UserDefaults.standard
    
    var genreArray : [String] = ["food", "people","outgoing","animal","ivent","hobby","life","others","sports","hushtags"]
    var index : Int = 0
    var tag : Int = 0
    var key : String = ""
    var nakami : String?
    var searchBar: UISearchBar!
    var searchListResult : [String] = []
    @IBOutlet var copiedTextView : UITextView!
    

    //StoryBoardで扱うTable Viewを宣言
    @IBOutlet var table:UITableView!
    
    //タイトルを入れるための配列
    var listNameArray = [String]()
    
    //サブタイトルを入れるための配列
     var subTitleArray = [String]()
    
    //中身を入れるための配列
    var nakamiArray = [String]()
    
    //お気に入りを入れるための配列
    var favArray = [String]()
    
    
    //検索結果配列
    var searchResult = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //Table VIewのデータベースメソッドはViewControllerクラスに書くよ、という設定
        table.dataSource = self
        table.delegate = self
        
        if let navigationBarFrame = navigationController?.navigationBar.bounds {
            let searchBar: UISearchBar = UISearchBar(frame: navigationBarFrame)
            searchBar.delegate = self
            searchBar.placeholder = "Search"
            searchBar.showsCancelButton = true
            searchBar.autocapitalizationType = UITextAutocapitalizationType.none
            searchBar.keyboardType = UIKeyboardType.default
            navigationItem.titleView = searchBar
            navigationItem.titleView?.frame = searchBar.frame
            self.searchBar = searchBar
            searchBar.becomeFirstResponder()
            
            copiedTextView.isScrollEnabled = true
        }

        //何も入力されていなくてもReturnキーを押せるようにする。
        searchBar.enablesReturnKeyAutomatically = false
        
        //検索結果配列
        searchResult = nakamiArray
        searchListResult = listNameArray
        
        
        //listNameArrayに名前を入れていく　
        listNameArray = categories[genreArray[tag - 1]] ?? []
        //subTitleArray = ["#Japanese","#Italian","#French","#Thai","#Indian","#Chiniese","#Korean"]
        
        searchResult = []
        searchListResult = []
        
        for listName in listNameArray {
            nakamiArray.append(hashtags[listName] ?? "")
        }
        // Do any additional setup after loading the view.
        
        print(nakamiArray)
        favArray = userDefaults.array(forKey: "favArray") as? [String] ?? []
        searchResult = nakamiArray
        searchListResult = listNameArray

    }
    
    override func viewWillAppear(_ animated: Bool) {
        favArray = userDefaults.array(forKey: "favArray") as? [String] ?? []
        table.reloadData()
        
         copiedTextView.text = userDefaults.object(forKey: "copiedText") as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //セルの数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //セルの数をsongNameArrayの要素の数にする
        
        return searchResult.count
    }
    
    //ID付きのセルを取得して、セル付属のtextLabelに「テスト」と表示させてみる。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
//        cell?.textLabel?.text = listNameArray[indexPath.row]
        let titleLabel: UILabel = cell?.viewWithTag(1) as! UILabel
        titleLabel.text = searchListResult[indexPath.row]
        let subTitleLabel: UILabel = cell?.viewWithTag(2) as! UILabel
        subTitleLabel.text = searchResult[indexPath.row]
        
        let favButton : UIButton = cell?.viewWithTag(3) as! UIButton
        
        if favArray.index(of: searchListResult[indexPath.row]) != nil {
            favButton.setTitle("❤︎", for: UIControlState.normal)
        } else {
            favButton.setTitle("♡", for: UIControlState.normal)
        }
        return cell!
    
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt inidexPath: IndexPath) {
        //情報をもらって保存する
        index = inidexPath.row
        
        //画面遷移する
        performSegue(withIdentifier: "toTagDetail" , sender: nil)
        
        print(index)
        
    }
    
    //検索ボタン押下時の呼び出しメソッド
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        
        //検索結果配列を空にする。
        searchResult.removeAll()
        searchListResult.removeAll()
        
        if(searchBar.text == "") {
            //検索文字列が空の場合はすべてを表示する。
            searchResult = nakamiArray
            searchListResult = listNameArray
            
        } else {
            //検索文字列を含むデータを検索結果配列に追加する。
            for data in nakamiArray {
                if data.contains(searchBar.text!) {
                    searchResult.append(data)
                    searchListResult.append(listNameArray[nakamiArray.index(of: data)!])
                }
            }
        }
        
        //テーブルを再読み込みする。
        table.reloadData()
    }
    
    @IBAction func copyButton(button : UIButton){
        
        let pasteboard = UIPasteboard.general
        
        // 文字列をコピーする
        pasteboard.setValue(searchResult[index], forPasteboardType: "public.text")
        
        // コピーした文字列を取り出し
        let copiedText = pasteboard.value(forPasteboardType: "public.text") as! String
        print(copiedText)
        
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        
        
        //textViewに貼り付ける
        copiedTextView.text = copiedTextView.text + copiedText
        userDefaults.set(copiedTextView.text, forKey: "copiedText")
        

    }
    
    @IBAction func fav(button: UIButton){
        
        // タップされたボタンのtableviewの選択行を取得
        let cell = button.superview?.superview as! UITableViewCell
        //row→何行目か？
        let row = table.indexPath(for: cell)?.row
        
        key = listNameArray[row!]
        if favArray.index(of: key) == nil {
            
            button.setTitle("❤︎", for: UIControlState.normal)
            favArray.append(key)
            
            
        }else {
            
            button.setTitle("♡",for:UIControlState.normal)
            
            let junban = favArray.index(of: key)
            favArray.remove(at: junban!)
        }
        userDefaults.set(favArray, forKey: "favArray")
        
        
    }
    

    
    @IBAction func copyAll() {
        let pasteboardAll = UIPasteboard.general
        pasteboardAll.setValue(copiedTextView.text ?? "", forPasteboardType: "public.text")
        
    }
    
    @IBAction func resetAll() {
        copiedTextView.text = ""
        userDefaults.set(copiedTextView.text, forKey: "copiedText")
    }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tagsViewController : TagsViewController = segue.destination as! TagsViewController
        tagsViewController.titleName = listNameArray[index]
        tagsViewController.nakami = nakamiArray[index]
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
