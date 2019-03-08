//
//  ViewController.swift
//
//  Created by Home on 2019.
//  Copyright 2017-2018 NoStoryboardsAtAll Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
//  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit

class ViewController: UIViewController {
    // array of colors
    let colors: [UIColor] = [.red, .yellow, .green, .blue, .purple, .orange, .magenta, .cyan, .gray]
    
    // declaration of the stack view
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 13.0
        
        return stack
    }()
    
    // declaration of the toggle visibitity button
    lazy var toggleButton: UIButton = {
        let button = UIButton(type: .system)
        
        // use auto layout
        button.translatesAutoresizingMaskIntoConstraints = false
        // at the start all views are visible so set button's title to "Hide"
        button.setTitle("Hide", for: .normal)
        // add handler to touchUpInside event
        button.addTarget(self, action: #selector(action), for: .touchUpInside)
        
        return button
    }()
    
    // variables that holds current visibitity status. add a listener to that property
    // in wich we will toggle button's title
    var isViewHidden: Bool = false {
        didSet {
            let buttonTitle = isViewHidden ? "Show" : "Hide"
            toggleButton.setTitle(buttonTitle, for: .normal)
        }
    }
    
    // index of current hidden view in arranged subviews
    var hiddenViewIndex: Int = -1
    
    // Do any additional setup here
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // Setup your view and constraints here
    override func loadView() {
        super.loadView()
        prepareView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func prepareView() {
        // add button and stack view to the superview
        view.addSubview(toggleButton)
        view.addSubview(stackView)
        
        // activate the constraints
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            toggleButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            toggleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13.0)
        ])
    
        // add arranged views to the stack view
        colors.forEach { (color) in
            let arrangedView = MyView(color: color, side: 21.0)
            stackView.addArrangedSubview(arrangedView)
        }
}
    
    // button tap handler
    @objc func action() {
        // 1. if all views are visible, calculate new view index to hide randomly and store it in hiddenViewIndex
        if !isViewHidden {
            hiddenViewIndex = Int.random(in: 0...colors.count - 1)
        }
        
        // 2. else we already know index of the view to show
        
        // 3. get view by index from stackView.arrangedSubviews
        let viewToHide = stackView.arrangedSubviews[hiddenViewIndex]
        
        // 4. animate toggle visibility
        UIView.animate(withDuration: 0.13) {
            viewToHide.isHidden = !self.isViewHidden
        }

        // 5. toggle button's title
        isViewHidden = !isViewHidden
    }
}

