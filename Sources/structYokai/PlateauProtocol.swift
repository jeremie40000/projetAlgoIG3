
protocol PlateauProtocol  {
	associatedtype TJoueur : JoueurProtocol
	associatedtype TPiece : PieceProtocol
	//init : String x String -> Plateau
	//Initialise un Plateau avec 2 Joueur (J1 et J2), avec des noms de joueurs rentré par les utilisateurs et différents.
	//Le plateau a une taille de 3 * 4 (soit 3 de largeur (coordonnée X) et 4 de hauteur (coordonnée Y))
	//La première case du plateau, soit la coordonnée (0;0) avec x = 0 et y = 0, se situe en haut à gauche du plateau.
	//Post: Crée le plateau avec deux joueurs créés avec comme nom les String données en paramètre 
	init(nomJ1: String, nomJ2: String)

	//Joueur1 : Plateau -> Joueur
	//Renvoie J1
	func Joueur1() -> TJoueur 

	//Joueur2 : Plateau -> TJoueur
	//Renvoie J2
	func Joueur2() -> TJoueur 

	//CaseVide : Plateau x Int x Int -> Bool
	//Dit si une case du Plateau est vide
	//Pre : Int x Int correspond à une case du Plateau
    //Pre : Les coordonées doivent être positive
	//Post : Renvoie true si la case est vide false sinon
	func CaseVide(x: Int, y: Int) throws -> Bool

	//CaseEnnemie : Plateau x Int x Int -> Bool
	//Dit si une case du Plateau est occupé par une Piece ennemie
	//Pre : Int x Int correspond à une case du Plateau
	//Post : Renvoie true si la case est occupé par une Piece ennemie false sinon
	func CaseEnnemie(JCourant : Joueur,x: Int, y: Int) throws -> Bool

	//RecupererPiecePlateau : Plateau x Int x Int -> Piece
	//Recupère une Piece du Plateau qui est aux coordonées données par Int x Int
	//Pre : Int x Int correspond à une case du Plateau
	//Pre : La case données par les Int n'est pas vide
	//Post : Renvoie la Piece qui est sur la Case des coordonées rentré 
	func RecupererPiecePlateau(x: Int, y: Int) throws -> TPiece 

	//ModifPlateau : Plateau x Joueur x Joueur -> Plateau
	//Modifie le Plateau avec les 2 joueurs rentré en paramètre
	//Pre : Les 2 Joueurs sont bien définit, un Joueurs 1 et un Joueurs 2
	//Post : Retourne Le Plateau de Jeu modifié avec les Joueur J1 et J2
	mutating func ModifPlateau(J1: TJoueur, J2: TJoueur) throws -> Self 

	//ZoneDePromotion : Plateau x Piece -> Bool
	//Dit si une Piece est dans la Zonne de Promotion de l'adversaire
	//Pre : La Piece est dans la Main d'un des Joueur
	//Post : True si la piece est dans la zone de Promotion, false sinon
	func ZoneDePromotion(piece: TPiece) throws -> Bool


}
