protocol JoueurProtocol  {
	associatedtype TReserve : ReserveProtocol
	associatedtype TMain : MainJoueurProtocol
	
	//init : Int x String -> Joueur
	//Creer un Joueur au début du Jeu
	//Pre : Int doit être égale à 1 ou 2 (pour Joueur 1 ou Joueur 2)
	//Pre : String est le nom du Joueur 
	//Post : Creer la Reserve qui doit être vide
	//Post : La MainJoueur doit être remplie des Pieces initiales en fonction du Int (1 ou 2)
	//Post : Joueur initialisé pour le début de la partie (2 cas différents en fonction du Int)
	init(Num: Int, NomJ: String) throws

	//Reserve : Joueur -> Reserve
	//Renvoie la Reserve d'un Joueur
	//Post : Reserve
	func getReserve() -> TReserve

	//MainJoueur : Joueur -> MainJoueur
	//Renvoie la MainJoueur d'un Joueur
	//Post : MainJoueur
	func getMainJoueur() -> TMain

	//NomJoueur : Joueur -> String
	//Renvoie le Nom d'un Joueur
	//Post : String
	func NomJoueur() -> String

	//ModifJoueur : Joueur x Reserve x MainJoueur -> Joueur
	//Modifie Un Joueur, change sa MainJoueur et sa Reserve 
	//Post : Joueur avec sa MainJoueur et sa Reserve modifié
	@discardableResult
	mutating func ModifJoueur(R: TReserve, M: TMain) -> Self 

}