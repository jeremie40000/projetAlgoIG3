protocol DeplacementsProtocol {

	//init : -> Deplacements
	//Post : Renvoie Deplacements à Vide
	init()

	//InitialiserKoropokkuru : Deplacements -> Deplacements
	//Pre : Deplacements Vide
	//Post : Deplacements correspondent au Koropokkuru
	@discardableResult
	mutating func InitialiserKoropokkuru() throws -> Self 

	//InitialiserKitsune : Deplacements -> Deplacements
	//Pre : Deplacements Vide
	//Post : Deplacements correspondent au Kitsuneoropokkuru
	@discardableResult
	mutating func InitialiserKitsune() throws -> Self

	//InitialiserTanuki : Deplacements -> Deplacements
	//Pre : Deplacements Vide
	//Post : Deplacements correspondent au Tanuki
	@discardableResult
	mutating func InitialiserTanuki() throws -> Self

	//InitialiserKodama : Deplacements -> Deplacements
	//Pre : Deplacements Vide
	//Post : Deplacements correspondent au Kodama
	@discardableResult
	mutating func InitialiserKodama() throws -> Self

	//ChangerDeplacements : Deplacements -> Deplacements
	//Pour la transformation d'un kodama change les Deplacements
	//Pre : Les Deplacements correspondent à ceux d'un kodama ou SamouraiKodama
	//Post : Renvoie les nouveaux Deplacements
	@discardableResult
	mutating func ChangerDeplacements() throws -> Self

	//InverserDeplacementKodama : Deplacements -> Deplacements
	//Inverse le Deplacements du Kodama lors que la Piece sort de la Reserve
	//Pre : Le Deplacements correspondent à un Kodama
	//Post : Deplacements d'un Kodama dans l'autre sens qu'initialement
	@discardableResult
	mutating func InverserDeplacementsKodama() throws -> Self


}

