//
//  ModelView.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 02.12.2023.
//
import Foundation
import UIKit

// MARK: - Schedule view protocol
protocol ScheduleViewProtocol: AnyObject {
    func setSchedule()
    var mskTableView: ScheduleTableView { get }
    var dubkiTableView: ScheduleTableView { get }
}

// MARK: - Schedule view presenter protocol
protocol ScheduleViewPresenterProtocol: AnyObject {
    init(view: ScheduleViewProtocol, model: ModelProtocol)
    func getData()
    func filterData(station: String, date: String)
    func scrollToClosest(table: UITableView, animated: Bool)
}

// MARK: - Schedule view presenter 
class ScheduleViewPresenter: NSObject, ScheduleViewPresenterProtocol {
    private enum Constants {
        static let millisecondsInDay: Int64 = 86400000
        static let millisecondsInMinute: Int64 = 60000
        
        static let updateTablesTimeSeconds: TimeInterval = 3
        static let updateDataTimeSeconds: TimeInterval = 60
    }
    
    private var refreshTablesTimer: Timer?
    private var refreshDataTimer: Timer?
    private var currentSelectionOfDate: Filters.date = Filters.date.today
    private var currentSelectionOfStation: Filters.station = Filters.station.all
    private var closestMskBus: IndexPath = IndexPath(item: 0, section: 0)
    private var closestDubkiBus: IndexPath = IndexPath(item: 0, section: 0)
    
    func filterData(station: String, date: String) {
        mskBuses = buses?.filter { $0.direction == Filters.direction.msk.rawValue }
        dubkiBuses = buses?.filter { $0.direction == Filters.direction.dbk.rawValue }
        
        if station != Filters.station.all.rawValue {
            mskBuses = mskBuses?.filter { $0.station == station }
            dubkiBuses = dubkiBuses?.filter { $0.station == station }
        }
        
        if let stationEnum = Filters.station(rawValue: station) {
            currentSelectionOfStation = stationEnum
        }
        
        guard let date = Int(date) else { return }
        
        if date == Filters.date.today.rawValue {
            mskBuses = mskBuses?.filter { $0.day == Filters.date.todayVar }
            dubkiBuses = dubkiBuses?.filter { $0.day == Filters.date.todayVar }
        } else if date == Filters.date.tomorrow.rawValue {
            mskBuses = mskBuses?.filter { $0.day == Filters.date.tomorrowVar }
            dubkiBuses = dubkiBuses?.filter { $0.day == Filters.date.tomorrowVar }
        } else {
            mskBuses = mskBuses?.filter { $0.day == date }
            dubkiBuses = dubkiBuses?.filter { $0.day == date }
        }
        
        if let dataEnum = Filters.date(rawValue: date) {
            currentSelectionOfDate = dataEnum
        }
        
        refreshTables()
    }
    
    func scrollToClosest(table: UITableView, animated: Bool) {
        var cell: UITableViewCell? = nil
        
        if table == view?.mskTableView {
            if self.mskBuses?.count != 0 {
                table.scrollToRow(at: self.closestMskBus, at: .top, animated: animated)
                cell = table.cellForRow(at: self.closestMskBus)
            } else { return }
        }
        
        if table == view?.dubkiTableView {
            if self.dubkiBuses?.count != 0 {
                table.scrollToRow(at: self.closestDubkiBus, at: .top, animated: animated)
                cell = table.cellForRow(at: self.closestDubkiBus)
            } else { return }
        }
        
        if let cell = cell, animated {
            animateCell(cell: cell)
        }
    }
    
    private func animateCell(cell: UITableViewCell) {
        UIView.animate(withDuration: 0.5, animations: {
            cell.contentView.backgroundColor = UIColor.lightGray
        }) { (completed) in
            UIView.animate(withDuration: 0.5, animations: {
                cell.contentView.backgroundColor = UIColor.clear
            })
        }
    }
    
    private func processBusSchedule(buses: [Bus]) -> [Bus] {
        var processedBuses: [Bus] = buses
        
        processedBuses = processedBuses.map { bus in
            if bus.day == Filters.date.sunday.rawValue && bus.dayTime >= Constants.millisecondsInDay {
                bus.day = Int16(Filters.date.monday.rawValue)
                bus.dayTime -= Constants.millisecondsInDay
            }
            
            if bus.day == Filters.date.saturday.rawValue && bus.dayTime >= Constants.millisecondsInDay {
                bus.day = Int16(Filters.date.sunday.rawValue)
                bus.dayTime -= Constants.millisecondsInDay
            }
            
            if bus.day == Filters.date.monday.rawValue && bus.dayTime >= Constants.millisecondsInDay {
                bus.day = Int16(Filters.date.saturday.rawValue)
                bus.dayTime -= Constants.millisecondsInDay
            }
            
            if bus.day == Filters.date.weekdays.rawValue && bus.dayTime >= Constants.millisecondsInDay {
                bus.dayTime -= Constants.millisecondsInDay
            }
            
            return bus
        }
        
        processedBuses.sort { $0.dayTime < $1.dayTime }
        return processedBuses
    }
    
    private func setClosest() {
        let calendar = Calendar.current
        let now = Date()
        
        let midnight = calendar.startOfDay(for: now)
        let milliseconds = Int64(now.timeIntervalSince(midnight) * 1000)
        
        closestMskBus.item = mskBuses?.firstIndex {
            let dif = ($0.dayTime + Constants.millisecondsInMinute - milliseconds)
            return dif > 0
        } ?? 0
        
        closestDubkiBus.item = dubkiBuses?.firstIndex {
            let dif = ($0.dayTime + Constants.millisecondsInMinute - milliseconds)
            return dif > 0
        } ?? 0
    }
    
