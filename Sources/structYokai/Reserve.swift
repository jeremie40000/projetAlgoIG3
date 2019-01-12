//Réserve est une collection de Pièces
//Cette collection peut être parcourue par 1 itérateurs.
public struct Reserve : ReserveProtocol{
    //associatedtype IteratorReserve : IteratorProtocol where IteratorReserve.Element == Piece
    
    var tabRes :  [Piece] //tableau initialise a vide de taille 6 pour les 6 piece potentiellement capturable
    
    //init : -> Reserve
    //création d'une Reserve, initialisé à Vide
    init(){
         tabRes = []
    }
    
    //AjouterReserve : Reserve x Piece -> Reserve 
    // Ajout d'une pièce au début de la Reserve
    //Pre : Le Piece n'est pas déjà dans la réserve
    //Post : La Reserve avec la Pièce donné en paramètre si la précondition est repecté, sinon rien n'est changé. 
    @discardableResult
    public mutating func AjouterReserve(P: Piece) throws -> Reserve {
        tabRes.append(P)
        return self

    }
    
    //EnleverReserve : Reserve x Piece ->Reserve
    //Enlever la pièce donné en paramètre de la Reserve
    //La Reserve n'est pas vide
    //Pre : La Pièce se trouve dans la réserve
    //Post : La Reserve sans la Piece passé en paramètre si les preconditions sont respectés, sinon rien n'est changé.
    @discardableResult
    public mutating func EnleverReserve(P: Piece) throws -> Reserve {
        var presente : Bool = false
        var index = 0
        for i in 0..<tabRes.count {
            if(tabRes[i].NomPiece() == P.NomPiece()){
                presente = true
                index = i
            }
        }
        
        if(!presente){
            throw MainJoueurError.invalidArgument
        }
        else{
            tabRes.remove(at : index)
        }
        return self

    }
    
    //ReserveEstVide : Reserve  -> Bool
    //Post : Retourne True si la Reserve est Vide, False sinon
    public func ReserveEstVide() -> Bool{
        return tabRes.count == 0

    }
    
    //RecupererPieceReserve : Reserve x String -> (Piece | Vide)
    //Retourne la Piece qui correspond au nom donnée en paramètre
    //Post : retourne Vide si le nom de piece n'existe pas ou si elle n'est pas dans la réserve, Renvoie la Pièce sinon
    public func RecupererPieceReserve(Nom: String) -> Piece? {
        var r : Piece? = nil
        for i in 0..<tabRes.count {
                if Nom == tabRes[i].NomPiece(){
                    r = tabRes[i]
                }
        }
            return r
    }
    
    //makeItReserve : Reserve -> ItReserve
    //Créer un itérateur qui parcours la collection 

    public func makeItReserve()->ItReserve{
        return ItReserve(r : self)
    }

    public func makeIterator() -> ItReserve {
        return makeItReserve()

    }
    
}

public struct ItReserve : ItReserveProtocol{

    var res : Reserve
    var index : Int
    init(r : Reserve){
            res = r
            index = -1
    }

    public mutating func next() -> Piece?{
        index += 1
        if index >= res.tabRes.count {
            return nil
        }
        else {
            return res.tabRes[index]
        }
    }    
}
