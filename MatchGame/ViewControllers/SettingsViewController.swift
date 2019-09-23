//
//  SettingsViewController.swift
//  MatchGame
//
//  Created by Nikolai Prokofev on 2019-09-22.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import UIKit
import SPStorkController
import ValueStepper

protocol GameConfigurationChangeable: class {
    func didChangeConfiguration()
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var difficultySegmentControl: UISegmentedControl!
    @IBOutlet weak var gridSizeStepper: ValueStepper!
    @IBOutlet weak var difficultyDescriptionLabel: UILabel!
    
    private var configuration = UserDefaultsManager.get(GameSessionConfiguration.self) ?? GameSessionConfiguration()
    weak var delegate: GameConfigurationChangeable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        difficultySegmentControl.selectedSegmentIndex = configuration.difficulty.rawValue
        gridSizeStepper.value = Double(configuration.scoreToWin)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func difficultyChanged(_ sender: UISegmentedControl) {
        guard let difficulty = Difficulty(rawValue: sender.selectedSegmentIndex) else { return }
        difficultyDescriptionLabel.text = difficulty.description
    }
    
    @IBAction func grisSizeValueChanged(_ sender: Any) {
        
    }
    
    private func saveSettings() {
        //FIX: check if values has been changed
        if isConfigurationChanged() {
            guard let difficulty = Difficulty(rawValue: difficultySegmentControl.selectedSegmentIndex) else { return }
            let gridSizeValue = Int(gridSizeStepper.value)
            UserDefaultsManager.save(GameSessionConfiguration(scoreToWin: gridSizeValue, difficulty: difficulty))
            
            delegate?.didChangeConfiguration()
        }
    }
    
    private func isConfigurationChanged() -> Bool {
        guard let difficulty = Difficulty(rawValue: difficultySegmentControl.selectedSegmentIndex) else { return false }
        
        return configuration.scoreToWin != Int(gridSizeStepper.value) || configuration.difficulty != difficulty
    }
}

extension SettingsViewController: SPStorkControllerDelegate {
    
    func didDismissStorkBySwipe() {
        saveSettings()
    }
    
    func didDismissStorkByTap() {
        saveSettings()
    }
}
