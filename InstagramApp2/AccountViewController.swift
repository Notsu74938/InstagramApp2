//
//  AccountViewController.swift
//  InstagramApp2
//
//  Created by 野津天志 on 2020/12/17.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var auth: Auth!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        auth = Auth.auth()
        emailTextField.delegate = self
        passwordTextField.delegate = self
      
    }
    
    //レイアウト処理後(viewDidLayoutSubviews)の次に呼ばれる
    //はじめて遷移した一度だけサーバーから何かを通信して取得したい場合
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //すでにユーザー登録が済んでいる場合
        if auth.currentUser != nil {
            //メール認証を実際に行なったかをアプリ側で自動更新はしてくれないので、以下のメソッドを呼んでわざと更新処理を行う
            auth.currentUser?.reload(completion: {error in
                if error == nil{
                    //メールアドレス認証済の場合
                    if self.auth.currentUser?.isEmailVerified == true{
                        //画面遷移でユーザー情報を送る
                        self.performSegue(withIdentifier: "Timeline", sender: self.auth.currentUser)
                    //メール認証済でない場合
                    }else if self.auth.currentUser?.isEmailVerified == false{
                        //アラームの処理
                        let alert = UIAlertController(title: "確認用メールを送信しているので確認をお願いします。", message: "まだメール認証が完了していません。", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                  }
                })
            }
            
        }
    
    
    //遷移先のストーリーボードを取得してきて設定する
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //変数nextViewControllerにTimelineViewControllerを代入する
        let nextViewController = segue.destination as! TimelineViewController
        //authのcurrentUserの中のUser型の情報をuserに代入する
        let user = sender as! User
        //AppUserにキー値"userID"のvalue user.uidの情報を送る
        nextViewController.me = AppUser(data: ["userID": user.uid])

    }
    
    //登録ボタンが押された時の処理
    @IBAction func registerAccount(_ sender: Any) {
        //optional型のemailTextField,passwordTextFieldを"!"でアンラップする
        let email = emailTextField.text!
        let password = passwordTextField.text!
        auth.createUser(withEmail: email, password: password) { (result, error) in
            //error == nil,エラーがない場合
            //result = result,代入する値をresultの型に指定
            if error == nil, let result = result {
                result.user.sendEmailVerification(completion: { (error) in
                    if error == nil {
                        let alert = UIAlertController(title: "仮登録を行いました。", message: "入力したメールアドレス宛に確認メールを送信しました。", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            }
        }
    }
}

// デリゲートメソッドは可読性のためextensionで分けて記述
extension AccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
    }
}
