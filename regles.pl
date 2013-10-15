/***************************************************************************************************************************************
	Initialise un plateau de jeu.
	Structure d'une case: [Colonne, Ligne]
	Par exemple, la case [-4, 4] est la case en haut � gauche du plateau et [4, 4] celle en haut � droite.
***************************************************************************************************************************************/
init_plateau([[[1, 1], [-1, -1]], [[-1, 1], [1, -1]]]).

/***************************************************************************************************************************************
	renvoie la valeur de l'indice sup�rieur � celui re�u en argument en tenant compte de l'ordre suivant:
	-3, -2, -1, 1, 2, 3
	
	voisin_superieur(1, -Y): associe 2 � Y car 2 est le voisin sup�rieur de 1.
	voisin_superieur(-X, 2): associe 1 � X car 1 est le voisin inf�rieur de 2 puisque 2 est le voisin sup�rieur de 1.
	voisin_superieur(1, 2) = true car 2 est apr�s 1 (attention � voisin_superieur(-1, 1) qui est true �galement).
	voisin_superieur(1, 3) = false car le voisin sup�rieur de 1 est 2 et non 3.
***************************************************************************************************************************************/
voisin_superieur(-4, -3).
voisin_superieur(-3, -2).
voisin_superieur(-2, -1).
voisin_superieur(-1, 1).
voisin_superieur(1, 2).
voisin_superieur(2, 3).
voisin_superieur(3, 4).

/***************************************************************************************************************************************
	On peut se d�placer dans tous les sens. Nous avons donc d�cid� d'utiliser les noms des points cardinaux pour plus de simplicit�.
	Cette fonction permet de r�cup�rer les coordonn�es de la case voisine suivant une direction donn�e parmi les points cardinaux:
	- nord
	- nordEst
	- est
	- sudEst
	- sud
	- sudOuest
	- ouest
	- nordOuest
	
	case_voisine(+Case, +Direction, -CaseVoisine) -> Renvoie la case voisine de Case suivant la direction Direction.
	case_voisine(+Case, -Direction, -CaseVoisine) -> Renvoie toutes les cases voisines de Case en backtrackant.
***************************************************************************************************************************************/
case_voisine([Xd, Yd], est, [Xa, Yd]) :- voisin_superieur(Xd, Xa).
case_voisine([Xd, Yd], sudEst, [Xa, Ya]) :- voisin_superieur(Xd, Xa), voisin_superieur(Ya, Yd).
case_voisine([Xd, Yd], sud, [Xd, Ya]) :- voisin_superieur(Ya, Yd).
case_voisine([Xd, Yd], sudOuest, [Xa, Ya]) :- voisin_superieur(Xa, Xd), voisin_superieur(Ya, Yd).
case_voisine([Xd, Yd], ouest, [Xa, Yd]) :- voisin_superieur(Xa, Xd).
case_voisine([Xd, Yd], nordOuest, [Xa, Ya]) :- voisin_superieur(Xa, Xd), voisin_superieur(Yd, Ya).
case_voisine([Xd, Yd], nord, [Xd, Ya]) :- voisin_superieur(Yd, Ya).
case_voisine([Xd, Yd], nordEst, [Xa, Ya]) :- voisin_superieur(Xd, Xa), voisin_superieur(Yd, Ya).

/******************************************************************************************
@Joss et Ianic
renvoie les cases voisines d'une case dans une liste.
**********************************************************************************************/
cases_voisines_pos(Case, Liste) :-
	findall(Voisin, case_voisine(Case, Direction, Voisin), Liste).
	
calcul_cases_voisines([Pos], CasesVides) :- cases_voisines_pos(Pos, CasesVides).
calcul_cases_voisines([T|Q], CasesVides) :-  calcul_cases_voisines(Q, OldVides), cases_voisines_pos(T, NewVides), append(NewVides, OldVides, CasesVides).
	
	
cases_voisines_joueur(Couleur, Plateau, Cases) :- pionsJoueur(Couleur, Plateau, Pions), calcul_cases_voisines(Pions, TempCases), sort(TempCases, Cases).





coups_legaux(Couleur, Plateau, Coups) :- couleur_adversaire(Couleur,Adversaire), cases_voisines_joueur(Adversaire, Plateau, Voisines), cases_vides(Voisines, Plateau, Coups).
/***************************************************************************************************************************************
	Permet de r�cup�rer la couleur de l'adversaire.
	couleur_adversaire(+C1, -C2): Affecte � C2 la couleur de l'adversaire de C1.
***************************************************************************************************************************************/
couleur_adversaire(b, w).
couleur_adversaire(w, b).
