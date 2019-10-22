//
//  PalleteTableViewCell.swift
//  PaletteiOS29
//
//  Created by Christopher Alegre on 10/22/19.
//  Copyright © 2019 Chris Alegre. All rights reserved.
//

import UIKit

class PaletteTableViewCell: UITableViewCell {
    
    var photo: UnsplashPhoto? {
        didSet {
            updateViews()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpViews()
    }
    
    //MARK:- Declare Subviews
    lazy var photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = (contentView.frame.height / 20)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var paletteTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var colorPaletteView: ColorPaletteView = {
        let paletteView = ColorPaletteView()
        paletteView.clipsToBounds = true
        paletteView.layer.cornerRadius = (SpacingConstants.twoLineElementHeight / 2)
        return paletteView
    }()
    
    //MARK:- Add Subviews
    func addAllSubviews() {
        self.addSubview(photoImageView)
        self.addSubview(paletteTitleLabel)
        self.addSubview(colorPaletteView)
    }
    
    //MARK:- Constrain views
    func setUpViews() {
        addAllSubviews()
        
        let imageDimensions = (contentView.frame.width - (SpacingConstants.outerHorizontalPadding * 2))
        
        photoImageView.ancor(top: contentView.topAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: SpacingConstants.outerVerticalPadding, bottomPadding: 0, leadingPadding: SpacingConstants.outerHorizontalPadding, trailingPaddding: SpacingConstants.outerHorizontalPadding, width: imageDimensions, height: imageDimensions)
        
        paletteTitleLabel.ancor(top: photoImageView.bottomAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: SpacingConstants.verticalObjectBuffer, bottomPadding: 0, leadingPadding: SpacingConstants.outerHorizontalPadding, trailingPaddding: SpacingConstants.outerHorizontalPadding, width: nil, height: SpacingConstants.oneLineElementHeight)
        
        colorPaletteView.ancor(top: paletteTitleLabel.bottomAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, topPadding: SpacingConstants.verticalObjectBuffer, bottomPadding: SpacingConstants.outerVerticalPadding, leadingPadding: SpacingConstants.outerHorizontalPadding, trailingPaddding: SpacingConstants.outerHorizontalPadding, width: nil, height: SpacingConstants.twoLineElementHeight)
    }
    
    func updateViews() {
        guard let photo = photo else {return}
        fetchAndSetImage(for: photo)
        fetchAndSetColors(for: photo)
        paletteTitleLabel.text = photo.description
    }
    
    func fetchAndSetImage(for photo: UnsplashPhoto) {
        UnsplashService.shared.fetchImage(for: photo) { (image) in
            DispatchQueue.main.async {
                self.photoImageView.image = image
            }
        }
    }
    
    func fetchAndSetColors(for photo: UnsplashPhoto) {
        ImaggaService.shared.fetchColorsFor(imagePath: photo.urls.regular) { (colors) in
            DispatchQueue.main.async {
                guard let colors = colors else {return}
                self.colorPaletteView.colors = colors
            }
        }
    }
}
