/***************************************************************************************************************************************
	Initialise un plateau de jeu.
	Structure d'une case: [Colonne, Ligne]
	Par exemple, la case [-4, 4] est la case en haut à gauche du plateau et [4, 4] celle en haut à droite.
***************************************************************************************************************************************/
init_plateau([[[1, 1], [-1, -1]], [[-1, 1], [1, -1]]]).

faux_plateau([[[1,1] , [1,2] ] , [[1,3],[4,4]]]).
/***************************************************************************************************************************************
	renvoie la valeur de l'indice supérieur à celui reçu en argument en tenant compte de l'ordre suivant:
	-3, -2, -1, 1, 2, 3
	
	voisin_superieur(1, -Y): associe 2 à Y car 2 est le voisin supérieur de 1.
	voisin_superieur(-X, 2): associe 1 à X car 1 est le voisin inférieur de 2 puisque 2 est le voisin supérieur de 1.
	voisin_superieur(1, 2) = true car 2 est après 1 (attention à voisin_superieur(-1, 1) qui est true également).
	voisin_superieur(1, 3) = false car le voisin supérieur de 1 est 2 et non 3.
***************************************************************************************************************************************/
voisin_superieur(-4, -3).
voisin_superieur(-3, -2).
voisin_superieur(-2, -1).
voisin_superieur(-1, 1).
voisin_superieur(1, 2).
voisin_superieur(2, 3).
voisin_superieur(3, 4).

/***************************************************************************************************************************************
	On peut se déplacer dans tous les sens. Nous avons donc décidé d'utiliser les noms des points cardinaux pour plus de simplicité.
	Cette fonction permet de récupérer les coordonnées de la case voisine suivant une direction donnée parmi les points cardinaux:
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
liste_case_voisine( Case , Liste) :-
	findall( Voisin , case_voisine(Case, Direction, Voisin) , Liste).

/***************************************************************************************************************************************
	Permet de récupérer la couleur de l'adversaire.
	couleur_adversaire(+C1, -C2): Affecte à C2 la couleur de l'adversaire de C1.
***************************************************************************************************************************************/
couleur_adversaire(b, w).
couleur_adversaire(w, b).

/***************************************************************************************************************************************
	Définit les valeurs des cases, utile pour les algos des IA
***************************************************************************************************************************************/

valeurs(cc,500).
valeurs(mdcc,-250).
valeurs(mcc,-150).
valeurs(dix,10).
valeurs(trente,30).
valeurs(nul,0).
valeurs(un,1).
valeurs(deux,30).
valeurs(seize,30).


valeur_case(Case,Valeur) :- member(Case,[[1,1],[-1,-1],[-1,1],[1,-1]]),valeurs(cc,Valeur).
valeur_case(Case,Valeur) :- member(Case,[[-3,4],[-4,3],[3,4],[4,3],[-3,-4],[-4,-3],[3,-4],[4,-3]]),valeurs(mcc,Valeur).
valeur_case(Case,Valeur) :- member(Case,[[-3,3],[-3,-3],[3,3],[3,-3]]),valeurs(mdcc,Valeur).
valeur_case(Case,Valeur) :- member(Case,[[-1,4],[1,4],[-1,-4],[1,-4],[-4,1],[-4,-1],[4,1],[4,-1]]),valeurs(dix,Valeur).
valeur_case(Case,Valeur) :- member(Case,[[-2,4],[2,4],[-2,-4],[2,-4],[-4,2],[-4,-2],[4,2],[4-2]]),valeurs(trente,Valeur).
valeur_case(Case,Valeur) :- member(Case,[[-2,3],[-1,3],[1,3],[2,3],[-2,-3],[-1,-3],[1,-3],[2,-3],[-3,2],[-3,1],[-3,-1],[-3,-2],[3,2],[3,1],[3,-1],[3,-2]]),valeurs(nul,Valeur).
valeur_case(Case,Valeur) :- member(Case,[[-2,2],[2,2],[2,-2],[-2,-2]]),valeurs(un,Valeur).
valeur_case(Case,Valeur) :- member(Case,[[-1,2],[1,2],[-1,-1],[-1,1],[-2,1],[-2,-1],[2,1],[2,-1]]),valeurs(deux,Valeur).
valeur_case(Case,Valeur) :- member(Case,[[-1,1],[1,-1],[1,1],[-1,-1]]),valeurs(seize,Valeur).


