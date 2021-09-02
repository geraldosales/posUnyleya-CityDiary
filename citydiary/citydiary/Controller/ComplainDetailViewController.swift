//
//  ComplainDetailViewController.swift
//  citydiary
//
//  Created by Geraldo O Sales Jr on 29/08/21.
//

import UIKit

class ComplainDetailViewController: UIViewController {
    var complain: Complain!

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var detailTextView: UITextView!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var pictureImageView: UIImageView!
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        prepape()
    }
    
    // MARK: - Methods

    func prepape() {
        titleTextField.text = complain.title
        detailTextView.text = complain.detail
        locationTextField.text = complain.location
        if let image = complain.picture {
            pictureImageView.image = UIImage(data: image)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ComplainEditSegue" {
            let vc = segue.destination as! ComplainAddEditViewController
            vc.complain = complain
        }
    }
}
