//
//  Tabs.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 09.12.2023.
//

import UIKit

// MARK: - Tabbed view delegate protocol
protocol TabbedViewDelegate: AnyObject {
    func didMoveToTab(at index: Int)
}

// MARK: - Tabbed view
class TabbedView: UIView {
    public weak var delegate: TabbedViewDelegate?
    private var currentSelectedIndex: Int = 0
    private var tabHeight: CGFloat
    
    public var tabs: [TabItemProtocol] {
        didSet {
            self.collectionView.reloadData()
            self.tabs[currentSelectedIndex].onSelected()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.register(TabCollectionViewCell.self, forCellWithReuseIdentifier: TabCollectionViewCell.reuseID)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints =  false
        return collectionView
    }()
    
    init(tabs: [TabItemProtocol] = [], tabHeight: CGFloat) {
        self.tabs = tabs
        self.tabHeight = tabHeight
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    public func moveToTab(at index: Int) {
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
        tabs[currentSelectedIndex].onNotSelected()
        tabs[index].onSelected()
        currentSelectedIndex = index
    }
}
extension TabbedView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width/CGFloat(tabs.count), height: tabHeight)
    }
    
}

extension TabbedView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCollectionViewCell.reuseID, for: indexPath)
                as? TabCollectionViewCell else { return UICollectionViewCell() }
        cell.view = tabs[indexPath.row]
        return cell
    }
}

extension TabbedView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.moveToTab(at: indexPath.item)
        self.delegate?.didMoveToTab(at: indexPath.item)
    }
}
