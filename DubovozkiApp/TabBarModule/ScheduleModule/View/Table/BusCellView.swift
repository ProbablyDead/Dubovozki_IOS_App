//
//  CellViewController.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 08.12.2023.
//

import UIKit

class BusCell: UITableViewCell {
    static let reuseID: String = "BusCell"
    
    var typeOfBus: Filters.typeOfBus = .default_
    
    private enum Constants {
        static let timeTextSize: CGFloat = 26
        
        static let leftTimeTextSize: CGFloat = 15
        static let leftTimeWidth: CGFloat = UIScreen.main.bounds.width/5
        static let leftTimeHeigthDevider: CGFloat = 1.5
        static let leftTimeCornerRadius: CGFloat = 5
        static let leftTimeOffset: CGFloat = 20
        
        static let stationTextSize: CGFloat = 20
        static let stationOffsetFromCenter: CGFloat = 30
    }
    
    private let stationLabel: UILabel = {
        let controller = UILabel()
        controller.backgroundColor = .clear
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.font = .systemFont(ofSize: Constants.stationTextSize)
        return controller
    }()
    
    private let leftTimeLabel: UILabel = {
        let controller = UILabel()
        controller.backgroundColor = .clear
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.font = .systemFont(ofSize: Constants.leftTimeTextSize)
        controller.textAlignment = .center
        controller.layer.cornerRadius = Constants.leftTimeCornerRadius
        controller.clipsToBounds = true
        return controller
    }()
    
    private func chooseTypeOfBus(busTime: Int64) -> Filters.typeOfBus {
        let calendar = Calendar.current
        let now = Date()
        
        let midnight = calendar.startOfDay(for: now)
        let milliseconds = Int64(now.timeIntervalSince(midnight) * 1000)
        
        if busTime < milliseconds {
            return Filters.typeOfBus.passed
        } else {
            if (busTime - milliseconds) <= Filters.closeBusTime {
                return Filters.typeOfBus.close
            } else {
                return Filters.typeOfBus.default_
            }
        }
    }
    
    private func getTimeDifference(busTime: Int64) -> String {
        let calendar = Calendar.current
        let now = Date()
        
        let midnight = calendar.startOfDay(for: now)
        let milliseconds = Int64(now.timeIntervalSince(midnight) * 1000)
        
        let difference = busTime - milliseconds
        
        let houres = difference/3600000
        let minutes: Int64 = (difference - 3600000 * houres)/60000
        
        let houresStr = (houres != 0) ? "\(abs(houres)) " + "h".localized() + " " : ""
        let minutesStr = (minutes != 0) ? "\(abs(minutes)) " + "min".localized() : ""
        let combinedStr = houresStr + minutesStr
        
        return (houres == 0 && minutes == 0) ? "Leaving now".localized() :
        (difference < 0 ? combinedStr + " " + "ago".localized() : "in".localized() + " " + combinedStr)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureDefaultCell(time: Int64, timeString: String, station: Filters.station) {
        textLabel?.text = timeString
        
        stationLabel.text = station.title.localized()
        leftTimeLabel.isHidden = true
        
        if station == .mld {
            textLabel?.textColor = .app
            stationLabel.textColor = .app
        } else if station == .slv {
            textLabel?.textColor = .systemGreen
            stationLabel.textColor = .systemGreen
        } else {
            textLabel?.textColor = .label
            stationLabel.textColor = .label
        }
    }
    
    func configureTodayCell(time: Int64, timeString: String, station: Filters.station) {
        configureDefaultCell(time: time, timeString: timeString, station: station)
        leftTimeLabel.isHidden = false
        leftTimeLabel.text = getTimeDifference(busTime: time)
        
        typeOfBus = chooseTypeOfBus(busTime: time)
        switch typeOfBus {
        case .default_:
            leftTimeLabel.backgroundColor = .clear
            leftTimeLabel.textColor = .label
        case .close:
            leftTimeLabel.backgroundColor = .systemRed
            leftTimeLabel.textColor = .white
        case .passed:
            leftTimeLabel.backgroundColor = .clear
            leftTimeLabel.textColor = .secondaryLabel
            stationLabel.textColor = .secondaryLabel
            textLabel?.textColor = .secondaryLabel
        }
    }
    
    private func configureUI() {
        backgroundColor = .clear
        textLabel!.font = .systemFont(ofSize: Constants.timeTextSize)
        
        addSubview(leftTimeLabel)
        addSubview(stationLabel)
        
        leftTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.leftTimeWidth + Constants.leftTimeOffset).isActive = true
        leftTimeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        leftTimeLabel.rightAnchor.constraint(equalTo: stationLabel.leftAnchor, constant: -Constants.leftTimeOffset).isActive = true
        leftTimeLabel.heightAnchor.constraint(equalToConstant: frame.height/Constants.leftTimeHeigthDevider).isActive = true
        
        stationLabel.leftAnchor.constraint(equalTo: centerXAnchor, constant: Constants.stationOffsetFromCenter).isActive = true
        stationLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stationLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
