//
//  L10NServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 11/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation

class L10NServiceImp : L10NServiceProtocol {
    
    private let _reportService: ReportServiceProtocol
    
    init(reportService: ReportServiceProtocol) {
        self._reportService = reportService
    }
    
    private var _currentLanguage: String?
    private let _supportedLanguages: [String] = ["en", "pt"]
    private let _defaultLanguage: String = "en"
    private var _resourceManager: [Literal] = []
    
    func localize(key: String) -> String {
        let value = _getResourceManager().first(where: { $0.key == key })
        return value?.translated ?? ""
    }
    
    func _getResourceManager() -> [Literal] {
        if(_resourceManager.isEmpty) {
            _setLanguage()
            _loadJsonString()
        }
        
        return _resourceManager
    }
    
    func _setLanguage() {
        let deviceLanguage = Locale.current.languageCode
        _currentLanguage = _supportedLanguages.first(where: { $0 == deviceLanguage }) ?? _defaultLanguage
    }
    
    func _loadJsonString() {
        if let path = Bundle.main.path(forResource: _currentLanguage, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! NSDictionary
                for (key, value) in jsonResult {
                    _resourceManager.append(Literal(key: key as! String, translated: value as! String))
                }
          } catch let error {
                _reportService.sendError(error: error, message: "Error loading json")
            }
        }
    }
    
    func getCurrentLanguage() -> String {
        if(_currentLanguage == nil) {
            _setLanguage()
        }
        
        return _currentLanguage!
    }
}
