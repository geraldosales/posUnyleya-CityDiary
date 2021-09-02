//
//  ComplainAddEditViewController.swift
//  citydiary
//
//  Created by Geraldo O Sales Jr on 29/08/21.
//

import UIKit

enum OperationType: String {
    case add = "Registrar"
    case edit = "Atualizar"
}

class ComplainAddEditViewController: UIViewController {
    var dataManager: LocalComplainManager = LocalComplainManager.shared
    var complain: Complain?
    var operation: OperationType {
        return complain == nil ? .add : .edit
    }

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var detailTextView: UITextView!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var choosePictureButton: UIButton!
    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!

    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.keyboardDismissMode = .interactive
        dataManager.delegate = self
        clearAll()
        prepareScreen()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillSHow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillSHow), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    @objc
    func keyBoardWillSHow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboradFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }

        let margin = keyboradFrame.size.height + view.safeAreaInsets.bottom
        scrollView.contentInset.bottom = margin
        scrollView.verticalScrollIndicatorInsets.bottom = margin
    }

    @objc
    func keyBoardWillHide() {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Methods

    private func clearAll() {
        titleTextField.text?.clear()
        detailTextView.text.clear()
        locationTextField.text?.clear()
        pictureImageView.image = nil
        choosePictureButton.setTitle("Escolher uma imagem", for: .normal)
        confirmButton.setTitle(operation.rawValue, for: .normal)
        navigationItem.title = operation.rawValue
    }

    private func prepareScreen() {
        guard let complain = complain else { return }
        titleTextField.text = complain.title
        detailTextView.text = complain.detail
        locationTextField.text = complain.location
        if let image = complain.picture {
            pictureImageView.image = UIImage(data: image)
            choosePictureButton.setTitle(nil, for: .normal)
        }
        confirmButton.setTitle(operation.rawValue, for: .normal)
    }
    
    private func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - IBActions

    @IBAction func choosePicture(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar imagem", message: "Local para selecionar a imagem", preferredStyle: .actionSheet)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default) { _ in
                self.selectPicture(sourceType: .camera)
            }
            alert.addAction(cameraAction)
        }

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { _ in
                self.selectPicture(sourceType: .photoLibrary)
            }
            alert.addAction(libraryAction)
        }

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let albumAction = UIAlertAction(title: "Album de fotos", style: .default) { _ in
                self.selectPicture(sourceType: .savedPhotosAlbum)
            }
            alert.addAction(albumAction)
        }

        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
 
    @IBAction func confimOperation(_ sender: UIButton) {
        if operation == .add {
            complain = dataManager.getNewComplain()
        }

        guard let complain = complain else { return }

        complain.title = titleTextField.text
        complain.detail = detailTextView.text
        complain.location = locationTextField.text
        complain.picture = pictureImageView.image?.jpegData(compressionQuality: 1.0)
        complain.registeredAt = Date()

        dataManager.save()
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

extension ComplainAddEditViewController: LocalComplainManagerDelegate {
    func saveResult(succeful: Bool, error: String?) {
        if succeful {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension ComplainAddEditViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            pictureImageView.image = image
            choosePictureButton.setTitle(nil, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
}

extension ComplainAddEditViewController: UINavigationControllerDelegate {
}
