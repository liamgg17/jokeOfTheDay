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
   
    var flagsArray : NSDictionary? {
        didSet {
            self.collectionViewFlags.reloadData()
        }
    }
    // MARK: - Outlets
    
    @IBOutlet weak var collectionViewFlags: UICollectionView!
    @IBOutlet weak var lblJoke: UILabel!

  
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        collectionViewFlags.dataSource = self
        collectionViewFlags.delegate = self
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateJoke()
        
      
    }
    
    // MARK: - Functions
    
    /**
     That function is responsible for communicating with the ViewModel to request the object
        :params:
        :returns:
        
    */
    
    func updateJoke(){
        
        if model.shouldGetJoke {
            
            self.showLoader()
            model.updateJoke(completion: { (success) in
                
                if let success = success, !success {
                    
                    self.hideLoader()
                    self.alertMessage(message: NetworkManager.error(.internalError).localizedDescription)
                    
                }
            })
            
        } else {
            self.alertMessage(message: NetworkManager.error(.networkError).localizedDescription)
        }
        
    }
    
    func setData() {
        
        self.lblJoke.text = model.joke?.joke
        self.flagsArray = model.joke?.flags.asDictionary as NSDictionary?
      
    }

    // MARK: - Actions
    
    @IBAction func btnRefreshAction(_ sender: Any) {
        
        self.updateJoke()
    
        
    }
    
    

}
extension JokeViewController: JokeViewModelProtocol {
   
    /**
     Function that is called from the JokeViewModelProtocoll to get the JokeViewModel object
        :params:
        :returns:
        
    */
    
    
    func didUpdateJoke() {
        self.hideLoader()
        self.setData()
    }
}
extension JokeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return self.flagsArray?.count ?? 0
   
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "jokeFlagsCollectionViewCell", for: indexPath as IndexPath) as! JokeFlagsCollectionViewCell
       
        if let allKeys = self.flagsArray?.allKeys,let allValues = self.flagsArray?.allValues {
            
            let flag = allKeys[indexPath.row] as! String
            let value = allValues[indexPath.row] as! Bool
        
            cell.setData(key: flag, value: value)
        }
       
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let yourWidth = collectionView.bounds.width/3.0
        return CGSize(width: yourWidth, height: 40)
    }
    
}
