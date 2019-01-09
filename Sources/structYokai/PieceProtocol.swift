protocol PieceProtocol  {
	associatedtype TDeplacements : DeplacementsProtocol
	//init : String x Deplacement -> Piece
	//Creer une Piece au début du jeu
	//Pre : Le String correspond au nom d'une Piece du jeu suivie de 1 ou 2 en 
		//fonction du joueur auquel il appartient lors de sa création par exemple kodama1
		//8 cas différents
	//Pre : Le Deplacements correspond aux deplacements possiblent de la Piece 
	//(en générale pas dans un cas précis)
	//Post : Les coordonnées doivent être initialisés en fonction du nom de la Pièce
	//Post : La Piece prête pour le jeu (cas initial)
	init(nom: String, D: TDeplacements) throws

	//NomPiece : Piece -> String
	//Post : Renvoie le nom de la Piece 
	func NomPiece() -> String

	//CoordonneeX : Piece -> (Int | Vide)
	//Post : Renvoie le coordonnée X si la Piece est sur le plateau, Vide si il est dans la Reserve
	func CoordonneeX() -> Int?

	//CoordonneeY : Piece -> (Int | Vide)
	//Post : Renvoie le coordonnée Y si la Piece est sur le plateau, Vide si il est dans la Reserve
	func CoordonneeY() -> Int?

	//DeplacmentsPiece : Piece -> Deplacements
	//Post : Renvoie les Deplacements de la Piece
	func DeplacementsPiece() -> TDeplacements

	//DeplacementPossible : Piece x Int x Int -> Bool
	//Pre : Les Int sont des coordonnées x,y existant
	//Post : Renvoie True si le déplacment est possible (en fonction de Deplacements), False sinon
	func DeplacementPossible(x: Int, y: Int) -> Bool

	//ChangerCoordonneeX : Piece x (Int | Vide) -> Piece
	//Renvoie la Piece avec sa nouvelle coordonnées X
	//Pre : Le Int correspondent bien a une coordonnée X du jeu ou à Vide (Reserve)
	//Post : La Piece avec sa nouvelle coordonnée si c'est un Int, avec Vide pour x sinon
	@discardableResult
	mutating func ChangerCoordonneeX(x: Int?) -> Self 

	//ChangerCoordonneeY : Piece x (Int | Vide) -> Piece
	//Renvoie la Piece avec sa nouvelle coordonnées Y
	//Pre : Le Int correspondent bien a une coordonnée Y du jeu ou à Vide (Reserve)
	//Post : La Piece avec sa nouvelle coordonnée si c'est un Int, avec Vide pour y sinon
	@discardableResult
	mutating func ChangerCoordonneeY(y: Int?) -> Self 

	//ChangerCoordonnees : Piece x (Int | Vide) x (Int | Vide) -> Piece 
	//Renvoie la Piece avec ses nouvelles coordonnées
	//Pre : Les Int correspondent bien a une coordonnées du jeu ou les 2 sont à Vide (Reserve)
	//Pre : La Piece à le droit d'aller sur la case en fonction de son Deplacements
	//Post : La Piece avec ses nouvelles coordonnées si possible, avec Vide pour x et y si elle
		//va dans la reserve, rien ne change si les coordonnées ne sont pas possible
	@discardableResult
	mutating func ChangerCoordonnees(x: Int?, y: Int?) -> Self 

	//ChangerNom : Piece x String -> Piece
	//Change le nom d'une Piece
	//Pre : La piece est un Kodama (Kodama1/Kodama2/SamuraiKodama1/SamuraiKodama2)
	//Post : Transforme les Kodama en SamuraiKodama ou inversement
	@discardableResult
	mutating func ChangerNom(nom: String) -> Self 

	//TransformationKodama : Piece -> Piece
	//Transforme un Kodama en SamouraiKodama ou inversement
	//Pre : La Piece doit être un Kodama ou un SamouraiKodama
	//Post : La Piece transformé, changement du Nom et des Deplacements de la Piece
	@discardableResult
	mutating func TransformationKodama() -> Self

	//ModifPiece : Piece x Deplacements -> Piece
	//Change les deplacements d'une Piece Kodama qui vient d'être capturé en les inversant pour garder la bonne orientation par rapport au joueur qui possède la pièce
	//Pre : Deplacement non Vide et doit être l'inverse de celui que la pièce avait avant l'appel de la fonction
	//Pre : La Piece doit être un Kodama
	//Post : Renvoie la Piece avec ses nouveaux Deplacements
	@discardableResult
	mutating func ModifPiece(D: Deplacements) -> Self

}
