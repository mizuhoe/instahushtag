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
    
     //ふぁぼを入れるための配列
    var favArray = [String]()
    
    var titleName : String?
    var nakami : String?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         titleTextfield.text = titleName
        textView.text = nakami

        
    }
    
    @IBAction func copyButton(){
    
    let pasteboard = UIPasteboard.general
    
    // 文字列をコピーする
    pasteboard.setValue(nakami ?? "", forPasteboardType: "public.text")
    
    // コピーした文字列を取り出し
    let copiedText = pasteboard.value(forPasteboardType: "public.text") as! String
        print(copiedText)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    @IBAction func instagram(){
        let url = NSURL(string:"instagram://camera")
        UIApplication.shared.openURL(url as! URL)
    }
    
    @IBAction func fav(button: UIButton){
        
        userDefaults .set(true, forKey: "Key")
        userDefaults.set(1, forKey: "Key")
        userDefaults .set("TEST", forKey: "Key")
        
        
       // favArray.append()
        
        button.setTitle("❤︎", for: UIControlState.normal)
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
