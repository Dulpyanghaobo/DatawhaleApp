//
//  DWLoginViewController.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/18.
//

import UIKit
//import FirebaseAuth
import AuthenticationServices
import CryptoKit

class DWLoginViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 将背景视图加入到视图控制器的view
        view.addSubview(bgImageView)
        // 将背景蒙层加入到View
        view.addSubview(bgView)
        // 将logo加入到当前视图控制器当中
        view.addSubview(logoImage)
        // 将当前文本加入视图控制器
        view.addSubview(datawhaleLabel)
        view.addSubview(phoneNumberLabel)
        view.addSubview(loginButton)
        view.addSubview(otherNumberButton)
        view.addSubview(problemLabel)
        self.bgImageView.snp.makeConstraints{(make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        self.bgView.snp.makeConstraints{(make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        self.logoImage.snp.makeConstraints{(make) in
            make.top.equalToSuperview().offset(DWNavgationHeight+56)
            make.centerX.equalToSuperview() // centerX表示相对于父视图的X轴中心
        }
        self.datawhaleLabel.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.logoImage.snp.bottom).offset(-8)
        }
        self.phoneNumberLabel.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.datawhaleLabel.snp.bottom).offset(24)
        }
        loginButton.snp.makeConstraints{(make) in
            make.top.equalTo(self.phoneNumberLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: DWScreenWidth - 64, height: 48))
        }
        otherNumberButton.snp.makeConstraints{(make) in
            make.top.equalTo(self.loginButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: DWScreenWidth - 64, height: 48))
        }
        problemLabel.snp.makeConstraints{(make) in
            make.right.equalTo(otherNumberButton)
            make.top.equalTo(otherNumberButton.snp.bottom).offset(14)
        }
    }
    
    
    // MARK: - Life Cycle
    // MARK: - InitView
    // MARK: - Public
    
    // MARK: - Private
    
    // MARK: - Action
    @objc func clickLoginAction() {

        NetWorkRequest(APILogin.login(user: ["Id":"4","name":"adsdas","password":"ddem"]), needShowFailAlert: true, modelType: [User].self, successCallback: { _,_ in
            print("deimdemde")
        }, failureCallback: { model in
            print("deimdemde\(model)")
        })
        //        let nonce = randomNonceString()
//        self.currentNonce = nonce
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let request = appleIDProvider.createRequest()
//        request.requestedScopes = [.fullName, .email]
//        request.nonce = sha256(nonce)
//        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
    }
    /// 登录加密
    /// - Parameter length: 长度
    /// - Returns: 返回值
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    private var currentNonce : String = ""
    
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    // MARK: - privateUI
    // 手机号区域
    private lazy var problemLabel : UILabel = {
        var label = UILabel.init(frame: CGRect.zero)
        label.text = "遇到问题"
        label.textColor = UIColor.blackGray1()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.meduimFont(16)
        return label
    } ()
    // 使用其他手机登录按钮
    private lazy var otherNumberButton: UIButton = {
        var button = UIButton.init(type: .custom)
        button.setTitle("使用其他手机登录", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.meduimFont(16)
        return button
    }()
    
    // 一键登录按钮
    private lazy var loginButton: UIButton = {
        var button = UIButton.init(type: .custom)
        button.setTitle("本机号码一键登录", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.meduimFont(16)
        button.addTarget(self, action: #selector(clickLoginAction), for: .touchUpInside)
        return button
    }()
    
    // 手机号区域
    private lazy var phoneNumberLabel : UILabel = {
        var label = UILabel.init(frame: CGRect.zero)
        label.text = "138****1680"
        label.textColor = UIColor.white
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.boldFont(32)
        return label
    } ()
    
    // 当前文字的Label
    private lazy var datawhaleLabel : UILabel = {
        var label = UILabel.init(frame: CGRect.zero)
        label.text = "Datawhale"
        label.textColor = UIColor.white
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.boldFont(32)
        return label
    } ()
    
    // 添加Datawhale的logo
    private lazy var logoImage: UIImageView = {
        var imageView = UIImageView.init(image: UIImage.init(named: "datawhale_logo"))
        imageView.contentMode = .scaleToFill //表示当前视图的模式是
        return imageView
    }()
    
    //添加透明度层
    private lazy var bgView: UIView = {
        var view = UIView.init(frame: CGRect.zero)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7) // 背景色为黑色透明度为0.7
        return view
    }()
    
    // 背景图片
    private lazy var bgImageView: UIImageView = {
        var imageView = UIImageView.init(image: UIImage.init(named: "login_bg_image"))
        imageView.contentMode = .scaleAspectFill //表示当前视图的模式是
        imageView.clipsToBounds = true
        return imageView
    }()
    
}

extension DWLoginViewController : ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding
{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
    }
  
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential
        else {
          print("Unable to retrieve AppleIDCredential")
          return
        }
        guard let appleIDToken = appleIDCredential.identityToken else {
          print("Unable to fetch identity token")
          return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
          print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
          return
        }
//
//        let credential = OAuthProvider.credential(withProviderID: "apple.com",
//                                                  idToken: idTokenString,
//                                                  rawNonce: self.currentNonce)
//
//        Auth.auth().signIn(with: credential) { result, error in
//
//
//        }
    }
}
