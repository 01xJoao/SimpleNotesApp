//
//  NoteCell.swift
//  SimpleNotes
//
//  Created by João Palma on 20/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation
import LBTATools

class NoteCell: LBTAListCell<UIColor> {
    public override var item: UIColor! {
        didSet {
            backgroundColor = item
        }
    }
}
