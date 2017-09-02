//
//  UIFont+Extensions.swift
//  Kerner
//
//  Created by Taishi Ikai on 2017/09/02.
//  Copyright © 2017年 Ikai. All rights reserved.
//

import UIKit
import CoreText

public extension UIFont {

    public var altHalf: UIFont {

        let weight: UIFont.Weight = {

            var weight = UIFont.Weight.regular

            let usageAttribute = self.fontDescriptor.fontAttributes[
                .init(rawValue: "NSCTFontUIUsageAttribute")] as? String ?? ""

            switch usageAttribute {
                case "CTFontEmphasizedUsage", "CTFontBoldUsage":
                    weight = .bold
                default:
                    break
            }

            return weight
        }()

        let familyName = self.familyName.starts(with: ".SF") ? "Hiragino Sans" : self.familyName

        let featureSettings: [[UIFontDescriptor.FeatureKey: Int]] = [
            [
                .featureIdentifier: kTextSpacingType,
                .typeIdentifier: kAltHalfWidthTextSelector
            ]
        ]

        let traits: [UIFontDescriptor.TraitKey: CGFloat] = [
            .weight: weight.rawValue
        ]

        let fontDescriptor = UIFontDescriptor(fontAttributes: [
            .family: familyName,
            .traits: traits,
            .featureSettings: featureSettings,
        ])

        return UIFont(descriptor: fontDescriptor, size: self.pointSize)
    }
}
