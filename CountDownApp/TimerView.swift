//
//  TimerView.swift
//  CountDownApp
//
//  Created by alejandro on 10/01/23.
//

import UIKit
import SnapKit

class TimerView: UIView {
    var setTime = 0
    private var time: Timer?
    private let hoursLabel = UILabel()
    private let minLabel = UILabel()
    private let secondLabel = UILabel()
    private let pointsLabel = UILabel()
    var not: NotificationCenter = NotificationCenter.default
    var dateBackground: Date?
    var timeIntervalBetweenForgandBackg = 0


    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpObserver()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layerConfig(for: hoursLabel)
        layerConfig(for: minLabel)
        layerConfig(for: secondLabel)
    }
    func setUpObserver() {
        not.addObserver(self, selector: #selector(appMovedToBackground), name: UIScene.didEnterBackgroundNotification, object: nil)
        not.addObserver(self, selector: #selector(appMovedToForeground), name: UIScene.willEnterForegroundNotification, object: nil)
    }
    @objc func appMovedToBackground() {
        dateBackground = Date()
    }
    @objc func appMovedToForeground() {
        guard let date = dateBackground else {
            return
        }
        timeIntervalBetweenForgandBackg = Int(Date().timeIntervalSince(date))
        setTime -= timeIntervalBetweenForgandBackg
    }
    
    private func makeConstraints() {
        addSubview(hoursLabel)
        addSubview(minLabel)
        addSubview(secondLabel)
        addSubview(pointsLabel)
        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        hoursLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(45)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        pointsLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(hoursLabel).inset(90)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        minLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(hoursLabel).inset(110)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        secondLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(minLabel).inset(100)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
    }
    private func setUpView(){
        layer.backgroundColor = UIColor.white.cgColor
        makeConstraints()
        labelconfig(label: hoursLabel)
        labelconfig(label: minLabel)
        labelconfig(label: secondLabel)
        hoursLabel.text = "00"
        pointsLabel.font = UIFont.preferredFont(forTextStyle: .title1).withSize(45)
        pointsLabel.text = ":"
        minLabel.text = "00"
        secondLabel.text = "00"
        createTimer()
    }
     private func createTimer() {
        time = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(startTimer),
            userInfo: nil,
            repeats: true
        )
    }

    @objc func startTimer() {
        if setTime != 0 && setTime > 0 {
            let seconds = setTime % 60
            let mins =  (setTime/60) % 60
            let hours =  (setTime/3600)
            secondLabel.text = String(format: "%02d", seconds)
            minLabel.text = String(format: "%02d", mins)
            hoursLabel.text = String(format: "%02d", hours)
            setTime -= 1
        } else if let time = time {
            secondLabel.text = String(format: "%02d", 0)
            time.invalidate()
            showAlert()
        }
        
    }
    private func labelconfig(label: UILabel) {
        let fontLabel = UIFont.preferredFont(forTextStyle: .title1).withSize(25)
        let color = UIColor.purple.cgColor
        label.font = fontLabel
        label.textColor = UIColor(cgColor: color)
        label.textAlignment = .center
        label.clipsToBounds = true
    }
    private func layerConfig(for label: UILabel) {
        label.layer.borderWidth = 0.7
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.masksToBounds = true
        label.layer.cornerRadius = label.frame.width/2
    }
    private func showAlert() {
        lazy var alert = UIAlertController(title: "Finish", message: "The count down has been finished.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
        }))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true)
    }
}
