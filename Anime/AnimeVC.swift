//
//  ViewController.swift
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

class AnimeVC: UIViewController {
    
    @IBOutlet weak var animeCollectionView: UICollectionView!
    var listOfAnime = [Datum]()
    var isFaviourteView:Bool = false
    var faviourateArray: [Faviourties]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animeCollectionView.register(UINib(nibName: "AnimeCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "AnimeCollectionViewCell")


        if isFaviourteView {
            let backButton = UIBarButtonItem(image: UIImage.init(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
            self.navigationItem.leftBarButtonItem  = backButton
        }
        
        let backButton = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(profileButtonTapped))
        self.navigationItem.rightBarButtonItem  = backButton
        
        fetchAnimeListFromApiService { [weak self] (animes) in
            if let animesList = animes?.data {
                
                self?.filterFaviourAnime(animesList: animesList)
                DispatchQueue.main.async {
                    self?.animeCollectionView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func profileButtonTapped() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func filterFaviourAnime(animesList : [Datum]) {
        if isFaviourteView {
            faviourateArray = DatabaseHelper.shareInstance.getListOfFaviourties(username: UserDefaults.standard.value(forKey: "userName") as! String)
            if faviourateArray != nil {
                for faviourate in faviourateArray! {
                    for anime in animesList {
                        if (anime.title == faviourate.faviourtieId) {
                            listOfAnime.append(anime)
                        }
                    }
                }
            }
        } else {
            self.listOfAnime = animesList
        }
    }
    
    func fetchAnimeListFromApiService(completionHandler: @escaping (Animes?) -> Void) {
        let url = URL(string: "https://api.jikan.moe/v4/anime")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching dogs: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data,
               let dogsList = try? JSONDecoder().decode(Animes.self, from: data) {
                completionHandler(dogsList)
            }
        })
        task.resume()
    }
}

extension AnimeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfAnime.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimeCollectionViewCell", for: indexPath) as! AnimeCollectionViewCell
        
        if let imageUrl = listOfAnime[indexPath.row].images?["jpg"]?.imageURL {
            if let url = URL(string: imageUrl) {
                let data = try? Data(contentsOf: url)
                
                if let imageData = data {
                    cell.animeImage.image = UIImage(data: imageData)
                }
            }
        }
        if let title = listOfAnime[indexPath.row].title {
            cell.animeTitle.text = title
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 10, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AnimeDetailsVC") as? AnimeDetailsVC
        vc?.anime = listOfAnime[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

