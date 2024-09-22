//
//  HoursCell.swift
//  MedTracker
//
//  Created by eyüp köse on 20.07.2024.
//

import UIKit

class HoursCell: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    let count = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    
    var onDone: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return count.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return count[row]
    }
    
    
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func doneBtnClicked(_ sender: Any) {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let selectedValue = Int(count[selectedRow]) ?? 1
        onDone?(selectedValue)
        dismiss(animated: true, completion: nil)
    }
    
    
}
