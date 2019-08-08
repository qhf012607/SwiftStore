//
//  ProductViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/31.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit
import WebKit
import FSPagerView
import SnapKit

class ProductViewController: MCRootViewController {
    var product_id = ""
    let wkweb = WKWebView()
    var model : ProductDetail?
    var arrayImage = [String]()
    var pageView = FSPagerView()
    var labPrice : UILabel?
    var labAmount : UILabel?
    var labPricerignht : UILabel?
    var labName : UILabel?
    var cate : Product?
    var viewPurchase = PurchaseView(frame: .zero)
    @IBOutlet weak var orderBtn: UIButton!
    @IBOutlet weak var addCarBt: UIButton!
    @IBOutlet weak var collectBtn: UIButton!
    @IBOutlet weak var carButtnon: UIButton!
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "商品详情"
       
       
        self.pageView.delegate = self
        self.pageView.dataSource = self
        table.separatorStyle = .none
        self.pageView.isInfinite = true
        addCarBt.layer.cornerRadius = 17
        addCarBt.addTarget(self, action: #selector(addshipCar), for: .touchUpInside)
        orderBtn.layer.cornerRadius = 17
        pageView.automaticSlidingInterval = 3.0
        pageView.frame = CGRect(x: 0, y: 0, width: screenWith, height: 250)
        carButtnon.imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        carButtnon.titleEdgeInsets = UIEdgeInsets(top: 45, left:-45, bottom: 0, right: 0)
        collectBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectBtn.titleEdgeInsets = UIEdgeInsets(top: 45, left: -45, bottom: 0, right: 0)
        pageView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "productcell")
        RONetCenter.requestForProductDetail(productId: product_id).mapModel(type: ProductDetail.self).subscribe(onNext: {[weak self] (data) in
            self?.model = data
            self?.load()
        }, onError: { (errpr) in
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        // Do any additional setup after loading the view.
        var array = MCFileManager.readcollectsProducts()
      
        for i  in 0 ..< array.count {
            let product = array[i]
            if product.productId == cate!.productId{
                self.collectBtn.setImage(UIImage(named: "collected"), for: .normal)
                break
            }
        }
       
    }
    
    @IBAction func gotoCar(_ sender: Any) {
        self.navigationController?.pushViewController(CarViewController(), animated: true)
    }
    @IBAction func collect(_ sender: Any) {
        var array = MCFileManager.readcollectsProducts()
        var collect = true
        for i  in 0 ..< array.count {
            let product = array[i]
            if product.productId == cate!.productId{
                array.remove(at: i)
                MCFileManager.collectDefaultArrayProduct(array: array)
                collect = false
                self.collectBtn.setImage(UIImage(named: "collect"), for: .normal)
                break
            }
        }
        if collect {
             MCFileManager.collectProductToLocal(model: cate!)
             self.collectBtn.setImage(UIImage(named: "collected"), for: .normal)
        }
       
    }
    @IBAction func gotoOrder(_ sender: Any) {
       self.orderNow()
    }
    
    func load()  {
      
       
        self.wkweb.navigationDelegate = self
        let stringN = model?.productImages.replacingOccurrences(of: "[\"", with: "")
        let string = stringN!.replacingOccurrences(of: "\"", with: "")
        let stringNM = string.replacingOccurrences(of: "]", with: "")
        self.arrayImage = stringNM.components(separatedBy: ",")
        self.wkweb.loadHTMLString(self.model!.productContent, baseURL: nil)
        
        self.pageView.reloadData()
        let viewN = UIView(frame: CGRect(x: 0, y: 0, width: screenWith, height:410))
        viewN.addSubview(self.pageView)
        viewN.addSubview(self.middleView)
        self.table.tableHeaderView = viewN
        self.labName?.text = cate?.productName
        self.labPrice?.text = cate?.productPrice1
        self.labPricerignht?.text = cate?.productPrice2
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   func orderNow()  {
        var array = [String]()
        for (_,value) in (model?.attribute)! {
            array = value
        }
        viewPurchase = PurchaseView()
        UIApplication.shared.delegate!.window!!.addSubview(viewPurchase)
        self.viewPurchase.reloadTable(array: array) {[weak self] (index,number) in
            let attribute = array[index]
            self!.cate?.attribute = attribute
            self!.cate?.buyCount = number
            self!.gotoOder()
        }
        viewPurchase.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(screenHeight)
            make.height.equalTo(screenHeight)
        }
        UIView.animate(withDuration: 1.5, animations: {
            
            self.viewPurchase.snp.updateConstraints({ (make) in
                make.top.equalTo(0)
            })
            UIApplication.shared.delegate!.window!!.setNeedsDisplay()
        }, completion: nil)
        
    }
    func gotoOder() {
        
        let model = self.cate
        let cont = OrderViewController()
        cont.array = [model] as! [Product]
        self.navigationController?.pushViewController(cont, animated: true)
    }
    
    @objc func addshipCar()  {
        if (AdminTool.share.user?.usercode) == nil {
            self.present( MCNavegationController(rootViewController: LoginViewController()), animated: true, completion: nil)
            return
        }
        var array = [String]()
        for (_,value) in (model?.attribute)! {
            array = value
        }
        viewPurchase = PurchaseView()
        UIApplication.shared.delegate!.window!!.addSubview(viewPurchase)
        self.viewPurchase.reloadTable(array: array) {[weak self] (index,number) in
            let attribute = array[index]
            self!.cate?.attribute = attribute
            self!.cate?.buyCount = number
//            self!.gotoOder()
            var price1:Float = 0.00
            var price2:Float = 0.00
            
            let numberstring =  self!.cate!.productPrice1
            let numberString = numberstring.replacingOccurrences(of: "￥", with: "")
            let countNum =  self!.cate!.buyCount ?? 1
            price1 += Float(numberString)!*Float(countNum)
            
            let numberstring2 =  self!.cate!.productPrice2
            let number2 = numberstring2.replacingOccurrences(of: "￥", with: "")
            price2 += Float(number2)!*Float(countNum)
            
            let discount = "\(price2-price1)"
            
            let dic = ["userid":"1001","productdiscount":discount,"deviceid":((UIApplication.shared.delegate) as! AppDelegate).deviceid,"productpirce":numberString,"productattribute":attribute,"secretkey":AdminTool.share.user!.secretkey,"productcount":"\(number)","productname":self!.cate!.productName,"productimage":self!.cate!.productImage,"productid":self!.cate!.productId]
            RONetCenter.addcarRequest(dic: dic).subscribe(onNext: { (data) in
               HudTool.showflashMessage(message: "加入购物车成功")
            }, onError: { (error) in
                HudTool.showflashMessage(message: "加入失败，请稍后重试")
            }, onCompleted: nil, onDisposed: nil).disposed(by: self!.disposeBag)
            //加入购物车
        }
        viewPurchase.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(screenHeight)
            make.height.equalTo(screenHeight)
        }
        UIView.animate(withDuration: 1.5, animations: {
            
            self.viewPurchase.snp.updateConstraints({ (make) in
                make.top.equalTo(0)
            })
             UIApplication.shared.delegate!.window!!.setNeedsDisplay()
        }, completion: nil)
    
    }
    
    
    lazy var middleView: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 250, width: screenWith, height: 160))
    //    v.backgroundColor = UIColor.yellow
        let line = UIView(frame: CGRect(x: 10, y: 0, width: screenWith-20, height: 0.5))
        line.backgroundColor = viewLineColor
        v.addSubview(line)
        
        var labPrice = UILabel(frame: .zero)
        v.addSubview(labPrice)
        labPrice.snp.makeConstraints({ (make) in
            make.top.equalTo(5)
            make.left.equalTo(10)
        })
     
        
        labPrice.font = UIFont.systemFont(ofSize: 14)
        labPrice.textColor = UIColor.red
        self.labPrice = labPrice
        let labPriceN = UILabel(frame: .zero)
        v.addSubview(labPriceN)
        labPriceN.snp.makeConstraints({ (make) in
            make.top.equalTo(5)
            make.left.equalTo(labPrice.snp.right).offset(30)
        })
        labPriceN.font = UIFont.systemFont(ofSize: 12)
        labPriceN.textColor = UIColor.lightGray
        self.labPricerignht = labPriceN
        
        let labName = UILabel(frame: .zero)
        v.addSubview(labName)
        labName.numberOfLines = 2
        labName.snp.makeConstraints({ (make) in
            make.top.equalTo(labPrice.snp.bottom).offset(20)
            make.left.right.equalTo(10)
            
        })
        self.labName = labName
        
        let linenew = UIView(frame: .zero)
        linenew.backgroundColor = viewLineColor
        v.addSubview(linenew)
        linenew.snp.makeConstraints({ (make) in
            make.top.equalTo(labName.snp.bottom).offset(10)
            make.left.right.equalTo(10)
            make.height.equalTo(0.5)
        })
        
        let labBtn = UILabel(frame: .zero)
        labBtn.text = "快递：包邮"
        labBtn.textColor = UIColor.darkGray
        labBtn.font = UIFont.systemFont(ofSize: 12)
        v.addSubview(labBtn)
        labBtn.textAlignment = .center
        labBtn.backgroundColor = viewLineColor
        labBtn.snp.makeConstraints({ (make) in
            make.centerX.equalTo(screenWith/4)
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.top.equalTo(linenew.snp.bottom).offset(5)
        })
        
        let labBtnT = UILabel(frame: .zero)
        labBtnT.text = "快递：包邮"
        labBtnT.backgroundColor = viewLineColor
        labBtnT.textAlignment = .center
        labBtnT.textColor = UIColor.darkGray
        labBtnT.font = UIFont.systemFont(ofSize: 12)
        v.addSubview(labBtnT)
        labBtnT.snp.makeConstraints({ (make) in
            make.centerX.equalTo(screenWith/4*3)
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.top.equalTo(linenew.snp.bottom).offset(5)
        })
        labAmount = labBtnT
        
        let linenewBotton = UIView(frame: .zero)
        linenewBotton.backgroundColor = viewLineColor
        v.addSubview(linenewBotton)
        linenewBotton.snp.makeConstraints({ (make) in
            make.top.equalTo(labBtn.snp.bottom).offset(10)
            make.left.right.equalTo(10)
            make.height.equalTo(0.5)
        })
        
        let imageV = UIImageView(frame: .zero)
        v.addSubview(imageV)
        imageV.snp.makeConstraints({ (make) in
            make.left.equalTo(10)
            make.top.equalTo(linenewBotton.snp.bottom).offset(2)
            make.width.height.equalTo(30)
        })
        imageV.image = UIImage(named: "address")
        
        let labAdress = UILabel(frame: .zero)
        labAdress.text = "广州东莞"
        labAdress.textColor = UIColor.darkGray
        labAdress.font = UIFont.systemFont(ofSize: 13)
        v.addSubview(labAdress)
        labAdress.snp.makeConstraints({ (make) in
            make.left.equalTo(imageV.snp.right).offset(10)
            make.centerY.equalTo(imageV.snp.centerY)
        })
        
        
        return v
    }()
    
    

}

extension ProductViewController:FSPagerViewDelegate,FSPagerViewDataSource, UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return arrayImage.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "productcell", at: index)
        cell.imageView?.kf_loadimageWithUrlString(url: arrayImage[index])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      
        DispatchQueue.main.asyncAfter(deadline:     DispatchTime.now()+0.5) {
            let contentsize = webView.scrollView.contentSize
            webView.frame = CGRect(x: 0, y: 0, width: screenWith, height: contentsize.height)
            self.table.tableFooterView = self.wkweb
        }
        
    }
    
    
}
