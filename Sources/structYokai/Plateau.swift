enum PlateauError : Error {
	case caseIncorrecte
	case caseIncorrecte2
	case argumentInvalide
}

public struct Plateau : PlateauProtocol{

	var j1 : Joueur
	var j2 : Joueur
	var tab = [[Piece?]]()

	//init : String x String -> Plateau
	//Initialise un Plateau avec 2 Joueur (J1 et J2), avec des noms de joueurs rentré par les utilisateurs et différents.
	//Le plateau a une taille de 3 * 4 (soit 3 de largeur (coordonnée X) et 4 de hauteur (coordonnée Y))
	//La première case du plateau, soit la coordonnée (0;0) avec x = 0 et y = 0, se situe en haut à gauche du plateau.
	//Post: Crée le plateau avec deux joueurs créés avec comme nom les String données en paramètre 
	public init(nomJ1: String, nomJ2: String) throws{
		do{
			j1 = try Joueur(Num : 1, NomJ : nomJ1)
			j2 = try Joueur(Num : 2, NomJ : nomJ2)	

			tab = Array(repeating: Array(repeating: nil, count: 3), count: 4)
		/*for i in 0..<4 {
			tab.append(nil)
			for j in 0..<3 {
				tab[i].append(nil)
			}
		}*/

		//Initialiser les cases en fonciton de la main du joueur
		var itJ1 = j1.getMainJoueur().makeItMainJoueur()
		while let p = itJ1.next(){
			
			
			if let o =  p.CoordonneeY() {
				if let m =  p.CoordonneeX()  {
					tab[o][m] = p
				}
			}
		}
		var itJ2 = j2.getMainJoueur().makeItMainJoueur()
		while let p = itJ2.next(){
			if let o =  p.CoordonneeY() {
				if let m =  p.CoordonneeX()  {
					tab[o][m] = p
				}
			}
		}
		}catch{
			throw PlateauError.caseIncorrecte2
		}
		
		
	} 

	//Joueur1 : Plateau -> Joueur
	//Renvoie J1
	public func Joueur1() -> Joueur {
		return j1;
	}

	//Joueur2 : Plateau -> Joueur
	//Renvoie J2
	public func Joueur2() -> Joueur {
		return j2;
	}

	//CaseVide : Plateau x Int x Int -> Bool
	//Dit si une case du Plateau est vide
	//Pre : Int x Int correspond à une case du Plateau
    //Pre : Les coordonées doivent être positive
	//Post : Renvoie true si la case est vide false sinon
	public func CaseVide(x: Int, y: Int) throws -> Bool {
		if(x<0 || y<0 || x>2 || y>3){
			throw PlateauError.caseIncorrecte
		}
		else{
			return tab[y][x] == nil
		}
	}

	//CaseEnnemie : Plateau x Int x Int -> Bool
	//Dit si une case du Plateau est occupé par une Piece ennemie
	//Pre : Int x Int correspond à une case du Plateau
	//Post : Renvoie true si la case est occupé par une Piece ennemie false sinon
	public func CaseEnnemie(JCourant : Joueur, x: Int, y: Int) throws -> Bool {
		if(x<0 || y<0 || x>2 || y>3){
			throw PlateauError.caseIncorrecte
		}

		guard let piece = tab[y][x] else{
			return false
		}

		var appartientJ1 = false
		var itJ1 = j1.getMainJoueur().makeItMainJoueur()
		while let p = itJ1.next(){
			if (p.NomPiece() == piece.NomPiece()){
				appartientJ1 = true
			}
		}
		if(appartientJ1){
			return JCourant.NomJoueur() == j2.NomJoueur() 
		}
		else{
			return JCourant.NomJoueur() == j1.NomJoueur()
		}
	}

	//RecupererPiecePlateau : Plateau x Int x Int -> Piece
	//Recupère une Piece du Plateau qui est aux coordonées données par Int x Int
	//Pre : Int x Int correspond à une case du Plateau
	//Pre : La case données par les Int n'est pas vide
	//Post : Renvoie la Piece qui est sur la Case des coordonées rentré 
	public func RecupererPiecePlateau(x: Int, y: Int) throws -> Piece{
		var r : Piece
		if(tab[y][x] != nil && x>=0 && y>=0 && x<3 && y<4){
			if let p = tab[y][x]{
				r = p
				return r
			}
			else{
				throw PlateauError.caseIncorrecte
			}
		}
		else{
			throw PlateauError.caseIncorrecte
		}
	}

	//ModifPlateau : Plateau x Joueur x Joueur -> Plateau
	//Modifie le Plateau avec les 2 joueurs rentré en paramètre
	//Pre : Les 2 Joueurs sont bien définit, un Joueurs 1 et un Joueurs 2
	//Post : Retourne Le Plateau de Jeu modifié avec les Joueur J1 et J2
	public mutating func ModifPlateau(J1: Joueur, J2: Joueur) throws -> Plateau {
		if(J1.NomJoueur() == J2.NomJoueur() || J1 == nil || J2 == nil){
			throw PlateauError.argumentInvalide
		}
		else{
			j1 = J1
			j2 = J2
		}

		//reinitialiser toutes les cases du tableau avec les nouveaux joueurs
		tab = Array(repeating: Array(repeating: nil, count: 3), count: 4)
		/*for i in 0..<4 {
			tab.append(nil)
			for j in 0..<3 {
				tab[i].append(nil)
			}
		}*/

		//Initialiser les cases en fonciton de la main du joueur
		var itJ1 = j1.getMainJoueur().makeItMainJoueur()
		while let p = itJ1.next(){
			if let o =  p.CoordonneeY() {
				if let m =  p.CoordonneeX()  {
					tab[o][m] = p
				}
			}
		}
		var itJ2 = j2.getMainJoueur().makeItMainJoueur()
		while let p = itJ2.next(){
			if let o =  p.CoordonneeY() {
				if let m =  p.CoordonneeX()  {
					tab[o][m] = p
				}
			}
		}

		
		return self
	}

	//ZoneDePromotion : Plateau x Piece -> Bool
	//Dit si une Piece est dans la Zonne de Promotion de l'adversaire
	//Pre : La Piece est dans la Main d'un des Joueur
	//Post : True si la piece est dans la zone de Promotion, false sinon
	public func ZoneDePromotion(piece: Piece) throws -> Bool {
		var appartient : Int = 0

		guard let y = piece.CoordonneeY() else {
			throw PlateauError.argumentInvalide
		}

		var itJ1 = j1.getMainJoueur().makeItMainJoueur()
		while let p = itJ1.next(){
			if (p.NomPiece() == piece.NomPiece()){
				appartient = 1
			}
		}
		if (appartient == 0){
			var itJ2 = j2.getMainJoueur().makeItMainJoueur()
			while let p = itJ2.next(){
				if (p.NomPiece() == piece.NomPiece()){
				appartient = 2
				}
			}
		}
		if(appartient == 0){
			throw PlateauError.argumentInvalide
		}
		else if appartient == 1 {
			return y == 3
		}
		else {
			return y == 0
		}

	}
}

