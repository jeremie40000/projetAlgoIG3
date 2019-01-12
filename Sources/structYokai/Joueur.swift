enum JoueurError : Error {
	case MauvaisNum
	case ReserveNonVide
	case MainJoueurNonRemplie
}

public struct Joueur : JoueurProtocol{

	var res : Reserve
	var mainJ : MainJoueur
	var num : Int
	var nom : String
	//init : Int x String -> Joueur
	//Creer un Joueur au début du Jeu
	//Pre : Int doit être égale à 1 ou 2 (pour Joueur 1 ou Joueur 2)
	//Pre : String est le nom du Joueur 
	//Post : Creer la Reserve qui doit être vide
	//Post : La MainJoueur doit être remplie des Pieces initiales en fonction du Int (1 ou 2)
	//Post : Joueur initialisé pour le début de la partie (2 cas différents en fonction du Int)
	init(Num: Int, NomJ: String) throws {
		self.num = Num
		self.nom = NomJ
		if (Num != 1 && Num != 2) {
			print("erreur 1")
			throw JoueurError.MauvaisNum
		}
		res = Reserve()
		if !res.ReserveEstVide() {
			print("erreur 2")
			throw JoueurError.ReserveNonVide
		}
		mainJ = MainJoueur()
		

		var deplacementKodama : Deplacements = Deplacements()
		deplacementKodama = try! deplacementKodama.InitialiserKodama()
		var deplacementKoropokkuru : Deplacements = Deplacements()
		deplacementKoropokkuru = try! deplacementKoropokkuru.InitialiserKoropokkuru()
		var deplacementKitsune : Deplacements = Deplacements()
		deplacementKitsune = try! deplacementKitsune.InitialiserKitsune()
		var deplacementTanuki : Deplacements = Deplacements()
		deplacementTanuki = try! deplacementTanuki.InitialiserTanuki()

		var kodama : Piece = try! Piece(nom : "Kodama\(num)", D : deplacementKodama)
		let koropokkuru : Piece = try! Piece(nom : "Koropokkuru\(num)", D : deplacementKoropokkuru)
		let kitsune : Piece = try! Piece(nom : "Kitsune\(num)", D : deplacementKitsune)
		let tanuki : Piece = try! Piece(nom : "Tanuki\(num)", D : deplacementTanuki)

		if(Num==1){
			do{
			var d : Deplacements = kodama.DeplacementsPiece()
			try d.InverserDeplacementsKodama()
			kodama.ModifPiece(D : d)
			}catch{}
		}

		do{
			try mainJ.AjouterMainJoueur(P : kodama)
			try mainJ.AjouterMainJoueur(P : koropokkuru)
			try mainJ.AjouterMainJoueur(P : kitsune)
			try mainJ.AjouterMainJoueur(P : tanuki)
		}catch{

		}
		
	}


	//Reserve : Joueur -> Reserve
	//Renvoie la Reserve d'un Joueur
	//Post : Reserve
	public func getReserve() -> Reserve {
		return res

	}

	//MainJoueur : Joueur -> MainJoueur
	//Renvoie la MainJoueur d'un Joueur
	//Post : MainJoueur
	public func getMainJoueur() -> MainJoueur {
		return mainJ

	}

	//NomJoueur : Joueur -> String
	//Renvoie le Nom d'un Joueur
	//Post : String
	public func NomJoueur() -> String {
		return nom

	}

	//ModifJoueur : Joueur x Reserve x MainJoueur -> Joueur
	//Modifie Un Joueur, change sa MainJoueur et sa Reserve 
	//Post : Joueur avec sa MainJoueur et sa Reserve modifié
	@discardableResult
	public mutating func ModifJoueur(R: Reserve, M: MainJoueur) -> Joueur {
		self.res = R
		self.mainJ = M
		return self
	}
}
