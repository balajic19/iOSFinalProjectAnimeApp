//
//  AnimeDetailsVC.swift
//  AnimeApp
//
//  Created by
// Balaji Chandupatla
// Shiva Rama Krishna nutakki
// Alekhya Gollamudi
// Kavya Chapparapu
// Satya Venkata Rohit
//
//

import UIKit
import YoutubePlayer_in_WKWebView


class AnimeNameCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var faviourate: UIButton!
}

class AnimeDetailsCell: UITableViewCell {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    
}

class AnimeSynopsisCell: UITableViewCell {
    @IBOutlet weak var synopsisDescription: UILabel!
}

class AnimeWebUrlCell: UITableViewCell {
    @IBOutlet weak var btnWebUrl: UIButton!
}


class AnimeDetailsVC: UIViewController {

    var anime: Datum?
    
    @IBOutlet weak var animeDetailsTable: UITableView!
    @IBOutlet weak var payer: WKYTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let youtubId = anime?.trailer?.youtubeID {
            payer.load(withVideoId: youtubId)
            payer.delegate = self
        }
    }
    
    func registerCellsAndHeaders() {
        self.animeDetailsTable.register(UINib(nibName: "AnimeNameCell", bundle: .main), forCellReuseIdentifier: "AnimeNameCell")
        self.animeDetailsTable.register(UINib(nibName: "AnimeDetailsCell", bundle: .main), forCellReuseIdentifier: "AnimeDetailsCell")
        self.animeDetailsTable.register(UINib(nibName: "AnimeSynopsisCell", bundle: .main), forCellReuseIdentifier: "AnimeSynopsisCell")
        self.animeDetailsTable.register(UINib(nibName: "AnimeWebUrlCell", bundle: .main), forCellReuseIdentifier: "AnimeWebUrlCell")
    }

    @objc func selectTheFaviourayeButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        self.animeDetailsTable.reloadData()
        if let name = UserDefaults.standard.value(forKey: "userName") as? String,
           let title = anime?.title {
            DatabaseHelper.shareInstance.createFaviouties(name: name, animeName: title)
        }
        
        let alert = UIAlertController(title: "Alert", message: sender.isSelected ? "Add favorite successfully" :"Removed favorite successfully", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    @objc func openTheWebPage() {
        if let animeUrl = anime?.url, let url = URL(string: animeUrl) {
            UIApplication.shared.open(url)
        }
    }
}
extension AnimeDetailsVC: WKYTPlayerViewDelegate {
    
    func playerView(_ playerView: WKYTPlayerView, didChangeTo state: WKYTPlayerState) {
        playerView.playVideo()
    }
 
}

extension AnimeDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeNameCell", for: indexPath) as? AnimeNameCell {
                cell.nameLabel.text = anime?.title
                cell.faviourate.tag = indexPath.row
                cell.faviourate.setImage(UIImage.init(systemName: "arrow.clockwise.heart"), for: .normal)
                cell.faviourate.setImage(UIImage.init(systemName: "arrow.clockwise.heart.fill"), for: .selected)
                cell.faviourate.addTarget(self, action: #selector(selectTheFaviourayeButton(_:)), for: .touchUpInside)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeDetailsCell", for: indexPath) as? AnimeDetailsCell {
                if let duration = anime?.duration {
                    cell.durationLbl.text = "duration: \(duration)"
                }
                if let score = anime?.score, let rank = anime?.rank {
                    cell.scoreLabel.text = "Score: \(score), rank:\(rank)"
                }
                if let Rating = anime?.rating {
                    cell.ratingLabel.text = Rating
                }
    
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeWebUrlCell", for: indexPath) as? AnimeWebUrlCell {
                if let url = anime?.url {
                    cell.btnWebUrl.setTitle(url, for: .normal)
                    cell.btnWebUrl.titleLabel?.textColor = .blue
                }
                cell.btnWebUrl.tag = indexPath.row
                cell.btnWebUrl.addTarget(self, action: #selector(openTheWebPage), for:  .touchUpInside)
                return cell
            }
            
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeSynopsisCell", for: indexPath) as? AnimeSynopsisCell {
                cell.synopsisDescription.text = anime?.synopsis
                return cell
            }
        
        default:
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 : return 50
        case 1: return 70
        case 2: return 50
        case 3: return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    
}


