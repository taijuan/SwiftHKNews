//
//  FeedbackViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/19.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import RxSwift

class FeedbackViewController: UIViewController {
    private let textView = UITextView()
    private let hintView = UILabel()
    private let numberView = UILabel()
    private let emailView = UITextField()
    private var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "#f5f5f5")
        setBackTitleBar("Feedback")
        self.initContent()
    }
    
}

extension FeedbackViewController:UITextViewDelegate{
    func initContent(){
        
        textView.backgroundColor = .white
        textView.frame = CGRect(x: 0, y: statusHeight+toolBarHeight()+8, width: width(), height: width()*2/3)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 30, right: 8)
        textView.delegate = self
        self.view.addSubview(textView)
        textView.font = UIFont.systemFont(ofSize: 17)
        
        hintView.text = "We are glad to hear from you"
        hintView.font = UIFont.systemFont(ofSize: 17)
        hintView.textColor = UIColor(hex: "#999999")
        hintView.frame = CGRect(x: 8, y: 8, width: width()-16, height: 17)
        hintView.textAlignment = .left
        textView.addSubview(hintView)
        
        let numberViewSuper = UIView()
        numberViewSuper.frame = CGRect(x: 0, y: width()*2/3+statusHeight+toolBarHeight()+8, width: width(), height: 30)
        numberViewSuper.backgroundColor = .white
        self.view.addSubview(numberViewSuper)
        numberView.text = "500/500   "
        numberView.font = UIFont.systemFont(ofSize: 17)
        numberView.textColor = UIColor(hex: "#999999")
        numberView.frame = CGRect(x: 8, y: 0, width: width()-16, height: 30)
        numberView.textAlignment = .right
        numberViewSuper.addSubview(numberView)
        
        let emailViewSuper = UIView()
        emailViewSuper.frame = CGRect(x: 0, y: width()*2/3+statusHeight+toolBarHeight()+8+30+8, width: width(), height: 48)
        emailViewSuper.backgroundColor = .white
        self.view.addSubview(emailViewSuper)
        emailView.frame = CGRect(x: 8, y: 0, width: width()-16, height: 48)
        emailView.placeholder = "Please leave your e-mail"
        emailView.font = UIFont.systemFont(ofSize: 17)
        emailView.textContentType = .emailAddress
        emailViewSuper.addSubview(emailView)
        
        let commit = UIButton()
        commit.frame = CGRect(x: 48, y: width()*2/3+statusHeight+toolBarHeight()+8+30+8+36+48, width: width()-48-48, height: 48)
        commit.backgroundColor = .blue
        commit.setTitle("commit", for: .normal)
        commit.layer.cornerRadius = 8
        commit.addTarget(self, action:#selector(commitAtion), for: .touchUpInside)
        self.view.addSubview(commit)
    }
    
    @objc func commitAtion(){
        let content = textView.text ?? ""
        let email = emailView.text ?? ""
        if content.isEmpty {
            self.view.showToast("content is empty")
            return
        }
        if email.isEmpty {
            self.view.showToast("email is empty")
            return
        }
        FeedbackViewModel().feedback(content: content, email: email).subscribe(onNext: {data in
            logE(any: data)
            self.view.showToast("Success")
            pop(animated: true)
        }).disposed(by: disposeBag)
    }
    func textViewDidChange(_ textView: UITextView) {
        let text = textView.text ?? ""
        let count = text.count
        self.hintView.isHidden = count != 0
        if count > 500{
            let a:String = String(text.prefix(500))
            textView.text = a
            self.numberView.text = "500/500   "
        }else{
            self.numberView.text = "\(count)/500   "
        }
        logE(any: textView.text.count)
    }
}
