//
//  GenreViewController.swift
//  instahushtag
//
//  Created by 江森みずほ on 2016/11/03.
//  Copyright © 2016年 江森みずほ. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController {
    
    var tag: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toNext(sender: UIButton){
        //ボタンの情報をもらう
        //ボタンの情報を保存
        tag = sender.tag
        
        //画面遷移する
        performSegue(withIdentifier: "toList", sender: nil)
        
        print(tag)
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listViewController : ListViewController = segue.destination as! ListViewController
        listViewController.tag = tag
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
