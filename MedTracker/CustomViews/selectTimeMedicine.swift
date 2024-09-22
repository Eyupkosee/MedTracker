//
//  selectTimeMedicine.swift
//  MedTracker
//
//  Created by eyüp köse on 24.08.2024.
//

import UIKit

protocol selectTimeMedicineDelegate: AnyObject {
    func didSelectTime(_ time: Date, for indexPath: IndexPath)
}


class selectTimeMedicine: UIViewController {
    
    @IBOutlet weak var pickerView: UIDatePicker!
    
    weak var delegate: selectTimeMedicineDelegate?
    var indexPath: IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sadece saat seçimi yapılmasını sağlayın
        pickerView.datePickerMode = .time
        
        // İsteğe bağlı olarak `preferredDatePickerStyle` özelliğini de ayarlayabilirsiniz
        pickerView.preferredDatePickerStyle = .wheels
        
    }
    
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtnClicked(_ sender: Any) {
        if let indexPath = indexPath {
            delegate?.didSelectTime(pickerView.date, for: indexPath)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
