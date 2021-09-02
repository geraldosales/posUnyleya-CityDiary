//
//  ComplainCellTableViewCell.swift
//  citydiary
//
//  Created by Geraldo O Sales Jr on 29/08/21.
//

import UIKit

class ComplainCellTableViewCell: UITableViewCell {
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var registeredAtLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func clearAll() {
        pictureImageView.image = nil
        titleLabel.text?.clear()
        registeredAtLabel.text?.clear()
    }

    func prepare(with complain: Complain) {
        clearAll()
        if let image = complain.picture {
            pictureImageView.image = UIImage(data: image)
        }
        titleLabel.text = complain.title
        if let date = complain.registeredAt {
            registeredAtLabel.text = "Registrado em: \(date)"
        }
    }
}
