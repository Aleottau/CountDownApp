//
//  XibViewController.swift
//  CountDownApp
//
//  Created by alejandro on 16/01/23.
//

import UIKit
import SnapKit

class XibViewController: UIViewController {
    
    let timerXib = TimerTestXib().loadView() as! TimerTestXib

    override func viewDidLoad() {
        super.viewDidLoad()
        timerXibConfig()
        timerXib.timerLabel.text = "hola"
    }
    
    func timerXibConfig() {
        view.addSubview(timerXib)
        timerXib.translatesAutoresizingMaskIntoConstraints = false
        timerXib.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
