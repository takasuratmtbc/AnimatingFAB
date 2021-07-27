//
//  ViewController.swift
//  TableViewWithFAB
//
//  Created by Takasur Azeem on 7/26/21.
//

import UIKit

enum ButtonStates {
    case expanded
    case normal
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fab: FABButtonWithText!
    @IBOutlet weak var fabButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var fabButtonHeightConstraint: NSLayoutConstraint!
    
    let animationDuration = 0.3
    
    var fabState: ButtonStates = .normal {
        didSet {
            switch fabState {
            case .expanded:
                print(fabState)
                expandButton()
            case .normal:
                print(fabState)
                setButtonToNormalState()
            }
        }
    }
    
    func expandButton() {
        print(#function)
        fab.layer.cornerRadius = 10
        fabButtonWidthConstraint.constant = 150
        fabButtonHeightConstraint.constant = 50
        fab.setImage(nil, for: .normal)
        UIView.animate(withDuration: animationDuration) { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
            self.fab.setTitle("Add Check", for: .normal)
        } completion: { completed in
            if completed {
                self.fab.setImage(UIImage(named: "cancel"), for: .normal, fabState: .expanded)
            }
        }
    }
    
    func setButtonToNormalState() {
        print(#function)
        fabButtonWidthConstraint.constant = 50
        fabButtonHeightConstraint.constant = 50
        fab.layer.cornerRadius = 25
        UIView.animate(withDuration: animationDuration) {[weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
            self.fab.setTitle(nil, for: .normal)
        } completion: { completed in
            if completed {
                self.fab.setImage(UIImage(named: "plus"), for: .normal, fabState: .normal)
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fab.layer.cornerRadius = 25
    }
    
    @IBAction func addCheckButtonTapped(_ sender: UIButton) {
        switch fabState {
        case .expanded:
            fabState = .normal
        case .normal:
            fabState = .expanded
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideFAB()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            showFAB()
        } else {
            hideFAB()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        showFAB()
    }
    
    func showFAB() {
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.fab.alpha = 1.0
        }
    }
    
    func hideFAB() {
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.fab.alpha = 0.0
        }
    }
}
