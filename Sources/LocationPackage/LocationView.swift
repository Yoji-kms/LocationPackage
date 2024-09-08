//
//  WeatherView.swift
//  MiniApps
//
//  Created by Yoji on 08.09.2024.
//

import UIKit

public final class LocationView: UIView {
//    MARK: Variables
    private let viewModel = LocationViewModel()
    
//    MARK: Views
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    MARK: Lifecycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Setups
    private func setupViews() {
        self.addSubview(self.label)
        self.update()
        
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.topAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.label.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.label.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
//    MARK: Methods
    public func update() {
        self.viewModel.updateLocation() { [weak self] newLocation in
            guard let self else { return }
            DispatchQueue.main.async {
                self.label.text = newLocation
            }
        }
    }
}
