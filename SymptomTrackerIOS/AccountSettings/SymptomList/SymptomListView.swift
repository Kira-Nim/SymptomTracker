//
//  SymptomListView.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 21/05/2022.
//

import Foundation
import UIKit

final class SymptomListView: UITableView {
    init() {
        super.init(frame: CGRect.zero, style: .plain)
        backgroundColor = UIColor.appColor(name: .backgroundColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
