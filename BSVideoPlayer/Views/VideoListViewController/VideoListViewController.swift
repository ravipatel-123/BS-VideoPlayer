//
//  VideoListViewController.swift
//  VideoPlayerPod
//
//  Created by bs-mac-4 on 07/12/22.
//

import UIKit
import AVFoundation
import Kingfisher


protocol VideoListViewControllerDelegate {
    func selectedIndex(_ index: Int)
}


class VideoListViewController: UIViewController {

    //MARK: - VARIABLES
    var urlStrings = [String?]()
    var delegate: VideoListViewControllerDelegate!
    
    //MARK: - OUTLETS
    @IBOutlet weak var videoCollectionView: UICollectionView!
    
    //MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupCollectionView()
        videoCollectionView.reloadData()
    }
    
    
    //MARK: - BTNS ACTIONS

}


//MARK: - COLLECTION VIEW METHODS
extension VideoListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func setupCollectionView() {
        videoCollectionView.registerNib(VideoListCell.self)
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        urlStrings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: videoCollectionView.frame.width-30, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoListCell", for: indexPath) as? VideoListCell else { return .init() }
        self.setVideoThumbnail(url: urlStrings[indexPath.row], cell: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.selectedIndex(indexPath.row)
    }
    
}

extension VideoListViewController {
    
    private func setVideoThumbnail(url: String?, cell: VideoListCell) {
        cell.thumbIma.image = nil
        guard let url = URL(string: url ?? "") else {
            return
        }
        cell.thumbIma.kf.setImage(with: AVAssetImageDataProvider(assetURL: url, seconds: 1))
    }
    
}
