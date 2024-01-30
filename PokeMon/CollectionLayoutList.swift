//
//  CollectionLayoutList.swift
//  PokeMon
//
//  Created by Oğuz Kanda on 16.01.2024.
//

import UIKit

struct CollectionLayoutList {
    
    func collectionLayoutListMethod(){
        
    var appearance: UICollectionLayoutListConfiguration.Appearance
    let configuration = UICollectionLayoutListConfiguration(appearance: .sidebar)
    let layout = UICollectionViewCompositionalLayout() { sectionIndex, layoutEnvironment in
        
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.headerMode = sectionIndex == 0 ? .supplementary : .none
        
        let section = NSCollectionLayoutSection.list(using: configuration,
                           
                                                    layoutEnvironment: layoutEnvironment)
        
        return section
        
    }
                
    }
    
    
}

