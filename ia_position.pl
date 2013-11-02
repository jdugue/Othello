/***************************************************************************************************************************************
	Définit les valeurs des cases, utile pour les algos des IA

	nb de points : 
	cc : 500
	mdcc : -250
	dix : 10
	mcc : -150
	trente : 30
	un : 1
	deux : 2
	seize : 16
***************************************************************************************************************************************/

valeurs(cc,500).
valeurs(mdcc,-250).
valeurs(mcc,-150).
valeurs(dix,10).
valeurs(trente,30).
valeurs(nul,0).
valeurs(un,1).
valeurs(deux,2).
valeurs(seize,16).


valeur_case(Case,Valeur) :- member(Case,[[4,4],[-4,-4],[-4,4],[4,-4]]),valeurs(cc,Valeur).
valeur_case(Case,Valeur) :- member(Case,[[-3,4],[-4,3],[3,4],[4,3],[-3,-4],[-4,-3],[3,-4],[4,-3]]),valeurs(mcc,Valeur).
valeur_case(Case,Valeur) :- member(Case,[[-3,3],[-3,-3],[3,3],[3,-3]]),valeurs(mdcc,Valeur).
valeur_case(Case,Valeur) :- member(Case,[[-1,4],[1,4],[-1,-4],[1,-4],[-4,1],[-4,-1],[4,1],[4,-1]]),valeurs(dix,Valeur).
valeur_case(Case,Valeur) :- member(Case,[[-2,4],[2,4],[-2,-4],[2,-4],[-4,2],[-4,-2],[4,2],[4,-2]]),valeurs(trente,Valeur).
valeur_case(Case,Valeur) :- member(Case,[[-2,3],[-1,3],[1,3],[2,3],[-2,-3],[-1,-3],[1,-3],[2,-3],[-3,2],[-3,1],[-3,-1],[-3,-2],[3,2],[3,1],[3,-1],[3,-2]]),valeurs(nul,Valeur).
valeur_case(Case,Valeur) :- member(Case,[[-2,2],[2,2],[2,-2],[-2,-2]]),valeurs(un,Valeur).
valeur_case(Case,Valeur) :- member(Case,[[-1,2],[1,2],[-1,-2],[1,-2],[-2,1],[-2,-1],[2,1],[2,-1]]),valeurs(deux,Valeur).
valeur_case(Case,Valeur) :- member(Case,[[-1,1],[1,-1],[1,1],[-1,-1]]),valeurs(seize,Valeur).

choix_best(Case,ActuelBest,NewBest) :-
	valeur_case(Case,V1),
	valeur_case(ActuelBest,V2),
	V1<V2,
	NewBest = ActuelBest.	
choix_best(Case,ActuelBest,NewBest) :-
	valeur_case(Case,V1),
	valeur_case(ActuelBest,V2),
	V1>V2,
	NewBest = Case.	
choix_best(Case,ActuelBest,NewBest) :-
	valeur_case(Case,V1),
	valeur_case(ActuelBest,V2),
	V1==V2,
	NewBest = ActuelBest.

calcul([T|[]],Best,Choix) :- choix_best(T,Best,Choix).
calcul([T|Q],Best,Choix):-
	choix_best(T,Best,NewBest),
	calcul(Q,NewBest,Choix).
	
choix_move_POS([T|Q],_,_,Choix):-
	Best = T, %Initialise
	calcul(Q,Best,Choix).

	
		
	

