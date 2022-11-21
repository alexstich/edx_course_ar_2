//
//  ViewController.swift
//  SystemViewControllersStarter
//
//  Created by David McMeekin on 26/8/19.
//  Copyright © 2019 David McMeekin. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController, UINavigationControllerDelegate
{
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        imageView.contentMode = .scaleAspectFit
    }

    @IBAction func shareButtonTapped(_ sender: UIButton)
    {
        guard let image = imageView.image else { return }
        
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        activityController.popoverPresentationController?.sourceView = sender
        
        self.present(activityController, animated: true)
    }
    
    @IBAction func safariButtonTapped(_ sender: UIButton)
    {
        if let url = URL(string: "https://curtin.edu.au") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true)
        }
    }
    @IBAction func cameraButtonTapped(_ sender: UIButton)
    {
        let alertController = UIAlertController(title: "Choose image resource", message: nil, preferredStyle: .actionSheet)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let libraryAction = UIAlertAction(title: "Library", style: .default, handler: { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            })
            alertController.addAction(libraryAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = sender
        present(alertController, animated: true)
    }
    @IBAction func emailButtonTapped(_ sender: UIButton)
    {
        guard MFMailComposeViewController.canSendMail() else { return }
        
        let mailComposer = MFMailComposeViewController()
        
        mailComposer.mailComposeDelegate = self
        
        mailComposer.setToRecipients(["Taylor@swift.com"])
        mailComposer.setSubject("Testing for you Taylor Swft")
        mailComposer.setMessageBody("Hello, Taylor", isHTML: false)
        
        self.present(mailComposer, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        
        guard let selectedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage else { return }

        imageView.image = selectedImage
        picker.dismiss(animated: true)
    }
}

extension ViewController: MFMailComposeViewControllerDelegate
{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        controller.dismiss(animated: true)
    }
}

