//
//  NotesListViewModel.swift
//  SimpleNotes
//
//  Created by João Palma on 19/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

public class NotesListViewModel : ViewModelBase {
    private var _navigateToCreateNoteCommand: Command?
    public var navigateToCreateNoteCommand: Command {
        get { _navigateToCreateNoteCommand ??= Command(_navigateToCreateNote); return _navigateToCreateNoteCommand!}
    }
    
    
    private func _navigateToCreateNote() {
        navigationService.navigateModal(viewModel: CreateNoteViewModel.self, arguments: nil)
    }
    
}
