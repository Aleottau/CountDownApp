//
//  TimerTestXib.swift
//  CountDownApp
//
//  Created by alejandro on 16/01/23.
//

import UIKit

class TimerTestXib: UIView {

    @IBOutlet weak var timerLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func loadView() -> UIView {
        let bundleName = Bundle(for: type(of: self))
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundleName)
        let view = nib.instantiate(withOwner: nil).first as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
