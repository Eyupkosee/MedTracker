//
//  SliderScreneVC.swift
//  MedTracker
//
//  Created by eyüp köse on 13.07.2024.
//

import UIKit

class SliderScreneVC: UIViewController {

   // IBOutlets
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // Variables
    let titleArray = [
        "number 1 title",
        "number 2 title",
        "number 3 title"
    ]
    
    let textArray = [
        "number 1 text ajshjudhajsuhduahsjudasd asjduıasjhıda",
        "number 2 text akdsokasdlk asdolk asodkoask odaksod",
        "number 3 text sakdjıasjdıj ıasjdıajııdasjı as"
    ]
    
    let imageArray = [
        ImageHelper.img1,
        ImageHelper.img2,
        ImageHelper.img3
    ]
    
  
    
    
}

// MARK: -  View Life Cycle
extension SliderScreneVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        nextButton.isHidden = true
        nextButton.layer.cornerRadius = 12
        
    }
}


// MARK: - IBActions
extension SliderScreneVC{
    
    @IBAction func skipBtnClicked(_ sender: Any) {
        showItem(at: 2)
        skipShow(true)
    }
    
     @IBAction func nextBtnClicked(_ sender: Any) {
             let nextVC = MyCustomTabBarController()
             nextVC.modalPresentationStyle = .fullScreen // Tam ekran modunda göster
             present(nextVC, animated: true, completion: nil)

     }
    
    @IBAction func pageValueChanged(_ sender: Any) {
        showItem(at: pageControl.currentPage)
    }
    
}


// MARK: - PRİVATE FUNCTİONS
extension SliderScreneVC {
    private func skipShow(_ bool: Bool) {
        skipButton.isHidden = !bool
        nextButton.isHidden = !bool // skipButton'a basıldığında nextButton'ı göster
    }
    
    private func showItem(at index: Int) {
        let isLastPage = index == titleArray.count - 1
        skipShow(!isLastPage)
        nextButton.isHidden = !isLastPage // Sadece son sayfada nextButton'ı göster
        pageControl.currentPage = index
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally, .centeredVertically], animated: true)
    }
}

// MARK: UICollectionView Delegate and DataSources
// MARK: UICollectionView Delegate and DataSources
extension SliderScreneVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! SliderCell
        
        cell.imgWidth.constant = 260
        cell.imgHeight.constant = 260
        
        cell.imgView.image = imageArray[indexPath.row]
        cell.headingLbl.text = titleArray[indexPath.row]
        cell.txtLbl.text = textArray[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = scrollView.frame.size.width
        let currentPage = Int(scrollView.contentOffset.x / pageWidth)
        
        var newPage = currentPage
        
        if velocity.x > 0 {
            newPage += 1
        } else if velocity.x < 0 {
            newPage -= 1
        }
        
        newPage = max(0, min(newPage, titleArray.count - 1)) // newPage'in geçerli bir aralıkta olup olmadığını kontrol edin
        
        let offset = CGPoint(x: CGFloat(newPage) * pageWidth, y: 0)
        targetContentOffset.pointee = offset
        pageControl.page = newPage
        
        skipShow(newPage != titleArray.count - 1)
        nextButton.isHidden = newPage != titleArray.count - 1
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor(scrollView.contentOffset.x / pageWidth))
        pageControl.page = page
        
        skipShow(page != titleArray.count - 1)
        nextButton.isHidden = page != titleArray.count - 1
    }
}


extension UIPageControl {
    var page: Int {
        get{
            return currentPage
        }
        set{
            currentPage = newValue
        }
    }
}
