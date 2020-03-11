//
//  EditGalleryViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/10/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class EditGalleryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let imagePicker = UIImagePickerController()
    
    var viewModel: EditGalleryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionViewLayout()
        configureCollectionView()
        configureNavBar()
        configureViews()
    }
    
    private func configureNavBar() {
        navigationItem.title = "Галерея"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editGallery))
        navigationItem.rightBarButtonItem?.tintColor = Color.blue
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(GalleryImageCollectionViewCell.self)
    }
    
    private func configureViews() {
        imagePicker.delegate = self
    }
    
    private func openCamera() {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func openPhotoLibrary() {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func uploadImage(image: UIImage) {
        startLoader()
        viewModel.uploadImage(image: image) { [weak self] (status, message) in
            switch status{
            case .ok:
                self?.stopLoader()
                self?.collectionView.insertItems(at: [IndexPath(row: (self?.viewModel.placeInfo.images.count)! - 1, section: 0)])
            case .fail, .error:
                self?.stopLoader(withStatus: .fail, andText: message, completion: nil)
            }
        }
    }
    
    @objc private func editGallery() {
        viewModel.isEditing = !viewModel.isEditing
        
        if viewModel.isEditing {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelEditing))
            navigationItem.rightBarButtonItem?.tintColor = Color.blue
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Удалить", style: .plain, target: self, action: #selector(removeImages))
            navigationItem.leftBarButtonItem?.tintColor = Color.red
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editGallery))
            navigationItem.rightBarButtonItem?.tintColor = Color.blue
        }
        
        collectionView.reloadData()
    }
    
    @objc private func removeImages() {
        viewModel.removeImages()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editGallery))
        navigationItem.rightBarButtonItem?.tintColor = Color.blue
        
        navigationItem.leftBarButtonItem = nil
        
        collectionView.reloadData()
    }
    
    @objc private func cancelEditing() {
        viewModel.imageIndexesToRemove = []
        viewModel.isEditing = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editGallery))
        navigationItem.rightBarButtonItem?.tintColor = Color.blue
        
        navigationItem.leftBarButtonItem = nil
        
        collectionView.reloadData()
    }

}

extension EditGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 30) / 3
        let height = width / 1.35
        layout.itemSize =  CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        layout.minimumLineSpacing = 5
        
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.isEditing {
            return viewModel.placeInfo.images.count
        } else {
            //with add new image cell
            return viewModel.placeInfo.images.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GalleryImageCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        
        let isAddNewCell = !viewModel.isEditing && indexPath.row == viewModel.placeInfo.images.count
        let selected = viewModel.imageIndexesToRemove.contains(indexPath.row)
        if isAddNewCell {
            cell.configure(isAddNewCell: true, selected: selected)
        } else {
            cell.configure(image: viewModel.placeInfo.images[indexPath.row], selected: selected)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !viewModel.isEditing && indexPath.row == viewModel.placeInfo.images.count {
            addActionSheet(titles: ["Камера","Фотопленка"], actions: [openCamera, openPhotoLibrary], styles: [.default, .default])
        }
        
        if viewModel.isEditing {
            viewModel.selectImage(atIndex: indexPath.row)
            collectionView.reloadData()
        }
    }
}

extension EditGalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            uploadImage(image: pickedImage)
        }
    }
}
