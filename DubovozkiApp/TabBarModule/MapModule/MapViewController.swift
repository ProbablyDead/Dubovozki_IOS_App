//
//  MapViewController.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 05.12.2023.
//

import UIKit

class MapViewController: UIViewController {
    
    private let cardView: WayCardView = WayCardView(title: "Slavyansky", image: "Slavyansky Bulvar Enterance")

    private lazy var navButton: UIButton = {
        let controller = UIButton()
        controller.setTitle("View in maps", for: .normal)
        controller.backgroundColor = .app
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return controller
    }()
    
    @objc
    private func buttonPressed(_ sender: UIButton) {
        if let url = URL(string: "https://yandex.ru/maps/-/CDqJJLNi") {
            UIApplication.shared.open(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
//        view.addSubview(navButton)
//        view.addSubview(wayCard)
        
//        wayCard.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        wayCard.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        wayCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        wayCard.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
//        if let im = UIImage(named: "Slavyansky Bulvar Enterance") {
//            let imV = UIImageView(image: im)
//            imV.frame = CGRect(x: 0, y: 10, width: view.bounds.width, height: view.bounds.height/2)
//            imV.addSubview(navButton)
//            navButton.centerXAnchor.constraint(equalTo: imV.centerXAnchor).isActive = true
//            navButton.centerYAnchor.constraint(equalTo: imV.centerYAnchor).isActive = true
//            view.addSubview(imV)
            
//            imV.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//            imV.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//            imV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//            imV.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        }
        
        view.addSubview(cardView)
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cardView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        cardView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        cardView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
    }
}
