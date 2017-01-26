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
    
    let userDefaults = UserDefaults.standard
    
      
    
    
    
    
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
    
    //お気に入りを入れるための配列
    var favArray = [String]()

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
        
        userDefaults .set(true, forKey: "Key")
        userDefaults.set(1, forKey: "Key")
        userDefaults .set("TEST", forKey: "Key")
        
        
        favArray.append()
        
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


var hushtags  : [String:String] = ["ペット":"＃pet＃petsgram#petscorner#pets_of_instagram#pets#animal#animals","猫":"#cat#catstagram#cats#catsofinstagram#catlover#kitten#kittens#mycat","犬":"#dog#dogs#dogs_of_instagram#pup#puppy#dogstagram#doglover#dogsoftheday#lobepuppies","食べ物":"#food #foodlovers #foodie #foodpic#delicious #foodoftheday#foodgasm#delish #yummyfood #yum #yummy #delicious #tasty #eat #hungry #foodpics #fresh #tasty #eating#instafood","ラーメン":"#ramen#ramennoodles#ramensamyang#japaneserestaurant#ラーメン,”すし”:”#sushi#suhitime#sushirolle#sushi🍣#sushis#sushilovers","サッカー":"#soccer#soccermom#soccergame#soccerball#soccerlife#football#footballgeme#footbalmom#footballgames#footballseason#footballboots#footballplayer","野球":"#baseball#baseballcap#baseballmom#baseballtee#baseballlife#baseballgame","水泳":"#swimming#swimmingpool#swimminhlessons#swimmingtime#swimwear#swimsuit#swimwearph#swim#swimmer#swimbikerun#swiming","テニス":"#tennis#tennislobe#tennistime#tennisball#tennislofe#teniscourt#tennisplayer","バドミントン":"#badminton#badmintontimr#badmintonplayer#badmintonlovers","バスケ":"#basketball#basketballshoes#baskets#basketbol#basketballgeme#basketballneversports","春":"#spring#springtime#springday#springstyle#spring2017#springsummer#springishere#springfever"
    ,"夏":"#summer#summers#summer17#summerfun#hotday#summerday#summerbody#summerhair#summertime#summer2017#summervibes#summerstyle#summerfashion#summerishere","日本":"#japan#japanese#japantrip#japaneselife","東京":"#tokyo#tokyolife#tokyogholul#japan#東京",
     "日本食":"#日本食#日本#和食#japaneselife#japanesestyle#japanesefood#japan#japanese","イタリアン":"#イタリアン#イタリア#italia#talian#talianfood#italiancooking","フレンチ”:”#フレンチ#france#french","タイ料理":"#タイ料理#タイ#タイフード#thai#thaifood","インド料理”:”#インド#インド料理#india#indian#indianfood","中華":"#中華#中華料理#中国#china#chinese#chinesefood#chinesestyle","韓国料理":"#韓国#korea#koreanfood#korean#韓国料理"]
