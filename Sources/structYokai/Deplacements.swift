//
//  Deplacements.swift
//  
//
//  Created by Jeremie DUMONT on 19/12/2018.
//
//

import Foundation


public struct Deplacements : DeplacementsProtocol {
    
    var tab = [Bool](repeating: false, count: 8)
    
    
    //init : -> Deplacements
    //Post : Renvoie Deplacements à Vide
    public init(){
        
    }
    
    //InitialiserKoropokkuru : Deplacements -> Deplacements
    //Pre : Deplacements Vide
    //Post : Deplacements correspondent au Koropokkuru
    @discardableResult
    public mutating func InitialiserKoropokkuru() throws -> Deplacements {
        for i in 0..<8 {
            tab[i] = true
        }
        return self
    }
    
    
    //InitialiserKitsune : Deplacements -> Deplacements
    //Pre : Deplacements Vide
    //Post : Deplacements correspondent au Kitsuneoropokkuru
    @discardableResult
    public mutating func InitialiserKitsune() throws -> Deplacements {
        tab = [Bool](repeating: false, count: 8)
        tab[0] = true
        tab[2] = true
        tab[5] = true
        tab[7] = true
        return self
    }
    
    //InitialiserTanuki : Deplacements -> Deplacements
    //Pre : Deplacements Vide
    //Post : Deplacements correspondent au Tanuki
    @discardableResult
    public mutating func InitialiserTanuki() throws -> Deplacements {
        tab = [Bool](repeating: false, count: 8)
        tab[1] = true
        tab[3] = true
        tab[4] = true
        tab[6] = true
        return self
    }
    
    //InitialiserKodama : Deplacements -> Deplacements
    //Pre : Deplacements Vide
    //Post : Deplacements correspondent au Kodama
    @discardableResult
    public mutating func InitialiserKodama() throws -> Deplacements{
        tab = [Bool](repeating: false, count: 8)
        tab[6] = true
        return self
    }
    
    //ChangerDeplacements : Deplacements -> Deplacements
    //Pour la transformation d'un kodama change les Deplacements
    //Pre : Les Deplacements correspondent à ceux d'un kodama ou SamouraiKodama
    //Post : Renvoie les nouveaux Deplacements
    @discardableResult
    public mutating func ChangerDeplacements() throws -> Deplacements {
        if tab[2] || tab[5]{
            tab = [Bool](repeating: false, count: 8)
            if tab[2]{
                tab[6]=true
            }
            else{
                tab[1]=true
            }
        }else{
            tab = [Bool](repeating: true, count: 8)
            tab[0] = false
            tab[2] = false
        }
        return self

    }
    
    //InverserDeplacementKodama : Deplacements -> Deplacements
    //Inverse le Deplacements du Kodama lors que la Piece sort de la Reserve
    //Pre : Le Deplacements correspondent à un Kodama
    //Post : Deplacements d'un Kodama dans l'autre sens qu'initialement
    @discardableResult
    public mutating func InverserDeplacementsKodama() throws -> Deplacements {
        if(tab[6]){
            tab[6]=false
            tab[1]=true
        }
        else{
            tab[1] = false
            tab[6] = true
        }
        return self
    }
    
    public func getTab() -> [Bool]{
        return tab
    }
}
