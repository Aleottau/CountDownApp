//
//  ViewController.swift
//  CountDownApp
//
//  Created by alejandro on 10/01/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var timer = TimerView()

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        self.view.backgroundColor = UIColor.blue
        timer.setTime = 20
    }

    func makeConstraints() {
        view.addSubview(timer)
        timer.translatesAutoresizingMaskIntoConstraints = false
        timer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

