//
//  lunch.swift
//  BottleRocket
//
//  Created by Bryan Lee on 10/20/21.
//

import UIKit

class LunchViewController : UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    private var viewModel: LunchViewModel!
    private var sizeClass: UIUserInterfaceSizeClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = LunchViewModel()
        configureNavBar()
        configureViewModel()
        configureCollectionView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        sizeClass = self.traitCollection.horizontalSizeClass
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.frame = view.bounds
    }
    
    private func configureNavBar() {
        navigationItem.title = LunchConstants.title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: LunchConstants.fontName, size: 17)!]
        navigationController?.navigationBar.barTintColor = UIColor(red: 67/255, green: 232/255, blue: 149/255, alpha: 1)
        
        let mapButton = UIBarButtonItem(
            image: UIImage(named: AssetsName.mapIcon),
            style: .plain,
            target: self,
            action: nil)
        mapButton.tintColor = UIColor.white
        
        navigationItem.rightBarButtonItem = mapButton
    }
    
    private func reloadData() {
        collectionView.reloadData()
    }
    
    private func configureViewModel() {
        let setCompletion = { [weak self] in
            guard let wself = self else { return }
            wself.reloadData()
        }
        viewModel.bind(completion: setCompletion)
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.register(LunchCollectionViewCell.nib, forCellWithReuseIdentifier: LunchCollectionViewCell.identifier)
    }
}

extension LunchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRestaurants()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LunchCollectionViewCell.identifier, for: indexPath) as? LunchCollectionViewCell

        cell?.configure(lunchCellVM: viewModel.createLunchDetailVM(row: indexPath.row))
        return cell ?? UICollectionViewCell()
    }
}

extension LunchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailsSB = UIStoryboard(name: LunchDetailsViewController.storyboardID, bundle: nil)
        guard let detailsVC = detailsSB.instantiateViewController(identifier: LunchDetailsViewController.identifier) as? LunchDetailsViewController else { return }
        
        detailsVC.viewModel = viewModel.createLunchDetailVM(row: indexPath.row)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension LunchViewController : UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let imageStr = viewModel.imageStr(index: indexPath.row)
            viewModel.prefetchImage(imageStr: imageStr)
        }
    }
}

extension LunchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch sizeClass {
        case .regular:
            return CGSize(width: (collectionView.frame.width / 2), height: 180 * 2)
        default:
            return CGSize(width: collectionView.frame.width, height: 180)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 0.0
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
}
