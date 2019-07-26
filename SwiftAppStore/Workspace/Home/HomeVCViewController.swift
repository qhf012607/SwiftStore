//
//  HomeVCViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/25.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit
import RxSwift

import FSPagerView

class HomeVCViewController: MCRootViewController {
    var arrayData = [Product]()
    let arrayHead = ["footBal","basKet","tenis"]
    var collect : UICollectionView?
    var pageView : FSPagerView?
    var pagecontroll : FSPageControl?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        // Create a page control
        
    }
    
    func loadData()  {
        RONetCenter.requestForHome().mapModelArray(type: Product.self).subscribe(onNext: { [weak self] (data) in
            self?.arrayData = data
            self?.ui()
            }, onError: { [weak self](error) in
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
        let view = UIView(frame: CGRect(x: 0, y: 200, width: screenWith, height: 100))
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
        view.backgroundColor = UIColor(red: 237/255.0, green: 237/255.0, blue: 237/255.0, alpha: 1)
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenWith, height: 300)
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
    
   
    
}