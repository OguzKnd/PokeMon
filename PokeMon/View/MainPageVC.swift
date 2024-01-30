//
//  ViewController.swift
//  PokeMon
//
//  Created by Oğuz Kanda on 13.01.2024.
//

import UIKit
import Kingfisher


protocol PokemonOutPut {
    
    func changeLoading (isload:Bool)
    func saveDatas(values: [PokemonModel])
}

final class MainPageVC: UIViewController {
    
    
    private lazy var pokemonModel: [PokemonModel] = []
    lazy var viewModel:IPokemonViewModel = PokemonViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    private let appearence = UINavigationBarAppearance()
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
    }
    
    
    private func configure() {
        navigationItemDisplay()
        design()
        configureSearchController()
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(indicator)
        
    }
    
}

extension MainPageVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pokemonModel.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pokemonItem = pokemonModel[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PokemonCollectionViewCell
        if let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(pokemonItem.id ?? 1).png") {
            DispatchQueue.main.async {
                cell.imageView.kf.setImage(with: url)
            }
        }
        
        let types = pokemonItem.types?.compactMap { $0.type?.name }.joined(separator: ", ")
        
        cellDesign()
        
        func cellDesign(){
            
            collectionView.backgroundColor = UIColor(named: "purpleP")
            cell.typeLabel.text = "Types: \(types ?? "No types")"
            cell.nameLabel.text = " \(pokemonItem.name ?? "")  "
            cell.backgroundColor = UIColor(named: "purpleP")
            cell.layer.borderColor = UIColor(named: "lightPrimary")?.cgColor
            cell.layer.borderWidth = 2.5
            cell.layer.cornerRadius = 9.0
            cell.nameLabel.textColor = UIColor(named: "purpleP")
            cell.nameLabel.layer.borderColor = UIColor(named: "purpleP")?.cgColor
            cell.nameLabel.layer.cornerRadius = 9.0
            cell.nameLabel.font = .boldSystemFont(ofSize: 18)
            cell.nameLabel.tintColor = UIColor(named: "purpleP")
            cell.nameLabel.backgroundColor = UIColor(named: "lightPrimary")
            cell.typeLabel.textColor = UIColor(named: "lightPrimary")
            cell.typeLabel.font = .boldSystemFont(ofSize: 15)
            indicator.color = UIColor(named: "lightPrimary")
            
            
        }
        
        return cell
    }
    
    private func design() {
        
        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.minimumLineSpacing = 10
        design.minimumInteritemSpacing = 10
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth-30)/2
        design.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.6)
        collectionView.collectionViewLayout = design
        view.backgroundColor = UIColor(named: "purpleP")
        
    }
    
    private func navigationItemDisplay(){
        
        DispatchQueue.main.async {
            
            self.appearence.backgroundColor = UIColor(named: "purpleP")
            self.appearence.titleTextAttributes = [.foregroundColor:UIColor(named: "lightPrimary")!]
            self.navigationController?.navigationBar.barStyle = .black
            
            self.navigationController?.navigationBar.standardAppearance = self.appearence
            self.navigationController?.navigationBar.compactAppearance = self.appearence
            self.navigationController?.navigationBar.scrollEdgeAppearance = self.appearence
        }
        
    }
    
    
    private func configureSearchController() {
        
        DispatchQueue.main.async {
            self.searchController.searchResultsUpdater = self
            self.searchController.obscuresBackgroundDuringPresentation = false
            self.searchController.searchBar.placeholder = "Search Pokémon"
            self.navigationItem.searchController = self.searchController
            self.definesPresentationContext = true
            self.searchController.searchBar.backgroundColor = UIColor(named: "lightPrimary")
            self.searchController.searchBar.showsCancelButton = false
        }
    }
}

extension MainPageVC:UISearchResultsUpdating,UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            let filteredData = pokemonModel.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
            pokemonModel = filteredData
            collectionView.reloadData()
        } else {
            viewModel.fetchItems()
            collectionView.reloadData()
        }
    }
}

extension MainPageVC: PokemonOutPut {
    func changeLoading(isload: Bool) {
        isload ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveDatas(values: [PokemonModel]) {
        pokemonModel = values
        collectionView.reloadData()
    }
    
}



 
