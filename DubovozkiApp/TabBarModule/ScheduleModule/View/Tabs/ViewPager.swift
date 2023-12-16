//
//  ViewPager.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 09.12.2023.
//

import UIKit

class ViewPager: UIView {
    public lazy var tabbedView: TabbedView = TabbedView(tabHeight: tabHeight)
    public let pagedView: PagedView = PagedView()
    public var tabHeight: CGFloat
    
    init(tabHeight: CGFloat = 50) {
        self.tabHeight = tabHeight
        super.init(frame: .zero)
        
        tabbedView.delegate = self
        pagedView.delegate = self
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(tabbedView)
        addSubview(pagedView)
        
        tabbedView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tabbedView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tabbedView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tabbedView.heightAnchor.constraint(equalToConstant: tabHeight).isActive = true
        
        pagedView.topAnchor.constraint(equalTo: tabbedView.bottomAnchor).isActive = true
        pagedView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        pagedView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        pagedView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension ViewPager: TabbedViewDelegate {
    func didMoveToTab(at index: Int) {
        pagedView.moveToPage(at: index)
    }
}

extension  ViewPager: PagedViewDelegate {
    func didMoveToPage(index: Int) {
        tabbedView.moveToTab(at: index)
    }
}
