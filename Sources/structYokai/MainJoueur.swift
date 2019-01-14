//
//  MainJoueur.swift
//  
//
//  Created by Jeremie DUMONT on 17/12/2018.
//
//

import Foundation

enum MainJoueurError : Error{
    case invalidArgument
}

public struct MainJoueur : MainJoueurProtocol{
    var tab : [Piece]
    
    //init: -> MainJoueur
    //Creer une main vide
    //Post : La main du joueur est créée et vide
    public init(){
        tab = []
    }
    
    //RecupererPieceMainJoueur : MainJoueur x String -> (Piece | Vide)
    //Renvoie la pièce de la Main du joueur qui a le même nom que celui passé en paramètre
    //Post : Renvoie la pièce de la main du joueur ayant le même nom que celui passé en paramètre,
    //Post : Si elle n'existe pas dans la main du joueur alors renvoie Vide
    public func RecupererPieceMainJoueur(Nom: String) -> Piece?{
        var r : Piece?
        r = nil
        for i in 0..<tab.count {
            if(tab[i].NomPiece() == Nom){
                r = tab[i]
            }
        }
        return r
    }
    
    //AjouterMainJoueur: MainJoueur x Piece -> MainJoueur
    //Pre : La pièce est bien définit et se situait précedemment dans la réserve du même joueur
    //Post : Renvoie la main du joueur avec la pièce ajoutée
    @discardableResult
    public mutating func AjouterMainJoueur(P: Piece) throws -> MainJoueur {
        tab.append(P)
        return self
    }
    
    //EnleverMainJoueur: MainJoueur x Piece -> MainJoueur
    //Pre : La pièce se situe dans la Main du joueur
    //Pre : MainJoueur n'est pas vide
    //Post : Renvoie la main du joueur avec la pièce enlever
    @discardableResult
    public mutating func EnleverMainJoueur(P: Piece) throws -> MainJoueur{
        var presente : Bool = false
        var index = 0
        for i in 0..<tab.count {
            if(tab[i].NomPiece() == P.NomPiece()){
                presente = true
                index = i
            }
        }
        
        if(!presente){
            throw MainJoueurError.invalidArgument
        }
        else{
            tab.remove(at : index)
        }
        
        return self
    }
    
    //ModifMainJoueur: MainJoueur x Piece -> MainJoueur
    //Pre : La pièce se situe dans la Main du joueur
    //Post : Renvoie la main du joueur avec la pièce donnée en paramètre qui remplace celle du même nom situé précedemment dans la main du joueur
    @discardableResult
    public mutating func ModifMainJoueur(P: Piece) throws -> MainJoueur {
        var presente : Bool = false
        var index = 0
        for i in 0..<tab.count {
            if((tab[i].NomPiece() == P.NomPiece()) || ((P.NomPiece()=="SamuraiKodama1" || P.NomPiece()=="SamuraiKodama2") && (tab[i].NomPiece()=="Kodama1" || tab[i].NomPiece()=="Kodama2")) || ((P.NomPiece()=="Kodama1" || P.NomPiece()=="Kodama2") && (tab[i].NomPiece()=="SamuraiKodama1" || tab[i].NomPiece()=="SamuraiKodama2"))){
                presente = true
                index = i
            }
        }
        
        if(!presente){
            throw MainJoueurError.invalidArgument
        }
        else{
            tab[index] = P
        }
        
        return self
    }
    
    //makeItMainJoueur : MainJoueur -> ItMainJoueur
    //Créer un itérateur qui parcours la collection MainJoueur
    public func makeItMainJoueur() -> ItMainJoueur {
        return ItMainJoueur(mainJ : self)
    }
    public func makeIterator()-> ItMainJoueur{
        return makeItMainJoueur()
    }
}

public struct ItMainJoueur : ItMainJoueurProtocol {
    
    var main : MainJoueur
    var index : Int
    
    init(mainJ : MainJoueur){
        main = mainJ
        index = -1
    }
    
    public mutating func next()->Piece?{
        index += 1
        if(index >= main.tab.count){
            return nil
        }
        else{
            return main.tab[index]
        }
        
    }
}