    private var buses: [Bus]? {
        didSet {
            if let buses = buses {
                self.buses = processBusSchedule(buses: buses)
                stopLoading()
            }
            mskBuses = buses?.filter { $0.direction == Filters.direction.msk.rawValue }
            mskBuses = mskBuses?.filter { $0.day == Filters.date.todayVar }
            dubkiBuses = buses?.filter { $0.direction == Filters.direction.dbk.rawValue }
            dubkiBuses = dubkiBuses?.filter { $0.day == Filters.date.todayVar }
        }
    }
    
    private var mskBuses: [Bus]? 
    private var dubkiBuses: [Bus]?
    
    @objc
    private func refreshTables() {
        setClosest()
        view?.mskTableView.reloadData()
        view?.dubkiTableView.reloadData()
    }
    
    private func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.setSchedule()
            self?.refreshTables()
            
            if let mskTableView = self?.view?.mskTableView, let dubkiTableView = self?.view?.dubkiTableView {
                self?.scrollToClosest(table: mskTableView, animated: false)
                self?.scrollToClosest(table: dubkiTableView, animated: false)
            }
        }
    }
    
    @objc
    private func checkForUpdate() -> [Bus]? {
        model?.getRawData(dataChanged: { [weak self] result in
            self?.buses = result
        })
    }
    
    public func getData() {
        buses = checkForUpdate()
    }
    
    weak var view: ScheduleViewProtocol?
    var model: ModelProtocol?
    
    private func refreshDate() {
        setClosest()
        
        view?.mskTableView.reloadData()
        view?.dubkiTableView.reloadData()
    }
    
    @objc
    private func timedRefresh() {
        mskBuses = buses?.filter { $0.direction == Filters.direction.msk.rawValue }
        dubkiBuses = buses?.filter { $0.direction == Filters.direction.dbk.rawValue }
        
        if currentSelectionOfStation != Filters.station.all {
            mskBuses = mskBuses?.filter { $0.station == currentSelectionOfStation.rawValue }
            dubkiBuses = dubkiBuses?.filter { $0.station == currentSelectionOfStation.rawValue }
        }
        
        if currentSelectionOfDate == Filters.date.today {
            mskBuses = mskBuses?.filter { $0.day == Filters.date.todayVar }
            dubkiBuses = dubkiBuses?.filter { $0.day == Filters.date.todayVar }
        } else if currentSelectionOfDate == Filters.date.tomorrow {
            mskBuses = mskBuses?.filter { $0.day == Filters.date.tomorrowVar }
            dubkiBuses = dubkiBuses?.filter { $0.day == Filters.date.tomorrowVar }
        } else {
            mskBuses = mskBuses?.filter { $0.day == currentSelectionOfDate.rawValue }
            dubkiBuses = dubkiBuses?.filter { $0.day == currentSelectionOfDate.rawValue }
        }
        
        refreshTables()
    }
    
    required init(view: ScheduleViewProtocol, model: ModelProtocol) {
        super.init()
        
        self.refreshTablesTimer = Timer(timeInterval: Constants.updateTablesTimeSeconds, target: self,
                                         selector: #selector(self.timedRefresh), userInfo: nil, repeats: true)
        self.refreshDataTimer = Timer(timeInterval: Constants.updateDataTimeSeconds, target: self,
                                       selector: #selector(self.checkForUpdate), userInfo: nil, repeats: true)
        RunLoop.main.add(self.refreshTablesTimer!, forMode: .default)
        RunLoop.main.add(self.refreshDataTimer!, forMode: .default)
        
        self.view = view
        self.model = model
    }
}

extension ScheduleViewPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case view?.mskTableView:
            self.mskBuses?.count ?? 0
        case view?.dubkiTableView:
            self.dubkiBuses?.count ?? 0
        default:
            self.buses?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: BusCell = tableView.dequeueReusableCell(withIdentifier: BusCell.reuseID, for: indexPath)
                as? BusCell else { return UITableViewCell() }
        
        switch tableView {
        case view?.mskTableView:
            guard let bus = mskBuses?[indexPath.row] else { return cell }
            if self.currentSelectionOfDate == Filters.date.today {
                cell.configureTodayCell(time: bus.dayTime,
                                          timeString: bus.dayTimeString ?? "",
                                          station: Filters.station(rawValue: bus.station!)!)
            } else {
                cell.configureDefaultCell(time: bus.dayTime,
                                          timeString: bus.dayTimeString ?? "",
                                          station: Filters.station(rawValue: bus.station!)!)
            }
            
        case view?.dubkiTableView:
            guard let bus = dubkiBuses?[indexPath.row] else { return cell }
            if self.currentSelectionOfDate == Filters.date.today {
                cell.configureTodayCell(time: bus.dayTime,
                                          timeString: bus.dayTimeString ?? "",
                                          station: Filters.station(rawValue: bus.station!)!)
            } else {
                cell.configureDefaultCell(time: bus.dayTime,
                                          timeString: bus.dayTimeString ?? "",
                                          station: Filters.station(rawValue: bus.station!)!)
            }
            
        default:
            return UITableViewCell()
        }
        
        return cell
    }
}
