//
//  NotesListViewController.swift
//  SimpleNotes
//
//  Created by João Palma on 19/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import Foundation
import LBTATools

class NotesListViewController : BaseListViewController<NotesListViewModel, NoteCell, UIColor>, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        _setupView()
    }
    
    private func _setupView() {
        items = [
            UIColor.Theme.blue, UIColor.Theme.mainBlue, UIColor.Theme.darkBlue,
            UIColor.Theme.blue, UIColor.Theme.mainBlue, UIColor.Theme.darkBlue,
            UIColor.Theme.blue, UIColor.Theme.mainBlue, UIColor.Theme.darkBlue,
            UIColor.Theme.blue, UIColor.Theme.mainBlue, UIColor.Theme.darkBlue
        ]
        
        let systemBarBtn = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(createNote))
        systemBarBtn.tintColor = UIColor.Theme.white
        
        self.title = "Notes"
        self.view.backgroundColor = UIColor.Theme.white
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = systemBarBtn
    }
    
    @objc fileprivate func createNote() {
        viewModel.navigateToCreateNoteCommand.execute()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewlayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
}
