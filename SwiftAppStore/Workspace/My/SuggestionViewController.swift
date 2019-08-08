//
//  SuggestionViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/8.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class SuggestionViewController: MCRootViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var leftConstrain: NSLayoutConstraint!
    @IBOutlet weak var addPicture: UIButton!
    var picCount:Int = 0
    var array = [UIImageView]()
    var buttonArray = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(add))
        
    }
    
    @objc func add()  {
        HudTool.showLoadingAutoHiden()
        DispatchQueue.main.asyncAfter(deadline:     DispatchTime.now()+0.5) {
            HudTool.showflashMessage(message: "感谢您的反馈，我们会尽快解决！")
            self.navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func addAction(_ sender: Any) {
       let cont = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let photo = UIAlertAction(title: "相册", style: .destructive) { (act) in
            let pickerCamera = UIImagePickerController()
            
            pickerCamera.allowsEditing = true
            pickerCamera.sourceType =  .photoLibrary
            pickerCamera.delegate = self
            
            self.present(pickerCamera, animated: true, completion: nil)
        }
        
        let camera = UIAlertAction(title: "相机", style: .destructive) { (act) in
            var sourceType = UIImagePickerController().sourceType
            sourceType = .camera
            
            if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                print("无法调用相机")
                sourceType = UIImagePickerController.SourceType.photoLibrary //改为调用相册
            }
            
            
            let pickerPhoto = UIImagePickerController()
            
            pickerPhoto.delegate = self
            
            pickerPhoto.allowsEditing = true//设置可编辑
            
            pickerPhoto.sourceType = sourceType
            
            self.present(pickerPhoto, animated: true, completion: nil)//进入照相界面
            
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        cont.addAction(photo)
        cont.addAction(camera)
        cont.addAction(cancel)
        self.present(cont, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var imagePickerc = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        
        
        if picker.allowsEditing {
            imagePickerc = (info[UIImagePickerController.InfoKey.editedImage] as? UIImage)!
        }
        
        let imageV = UIImageView(frame: .zero)
        imageV.isUserInteractionEnabled = true
        imageV.image = imagePickerc
        array.insert(imageV, at: 0)
        let button = UIButton(frame: CGRect(x: 25, y: -5, width: 20, height: 20))
        button.addTarget(self, action: #selector(remove(sender:)), for: .touchUpInside)
        imageV.addSubview(button)
        button.setImage(UIImage(named: "deletePic"), for: .normal)
        buttonArray.insert(button, at: 0)
        view.addSubview(imageV)
        self.updateUI()
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateUI()  {
        let top = addPicture.top
        for index in 0 ..< array.count {
            let button = buttonArray[index]
            button.tag = index
            let im = array[index]
            im.frame = CGRect(x:  CGFloat( 20 + index*60 ), y: top, width: 40, height: 40)
        }
        leftConstrain.constant =  CGFloat (20 + array.count * 60 )
    }
    
    @objc func remove(sender:UIButton)  {
        let imageV = array[sender.tag]
        imageV.removeFromSuperview()
        array.remove(at: sender.tag)
        buttonArray.remove(at: sender.tag)
    
        updateUI()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
