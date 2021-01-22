//
//  VDSTextField.swift
//  PoingDesignSystem
//
//  Created by Hanteo on 2021/01/22.
//

import UIKit

public class VDSTextField: UITextField {
    enum Constant {
        enum TextField {
            static let font = UIFont.systemFont(ofSize: 20, weight: .bold)
            static let color = UIColor.midnight
        }
        enum Line {
            static let color = UIColor.grey244
            static let height: CGFloat = 1
        }
    }
    
    public override var placeholder: String? {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let atrributes: [NSAttributedString.Key : Any] = [
                .font: UIFont(name: "AppleSDGothicNeo-Bold", size: 20) as Any,
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.veryLightPink
            ]
            let attrString = NSAttributedString(string: placeholder ?? "", attributes: atrributes)
            
            self.attributedPlaceholder = attrString
        }
    }
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Constant.Line.color
        return view
    }()
    
    public init() {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        lineView.frame = CGRect(x: 0, y: bounds.height, width: bounds.width, height: Constant.Line.height)
    }
    
    func configureLauyout() {
        textAlignment = .center
        font = Constant.TextField.font
        tintColor = Constant.TextField.color
        textColor = Constant.TextField.color
        
        addSubview(lineView)
    }
}
