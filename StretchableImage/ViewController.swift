//
//  ViewController.swift
//  StretchableImage
//
//  Created by Denis Evdokimov on 11/20/23.
//

import UIKit

class ViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize.height = view.frame.height * 2
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.insetsLayoutMarginsFromSafeArea = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var imageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "abs")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true

        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(imageContainer)
        scrollView.addSubview(topImageView)
        
        setupConstraint()
        resizeVerticalScrollIndicator()
        
    }

    func setupConstraint(){
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        imageContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageContainer.heightAnchor.constraint(equalToConstant: 270).isActive = true
        
        topImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topImageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor).isActive = true
        let topAncor = topImageView.topAnchor.constraint(equalTo: view.topAnchor)
        topAncor.priority = .defaultHigh
        topAncor.isActive = true
        let heightAncor = topImageView.heightAnchor.constraint(greaterThanOrEqualTo: imageContainer.heightAnchor)
        heightAncor.priority = .required
        heightAncor.isActive = true
    }
    
   private func resizeVerticalScrollIndicator(_ offset: CGFloat = 0.0){
        scrollView.verticalScrollIndicatorInsets.top = topImageView.frame.maxY - offset - view.safeAreaInsets.top
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y
        resizeVerticalScrollIndicator(offset)
    }
}

