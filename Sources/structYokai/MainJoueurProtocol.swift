//MainJoueur est une collection de Pièces
//Cette collection peut être parcourue par 1 itérateurs.
protocol MainJoueurProtocol : Sequence{
	associatedtype TPiece : PieceProtocol
	//associatedtype TItMain : ItMainJoueurProtocol
	
	associatedtype IteratorMainJoueur : ItMainJoueurProtocol where IteratorMainJoueur.Element == TPiece
	
	//init: -> MainJoueur
	//Creer une main vide
	//Post : La main du joueur est créée et vide
	init()

	//RecupererPieceMainJoueur : MainJoueur x String -> (Piece | Vide)
	//Renvoie la pièce de la Main du joueur qui a le même nom que celui passé en paramètre
	//Post : Renvoie la pièce de la main du joueur ayant le même nom que celui passé en paramètre,
	//Post : Si elle n'existe pas dans la main du joueur alors renvoie Vide
	func RecupererPieceMainJoueur(Nom: String) -> TPiece? 

	//AjouterMainJoueur: MainJoueur x Piece -> MainJoueur
	//Pre : La pièce est bien définit et se situait précedemment dans la réserve du même joueur
	//Post : Renvoie la main du joueur avec la pièce ajoutée 
	@discardableResult
	mutating func AjouterMainJoueur(P: TPiece) throws -> Self

	//EnleverMainJoueur: MainJoueur x Piece -> MainJoueur
	//Pre : La pièce se situe dans la Main du joueur
	//Pre : MainJoueur n'est pas vide
	//Post : Renvoie la main du joueur avec la pièce enlever
	@discardableResult
	mutating func EnleverMainJoueur(P: TPiece) throws -> Self

	//ModifMainJoueur: MainJoueur x Piece -> MainJoueur
	//Pre : La pièce se situe dans la Main du joueur
	//Post : Renvoie la main du joueur avec la pièce donnée en paramètre qui remplace celle du même nom situé précedemment dans la main du joueur
	@discardableResult
	mutating func ModifMainJoueur(P: TPiece) throws -> Self

	//makeItMainJoueur : MainJoueur -> ItMainJoueur
    //Créer un itérateur qui parcours la collection MainJoueur
    func makeItMainJoueur() -> IteratorMainJoueur

	
}

protocol ItMainJoueurProtocol : IteratorProtocol {
	associatedtype TPiece : PieceProtocol
	associatedtype TMain : MainJoueurProtocol
	init(mainJ : TMain) 
	
	mutating func next()->TPiece?
}