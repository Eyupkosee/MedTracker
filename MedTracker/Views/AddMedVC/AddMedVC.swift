//
//  AddMedVC.swift
//  MedTracker
//
//  Created by eyüp köse on 13.07.2024.
//

import UIKit

class AddMedVC: UIViewController {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var medName: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    
    // Variables
    let titleArray = [
        "1 title",
        "2 title",
        "3 title",
        "4 title",
        "5 title",
        "6 title",
        "7 title",
        "8 title",
        "9 title",
        "10 title"
    ]
    
    
    let imageArray = [
        ImageHelper.img1,
        ImageHelper.img2,
        ImageHelper.img3,
        ImageHelper.img4,
        ImageHelper.img5,
        ImageHelper.img6,
        ImageHelper.img7,
        ImageHelper.img8,
        ImageHelper.img9,
        ImageHelper.img10
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        nextBtn.layer.cornerRadius = 12
        
        
        
    }
    

    @IBAction func CancelBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
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
        return CGSize(width: width, height: collectionView.frame.height)
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
