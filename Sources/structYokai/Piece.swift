enum PieceError : Error {
    case invalidArgument
}

public struct Piece : PieceProtocol  {
	
    var x : Int?
    var y : Int?
    var dep : Deplacements
    var nomP : String
    
	//init : String x Deplacement -> Piece
	//Creer une Piece au début du jeu
	//Pre : Le String correspond au nom d'une Piece du jeu suivie de 1 ou 2 en 
		//fonction du joueur auquel il appartient lors de sa création par exemple kodama1
		//8 cas différents
	//Pre : Le Deplacements correspond aux deplacements possiblent de la Piece 
	//(en générale pas dans un cas précis)
	//Post : Les coordonnées doivent être initialisés en fonction du nom de la Pièce
	//Post : La Piece prête pour le jeu (cas initial)
    init(nom: String, D: Deplacements) throws {
        if(nom == "Kodama1"){
            x = 1
            y = 2
        }
        else if (nom == "Kodama2"){
            x = 1
            y = 1
        }
        else if (nom == "Kitsune1"){
            x = 0
            y = 3
        }
        else if (nom == "Kitsune2"){
            x = 2
            y = 0
        }
        else if (nom == "Tanuki1"){
            x = 2
            y = 3
        }
        else if (nom == "Tanuki2"){
            x = 0
            y = 0
        }
        else if (nom == "Koropokkuru1"){
            x = 1
            y = 3
        }
        else if (nom == "Koropokkuru2"){
            x = 1
            y = 0
        }
        else{
            throw PieceError.invalidArgument
        }
        nomP = nom
        dep = D
    }

	//NomPiece : Piece -> String
	//Post : Renvoie le nom de la Piece 
    public func NomPiece() -> String{
        return nomP
    }

	//CoordonneeX : Piece -> (Int | Vide)
	//Post : Renvoie le coordonnée X si la Piece est sur le plateau, Vide si il est dans la Reserve
    public func CoordonneeX() -> Int?{
        return x
    }

	//CoordonneeY : Piece -> (Int | Vide)
	//Post : Renvoie le coordonnée Y si la Piece est sur le plateau, Vide si il est dans la Reserve
    public func CoordonneeY() -> Int?{
        return y
    }

	//DeplacmentsPiece : Piece -> Deplacements
	//Post : Renvoie les Deplacements de la Piece
    public func DeplacementsPiece() -> Deplacements{
        return dep
    }

	//DeplacementPossible : Piece x Int x Int -> Bool
	//Pre : Les Int sont des coordonnées x,y existant
	//Post : Renvoie True si le déplacment est possible (en fonction de Deplacements), False sinon
    public func DeplacementPossible(x: Int, y: Int) -> Bool{
        var tab = dep.getTab()
        if(self.x == nil || self.y == nil){
            return false
        }
        else{
            var newX : Int = 99
            var newY : Int = 99
            if let myX = self.x {
                newX = myX
            }
            if let myY = self.y {
                newY = myY
            }
            if(newX == x && newY+1 == y && tab[6]){
                return true
            }
            else if (newX == x && newY-1 == y && tab[1]){
                return true
            }
            else if (newX-1 == x && newY == y && tab[3]){
                return true
            }
            else if (newX+1 == x && newY == y && tab[4]){
                return true
            }
            else if (newX-1 == x && newY-1 == y && tab[0]){
                return true
            }
            else if (newX+1 == x && newY+1 == y && tab[7]){
                return true
            }
            else if (newX-1 == x && newY+1 == y && tab[5]){
                return true
            }
            else if (newX+1 == x && newY-1 == y && tab[2]){
                return true
            }
            else{
                return false
            }
        }    
    }

	//ChangerCoordonneeX : Piece x (Int | Vide) -> Piece
	//Renvoie la Piece avec sa nouvelle coordonnées X
	//Pre : Le Int correspondent bien a une coordonnée X du jeu ou à Vide (Reserve)
	//Post : La Piece avec sa nouvelle coordonnée si c'est un Int, avec Vide pour x sinon
	@discardableResult
    public mutating func ChangerCoordonneeX(x: Int?) -> Piece {
        self.x = x
        return self
    }

	//ChangerCoordonneeY : Piece x (Int | Vide) -> Piece
	//Renvoie la Piece avec sa nouvelle coordonnées Y
	//Pre : Le Int correspondent bien a une coordonnée Y du jeu ou à Vide (Reserve)
	//Post : La Piece avec sa nouvelle coordonnée si c'est un Int, avec Vide pour y sinon
	@discardableResult
    public mutating func ChangerCoordonneeY(y: Int?) -> Piece {
        self.y = y
        return self
    }

	//ChangerCoordonnees : Piece x (Int | Vide) x (Int | Vide) -> Piece 
	//Renvoie la Piece avec ses nouvelles coordonnées
	//Pre : Les Int correspondent bien a une coordonnées du jeu ou les 2 sont à Vide (Reserve)
	//Pre : La Piece à le droit d'aller sur la case en fonction de son Deplacements
	//Post : La Piece avec ses nouvelles coordonnées si possible, avec Vide pour x et y si elle
		//va dans la reserve, rien ne change si les coordonnées ne sont pas possible
	@discardableResult
    public mutating func ChangerCoordonnees(x: Int?, y: Int?) -> Piece {
        self.x = x
        self.y = y
        return self
    }

	//ChangerNom : Piece x String -> Piece
	//Change le nom d'une Piece
	//Pre : La piece est un Kodama (Kodama1/Kodama2/SamuraiKodama1/SamuraiKodama2)
	//Post : Transforme les Kodama en SamuraiKodama ou inversement
	@discardableResult
    public mutating func ChangerNom(nom: String) -> Piece {
        nomP = nom
        return self
    }

	//TransformationKodama : Piece -> Piece
	//Transforme un Kodama en SamouraiKodama ou inversement
	//Pre : La Piece doit être un Kodama ou un SamouraiKodama
	//Post : La Piece transformé, changement du Nom et des Deplacements de la Piece
	@discardableResult
    public mutating func TransformationKodama() -> Piece {
        if(nomP=="Kodama1"){
            ChangerNom(nom : "SamuraiKodama1")
        }
        else if(nomP=="Kodama2"){
            ChangerNom(nom : "SamuraiKodama2")
        }else if(nomP=="SamuraiKodama1"){
            ChangerNom(nom : "Kodama1")
        }
        else if(nomP=="SamuraiKodama2"){
            ChangerNom(nom : "Kodama2")
        }
        
        do{
            try dep.ChangerDeplacements()
        }catch{

        }
        return self
    }

	//ModifPiece : Piece x Deplacements -> Piece
	//Change les deplacements d'une Piece Kodama qui vient d'être capturé en les inversant pour garder la bonne orientation par rapport au joueur qui possède la pièce
	//Pre : Deplacement non Vide et doit être l'inverse de celui que la pièce avait avant l'appel de la fonction
	//Pre : La Piece doit être un Kodama
	//Post : Renvoie la Piece avec ses nouveaux Deplacements
	@discardableResult
    public mutating func ModifPiece(D: Deplacements) -> Piece{
        dep = D
        return self
    }

}
