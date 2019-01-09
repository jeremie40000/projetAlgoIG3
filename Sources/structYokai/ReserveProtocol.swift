//Réserve est une collection de Pièces
//Cette collection peut être parcourue par 1 itérateurs.
protocol ReserveProtocol : Sequence{
    associatedtype TPiece : PieceProtocol
    associatedtype ItReserve : ItReserveProtocol where ItReserve.Element == TPiece
    
    
    //init : -> Reserve
    //création d'une Reserve, initialisé à Vide
    init()
    
    //AjouterReserve : Reserve x Piece -> Reserve 
    // Ajout d'une pièce au début de la Reserve
    //Pre : Le Piece n'est pas déjà dans la réserve
    //Post : La Reserve avec la Pièce donné en paramètre si la précondition est repecté, sinon rien n'est changé. 
    @discardableResult
    mutating func AjouterReserve(P: TPiece) throws -> Self
    
    //EnleverReserve : Reserve x Piece ->Reserve
    //Enlever la pièce donné en paramètre de la Reserve
    //La Reserve n'est pas vide
    //Pre : La Pièce se trouve dans la réserve
    //Post : La Reserve sans la Piece passé en paramètre si les preconditions sont respectés, sinon rien n'est changé.
    @discardableResult
    mutating func EnleverReserve(P: TPiece) throws -> Self
    
    //ReserveEstVide : Reserve  -> Bool
    //Post : Retourne True si la Reserve est Vide, False sinon
    func ReserveEstVide() -> Bool
    
    //RecupererPieceReserve : Reserve x String -> (TPiece | Vide)
    //Retourne la Piece qui correspond au nom donnée en paramètre
    //Post : retourne Vide si le nom de piece n'existe pas ou si elle n'est pas dans la réserve, Renvoie la Pièce sinon
    func RecupererPieceReserve(Nom: String) -> TPiece?
    
    //makeItReserve : Reserve -> ItReserve
    //Créer un itérateur qui parcours la collection 
    func makeItReserve() -> ItReserve
    
}

protocol ItReserveProtocol : IteratorProtocol {
    associatedtype TPiece : PieceProtocol
    associatedtype TReserve : ReserveProtocol
    init(r : TReserve)
    mutating func next()->TPiece?
}