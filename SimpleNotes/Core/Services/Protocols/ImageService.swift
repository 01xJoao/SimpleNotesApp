//
//  ImageService.swift
//  SimpleNotes
//
//  Created by João Palma on 17/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit

protocol ImageService {
    func uploadImage(image: UIImage, completion: @escaping (String?) -> Void)
}
