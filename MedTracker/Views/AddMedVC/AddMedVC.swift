//
//  AddMedVC.swift
//  MedTracker
//
//  Created by eyüp köse on 13.07.2024.
//

import UIKit
import Lottie
import SwiftUI

class 	AddMedVC: UIViewController {
    
    private var animationView: LottieAnimationView!

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var medName: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var lottieView: UIView!
    
    // Variables
    let titleArray = [
        "Tablet",
        "Spoon",
        "Ampoule",
        "Injection",
        "Gel",
        "Drops",
        "Patches"
    ]
    
  
    
    let imageArray = [
        ImageHelper.tablet,
        ImageHelper.spoon,
        ImageHelper.ampoule,
        ImageHelper.injection,
        ImageHelper.gel,
        ImageHelper.drops,
        ImageHelper.patches
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        
        nextBtn.layer.cornerRadius = 12
        
        setupAnimationView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(true)
        collectionView.flashScrollIndicators()
        collectionView.showsHorizontalScrollIndicator = true

        }
    
    
    func setupAnimationView() {
        // Initialize the animation view with the Lottie animation name
        animationView = .init(name: "animation2")
        
        // Set the frame to match the lottieView's bounds
        animationView.frame = lottieView.bounds
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        
        // Add the animation view as a subview of lottieView
        lottieView.addSubview(animationView)
        
        // Ensure the animation view resizes properly when the lottieView changes size
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: lottieView.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: lottieView.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: lottieView.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: lottieView.bottomAnchor)
        ])
        
        // Play the animation
        animationView.play()
    }

    @IBAction func CancelBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        
        // Trimmed medName text to remove leading and trailing spaces
        let trimmedMedName = medName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        // Check if medName is empty or if collectionView has no selected item
        if trimmedMedName.isEmpty || collectionView.indexPathsForSelectedItems?.isEmpty ?? true {
            let alert = UIAlertController(title: "Uyarı", message: "İlaç adı boş olamaz ve bir form seçmelisiniz.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            // 'AddViews' adındaki storyboard'u yüklüyoruz
            let storyboard = UIStoryboard(name: "AddViews", bundle: nil)
            
            // 'AddMed' storyboard identifier'ı ile view controller'ı instantiate ediyoruz
            guard let addMedDayVC = storyboard.instantiateViewController(withIdentifier: "AddMedDays") as? AddMedDaysVC else {
                print("Bu, view controller identifier'ınızı doğru ayarlamadığınız anlamına gelir.")
                return
            }
            
            // Eğer navigation controller yoksa, bir navigation controller oluştur ve addMedVC'yi kök view controller olarak ayarla
            if self.navigationController == nil {
                let navController = UINavigationController(rootViewController: addMedDayVC)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            } else {
                // Mevcut Navigation Controller'ı alıyoruz
                self.navigationController?.pushViewController(addMedDayVC, animated: true)
            }
        }
        
    }
    
}

// MARK: UICollectionView Delegate and DataSources
extension AddMedVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MedSliderCell", for: indexPath) as! MedSliderCell
        
        cell.imgWidth.constant = 64
        cell.imgHeight.constant = 80
        
        cell.collectionViewImg.image = imageArray[indexPath.row]
        cell.collectionViewLbl.text = titleArray[indexPath.row]

        // Hücre seçiliyse vurgulanmış olarak göster
        cell.configure(isSelected: collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 40) / 4 // Her hücre genişliği, CollectionView genişliğinin 1/4'ü olacak şekilde ayarlanmış
        return CGSize(width: width, height: collectionView.frame.height - 30)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Satırlar arasındaki boşluk
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Hücreler arasındaki boşluk
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MedSliderCell {
            cell.configure(isSelected: true)
        } else {
            // Handle the case where cellForItem returns nil
            print("Cell is nil at indexPath: \(indexPath)")
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MedSliderCell {
            cell.configure(isSelected: false)
        } else {
            // Handle the case where cellForItem returns nil
            print("Cell is nil at indexPath: \(indexPath)")
        }
    }
}
