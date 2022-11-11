//
//  JokeViewController.swift
//  JokeApp
//
//  Created by Christian Martinez on 10/11/22.
//

import UIKit

class JokeViewController: UIViewController {
    
    // MARK: - Properties
    
    fileprivate let model = JokeViewModel()
    
    // MARK: - Outlets
    
    @IBOutlet weak var lblJoke: UILabel!

  
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.updateJoke()
      
    }
    
    // MARK: - Functions
    
    func setData() {
        
        
        self.lblJoke.text = model.joke?.joke
   
    }

    // MARK: - Actions
    
    @IBAction func btnRefreshAction(_ sender: Any) {
        
        model.updateJoke()
        
    }
    
    

}
extension JokeViewController: JokeViewModelProtocol {
   
    func didUpdateJoke() {
        self.setData()
    }
}
