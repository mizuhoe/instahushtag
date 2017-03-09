//
//  TagsViewController.swift
//  instahushtag
//
//  Created by 江森みずほ on 2016/11/03.
//  Copyright © 2016年 江森みずほ. All rights reserved.
//

import UIKit

class TagsViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet var titleTextfield: UITextField!
    var index : Int = 0
    @IBOutlet var textView: UITextView!
    
    @IBOutlet var button : UIButton!
     //ふぁぼを入れるための配列
    var favArray = [String]()
    var key : String = ""

    var titleName : String?
    var nakami : String?
    @IBOutlet var copiedTextView : UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         titleTextfield.text = titleName
        textView.text = nakami
        key = titleName!
        
        copiedTextView.isScrollEnabled = true
        
        favArray = userDefaults.array(forKey: "favArray") as? [String] ?? []
        if favArray.index(of: key) != nil {
            button.setTitle("❤︎", for: UIControlState.normal)
            
        }else {
            
            button.setTitle("♡",for:UIControlState.normal)
            
        }


        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        copiedTextView.text = userDefaults.object(forKey: "copiedText") as? String
    }
    
    @IBAction func copyButton(){
    
    let pasteboard = UIPasteboard.general
        
    
    // 文字列をコピーする
    pasteboard.setValue(nakami ?? "", forPasteboardType: "public.text")
    
    // コピーした文字列を取り出し
    let copiedText = pasteboard.value(forPasteboardType: "public.text") as! String
        print(copiedText)
        
        
        //textViewに貼り付ける
        copiedTextView.text = copiedTextView.text + copiedText
        userDefaults.set(copiedTextView.text, forKey: "copiedText")
        
    }

    override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
            }
    
    @IBAction func copyAll() {
        let pasteboardAll = UIPasteboard.general
        pasteboardAll.setValue(copiedTextView.text ?? "", forPasteboardType: "public.text")
        
    }
    
    @IBAction func resetAll() {
        copiedTextView.text = ""
        userDefaults.set(copiedTextView.text, forKey: "copiedText")
    }
    
    @IBAction func instagram(){
        let url = NSURL(string:"instagram://camera")
        UIApplication.shared.openURL(url as! URL)
    }
    
    @IBAction func fav(button: UIButton){
        favArray = userDefaults.array(forKey: "favArray") as? [String] ?? []
        key = titleName!

        
        if favArray.index(of: key) == nil {
            button.setTitle("❤︎", for: UIControlState.normal)
            favArray.append(key)
            
            
        }else {
            
            button.setTitle("♡",for:UIControlState.normal)
            
            let junban = favArray.index(of: key)
            favArray.remove(at: junban!)
        }

        
       // favArray.append()
        
        userDefaults.set(favArray, forKey: "favArray")
        

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
