//
//  ViewController.swift
//  LZCache
//
//  Created by 湛亚磊 on 2020/3/14.
//  Copyright © 2020 湛亚磊. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class ViewController: UIViewController {
    let disposeBag=DisposeBag()
    private lazy var tableView: UITableView = {
        let tableView=UITableView(frame: self.view.bounds)
        tableView.register(LZCell.self, forCellReuseIdentifier: "LZCell")
        tableView.dataSource=self
        tableView.delegate=self
        return tableView
    }()
    
    var vm:VMModel = VMModel()
    
    var models:[GoodModel] = [GoodModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        
        vm.input.getHomeInfo.onNext(())
        vm.output.getHomeInfoOut.drive(onNext: {[weak self] (models) in
            self?.models=models
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}
extension ViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LZCell = tableView.dequeueReusableCell(withIdentifier: "LZCell", for: indexPath) as! LZCell
        cell.model = models[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return models[indexPath.row].cellHeight
    }
    
}

