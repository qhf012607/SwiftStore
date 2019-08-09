//
//  HomeVCViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/25.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit
import RxSwift
import WebKit
import FSPagerView

class HomeVCViewController: MCRootViewController {
    var arrayData = [Product]()
    let arrayHead = ["footBal","basKet","tenis"]
    var collect : UICollectionView?
    var pageView : FSPagerView?
    var pagecontroll : FSPageControl?
    var customerServeUrl = ""
    var service = 0
    var webwk:WKWebView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        // Create a page control
        view.backgroundColor = viewBackColor
        HudTool.showloding()
        RONetCenter.customerService().subscribe(onNext: {[weak self] (data) in
            let dic = data as! Dictionary<String,Any>
            let datain = dic["Data"] as! Dictionary<String,Any>
            let swi = datain["swi"]
            let url = datain["url"]
            self?.customerServeUrl = url as! String
            self?.service = swi as! Int
            self?.updateUl()
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    func updateUl()  {
        DispatchQueue.main.async{
            if self.service == 1 {
                //customer service  客服
                let web = WKWebView(frame: .zero)
                self.webwk = web
                web.load( URLRequest(url: URL(string: self.customerServeUrl )!))
                UIApplication.shared.keyWindow!.addSubview(web)
                web.snp.makeConstraints { (make) in
                    make.edges.equalTo(UIEdgeInsets.zero)
                }
            }else{
                //   print("no message")
                self.collect?.reloadData()
            }
        }

       
    }
    
    func loadData()  {
        RONetCenter.requestForHome().mapModelArray(type: Product.self).subscribe(onNext: { [weak self] (data) in
            HudTool.hiddloading()
            self?.arrayData = data
            self?.ui()
            }, onError: { [weak self](error) in
                 HudTool.hiddloading()
                self?.collect?.removeFromSuperview()
               
                self?.showReloadButon {
                    self?.loadData()
                }
            }, onCompleted: {
                
        }, onDisposed: nil).disposed(by: disposeBag)
    }
    
    func ui() {
        if self.collect != nil {
              self.view.addSubview(self.collect!)
        }
        if !uiloaded {
            uiloaded = true
            let layout = UICollectionViewFlowLayout()
            
            let col = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
            collect = col
             col.backgroundColor = UIColor.white
            col.register( UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "homeCollect")
            col.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "homeheaderView")
            view.addSubview(col)
            col.delegate = self
            col.dataSource = self
            col.snp.makeConstraints { (make) in
                make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            }
            let pagerView = FSPagerView(frame: CGRect(x: 0, y: 0, width: screenWith, height: 200))
            pagerView.dataSource = self
            pagerView.delegate = self
            pagerView.isInfinite = true
            pagerView.automaticSlidingInterval = 3.0
            pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        //    col.tableHeaderView = pagerView
            let pageControl = FSPageControl(frame:CGRect.zero)
            pagerView.addSubview(pageControl)
            pageControl.snp.makeConstraints { (make) in
                make.width.equalTo(100)
                make.height.equalTo(20)
                make.bottom.equalTo(0)
                make.centerX.equalToSuperview()
            }
            pageControl.numberOfPages = arrayHead.count
            self.pagecontroll = pageControl
            self.pageView = pagerView
        }else{
            self.collect?.reloadData()
            self.pageView?.reloadData()
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func goVip()  {
        
    }
    
    func goDiscount()  {
        
    }
    
    lazy var headButonView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 200, width: screenWith, height: 150))
        view.backgroundColor = UIColor.white
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: 40, height: 40))
        button.layer.cornerRadius = 40
        button.setImage(UIImage(named: "discount"), for: .normal)
        view.addSubview(button)
        let lab = UILabel(frame: CGRect(x: 0, y: 50, width: 60, height: 20))
        lab.text = "领券中心"
        lab.textAlignment = .center
        
        view.addSubview(lab)
        lab.font = UIFont.systemFont(ofSize: 11)
        let buttonvip = UIButton(frame: CGRect(x: 10+60, y: 10, width: 40, height: 40))
        buttonvip.layer.cornerRadius = 40
        buttonvip.setImage(UIImage(named: "vip"), for: .normal)
        view.addSubview(buttonvip)
        let labvip = UILabel(frame: CGRect(x: 60, y: 50, width: 60, height: 20))
        labvip.text = "会员专享"
        view.addSubview(labvip)
        labvip.font = UIFont.systemFont(ofSize: 11)
        labvip.textAlignment = .center
        
        let viewLine = UIView(frame: CGRect(x: 0, y: 90, width: screenWith, height: 10))
        viewLine.backgroundColor = viewBackColor
        view.addSubview(viewLine)
     //   view.backgroundColor = viewBackColor
        
        let labText = UILabel(frame: CGRect(x: 0, y: 100, width: screenWith, height: 50))
        labText.text = "——————  热卖推荐  ——————"
        view.addSubview(labText)
        labText.font = UIFont.systemFont(ofSize: 14)
        labText.textAlignment = .center
        return view
    }()
}

extension HomeVCViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,FSPagerViewDelegate,FSPagerViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollect", for: indexPath) as! HomeCollectionViewCell
        let product = arrayData[indexPath.row]
        cell.configCell(product: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "homeheaderView", for: indexPath)
            
            header.addSubview(pageView!)
            header.addSubview(self.headButonView)
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = arrayData[indexPath.row]
        let cont = ProductViewController()
        cont.product_id = model.productId
        cont.cate = model
        self.navigationController?.pushViewController(cont, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenWith, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (screenWith-30)/2, height: (screenWith-30)/2*1.2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return arrayHead.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: arrayHead[index])
        return cell
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        self.pagecontroll?.currentPage  = pagerView.currentIndex
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        var id = "14"
        var title = ""
        
        if index == 0 {
            id = "41"
            title = "足球"
        }else if index == 1{
            id = "42"
             title = "蓝球"
        }else{
            id = "25"
             title = "网球"
        }
        let vc = CateSecondLevelViewController()
        vc.cateID = id
        vc.hiddenNav = false
        vc.title = title
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    
}
