//
//  FirstViewController.swift
//  HotSpot
//
//  Created by t-yokoda on 2019/05/15.
//  Copyright © 2019 t-yokoda. All rights reserved.
//

import UIKit
import Kingfisher
import MapKit

class FirstViewController: BaseViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var fastFlag = true
    
    var photos: [Photo]?
    
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
    }
    
    @objc func timerUpdate() {
        
        let lat = String(describing: currentLocation?.latitude)
        let lon = String(describing: currentLocation?.longitude)
        load(lan: lat, lot: lon)
        
    }
    
    func load(lan:String, lot:String){
        var request = HotSpotApiRequest()
        if page > 20 {
            page = 1
        } else {
            page += 1
        }
        request.parameters = [
            "lan": lan,
            "lot": lot,
            "page": page
        ]
        APIClient.request(api: request, success: { (PhotoList) in
//            debugPrint(PhotoList)
            self.photos = PhotoList
            if self.photos!.count > 0 {
                self.collectionView.reloadData()
            }
        }) {
            print("error")
        }
    }
    
    override func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let myLocation = locations.last! as CLLocation
        currentLocation = myLocation.coordinate
        
        if fastFlag {
            fastFlag = false
            let lat = String(describing: currentLocation?.latitude)
            let lon = String(describing: currentLocation?.longitude)
            load(lan: lat, lot: lon)
            
            Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(FirstViewController.timerUpdate), userInfo: nil, repeats: true)
            
        }
        
    }
    
}

extension FirstViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let photos = photos else { return 0 }
        return photos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        let urlString = photos![indexPath.row].url
        let url = URL(string: urlString)
        cell.imageView.kf.setImage(with: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension FirstViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        var collectionBoundSize = collectionView.bounds.size
        collectionBoundSize.width -= EDGE_INSETS.left
        collectionBoundSize.width -= EDGE_INSETS.right
        collectionBoundSize.height -= EDGE_INSETS.top
        collectionBoundSize.height -= EDGE_INSETS.bottom
        
        let cell_spacing =  CELL_MARGIN * ( NUMBER_OF_HORIZONTAL_CELL_COUNT - 1 )
        let cell_length = (collectionBoundSize.width - CGFloat( cell_spacing ) ) / CGFloat(NUMBER_OF_HORIZONTAL_CELL_COUNT)
        return CGSize( width: cell_length, height: cell_length )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(CELL_MARGIN)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(CELL_MARGIN)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return EDGE_INSETS
    }
    
}
