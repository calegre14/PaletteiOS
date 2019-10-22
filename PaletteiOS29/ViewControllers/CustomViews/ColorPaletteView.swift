//
//  ColorPaletteView.swift
//  PaletteiOS29
//
//  Created by Christopher Alegre on 10/22/19.
//  Copyright © 2019 Chris Alegre. All rights reserved.
//

import UIKit

class ColorPaletteView: UIView {
    var colors: [UIColor] {
        didSet {
            
        }
    }
    
    init(colors: [UIColor] = [], frame: CGRect = .zero) {
        self.colors = colors
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Create Subviews
    lazy var colorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    //MARK:- Add subviews & Constrain
    private func setUpViews() {
        addSubview(colorStackView)
        colorStackView.ancor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, topPadding: 0, bottomPadding: 0, leadingPadding: 0, trailingPaddding: 0)
    }
    
    private func generateBrickColor(for color: UIColor) -> UIView {
        let colorBrick = UIView()
        colorBrick.backgroundColor = color
        return colorBrick
    }
    
    private func resetColorBrick() {
        for subview in colorStackView.arrangedSubviews {
            self.colorStackView.removeArrangedSubview(subview)
        }
    }
    
    private func buildColorBricks() {
        resetColorBrick()
        for color in self.colors {
            let colorBrick = generateBrickColor(for: color)
            self.addSubview(colorBrick)
            self.colorStackView.addArrangedSubview(colorBrick)
        }
    }
}
