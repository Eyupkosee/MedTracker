//
//  DaysCell.swift
//  MedTracker
//
//  Created by eyüp köse on 16.07.2024.
//

import UIKit

protocol DaysCellDelegate: AnyObject {
    func didSelectDays(_ days: [String])
}

class DaysCell: UIViewController {
    
    @IBOutlet weak var monRadioBtn: UIImageView!
    @IBOutlet weak var tueRadioBtn: UIImageView!
    @IBOutlet weak var wedRadioBtn: UIImageView!
    @IBOutlet weak var thuRadioBtn: UIImageView!
    @IBOutlet weak var friRadioBtn: UIImageView!
    @IBOutlet weak var satRadioBtn: UIImageView!
    @IBOutlet weak var sunRadioBtn: UIImageView!
    
    
    weak var delegate: DaysCellDelegate?
    
    var selectedDays: [String] = []
    
    // onDismiss closure'ı ekliyoruz
    var onDismiss: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Radio button imageViews'larına başlangıçta "ic_radio_button_unselected" görüntüsünü atıyoruz
        monRadioBtn.image = UIImage(named: "ic_radio_button_unselected")
        tueRadioBtn.image = UIImage(named: "ic_radio_button_unselected")
        wedRadioBtn.image = UIImage(named: "ic_radio_button_unselected")
        thuRadioBtn.image = UIImage(named: "ic_radio_button_unselected")
        friRadioBtn.image = UIImage(named: "ic_radio_button_unselected")
        satRadioBtn.image = UIImage(named: "ic_radio_button_unselected")
        sunRadioBtn.image = UIImage(named: "ic_radio_button_unselected")
        
        // Radio buttonlara tap gesture ekleyin
        addTapGesture(to: monRadioBtn, day: "Mon")
        addTapGesture(to: tueRadioBtn, day: "Tue")
        addTapGesture(to: wedRadioBtn, day: "Wed")
        addTapGesture(to: thuRadioBtn, day: "Thu")
        addTapGesture(to: friRadioBtn, day: "Fri")
        addTapGesture(to: satRadioBtn, day: "Sat")
        addTapGesture(to: sunRadioBtn, day: "Sun")
        
        // Kapatma işlemi olduğunda tetiklenecek
        self.isModalInPresentation = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Dismiss edilirken onDismiss closure'ını çağırıyoruz
        delegate?.didSelectDays(selectedDays.sorted())
        onDismiss?()
    }
    
    func addTapGesture(to imageView: UIImageView, day: String) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(radioBtnTapped(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        imageView.accessibilityIdentifier = day
    }
    
    @objc func radioBtnTapped(_ sender: UITapGestureRecognizer) {
        guard let day = sender.view?.accessibilityIdentifier else { return }
        
        if let index = selectedDays.firstIndex(of: day) {
            selectedDays.remove(at: index)
        } else {
            selectedDays.append(day)
        }
        
        updateRadioBtnImages()
    }
    
    func updateRadioBtnImages() {
        monRadioBtn.image = UIImage(named: selectedDays.contains("Mon") ? "ic_radio_button_selected" : "ic_radio_button_unselected")
        tueRadioBtn.image = UIImage(named: selectedDays.contains("Tue") ? "ic_radio_button_selected" : "ic_radio_button_unselected")
        wedRadioBtn.image = UIImage(named: selectedDays.contains("Wed") ? "ic_radio_button_selected" : "ic_radio_button_unselected")
        thuRadioBtn.image = UIImage(named: selectedDays.contains("Thu") ? "ic_radio_button_selected" : "ic_radio_button_unselected")
        friRadioBtn.image = UIImage(named: selectedDays.contains("Fri") ? "ic_radio_button_selected" : "ic_radio_button_unselected")
        satRadioBtn.image = UIImage(named: selectedDays.contains("Sat") ? "ic_radio_button_selected" : "ic_radio_button_unselected")
        sunRadioBtn.image = UIImage(named: selectedDays.contains("Sun") ? "ic_radio_button_selected" : "ic_radio_button_unselected")
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        delegate?.didSelectDays(selectedDays.sorted())
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtnClicked(_ sender: Any) {
        delegate?.didSelectDays(selectedDays.sorted())
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
