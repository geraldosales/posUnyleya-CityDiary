//
//  ComplainDetailViewController.swift
//  citydiary
//
//  Created by Geraldo O Sales Jr on 29/08/21.
//

import UIKit

class ComplainDetailViewController: UIViewController {
    
    var complain: Complain!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var pictureImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepape()
    }
    
    
    func prepape(){
        titleTextField.text = complain.title
        detailTextView.text = complain.detail
        locationTextField.text = complain.location
        if let image = complain.picture {
            pictureImageView.image = UIImage(data: image)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
