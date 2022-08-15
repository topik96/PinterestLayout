//
//  ViewController.swift
//  LearningApp
//
//  Created by Topik M on 15/08/22.
//

import UIKit
import Fakery

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var _filterPhotos = [Photo]()
    private var _photos = [Photo]() {
        didSet {
            _filterPhotos = _photos
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupSearchBar()
        _setupCollectionView()
        _retrievePhotos() // or _retrieveSearchPhotos()
    }
    
    private func _setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.keyboardAppearance = .dark
    }
    
    private func _setupCollectionView() {
        let pinterestLayout = PinterestLayout()
        pinterestLayout.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = pinterestLayout
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil),
                                forCellWithReuseIdentifier: "ProductCell")
        
        collectionView.toggleActivityIndicator()
    }
    
    private func _retrievePhotos() {
        NetworkManager.shared.retrievePhotos(use: .picsum) { [weak self] (response) in
            guard let self = self else { return }
            var photos = [Photo]()
            let faker = Faker(locale: "nb-NO")
            for i in 0..<(response?.count ?? 0){
                let randomInt = Int(arc4random_uniform(13) + 2)
                let desc = faker.lorem.words(amount: randomInt)
                if let photo = response?[i] {
                    photos.append(Photo(id: photo.id,
                                        width: photo.width,
                                        height: photo.height,
                                        url: photo.url,
                                        downloadUrl: photo.downloadUrl,
                                        desc: desc))
                }
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self._photos = photos
                self.collectionView.toggleActivityIndicator()
                self.collectionView.reloadData()
            }
        }
    }
    
    private func _retrieveSearchPhotos() {
        NetworkManager.shared.retrieveSearchPhotos(url: .unsplash, query: "office") { [weak self] (response) in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.collectionView.toggleActivityIndicator()
                
                if let response = response {
                    self._photos = response.map { data in
                        return Photo(id: data.id,
                                     width: data.width,
                                     height: data.height,
                                     url: data.urls?.regular,
                                     downloadUrl: data.urls?.full,
                                     desc: data.desc)
                        
                    }
                } else {
                    self.collectionView.setMessage("Tidak ada data", icon: "emptyBox")
                }
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: - Extensions -

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        _filterPhotos = searchText.isEmpty ? _photos : _photos.filter {
            return (($0.desc?.lowercased().contains(searchText.lowercased())) != nil)
        }
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _filterPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.item = _filterPhotos[indexPath.item]
        return cell
    }
}

extension ViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        let photo = _filterPhotos[indexPath.item]
        let imageHeight = MetricUtils.imageHeight(source: photo, scaledToWidth: cellWidth)
        let labelHeight = MetricUtils.labelHeight(source: photo.desc, cellWidth: cellWidth)
        return (imageHeight + labelHeight + 10)
    }
}
