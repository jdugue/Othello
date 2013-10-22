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


/* Algo minimax d'apres le livre The Art Of Prolog */

evaluate_and_choose([Move|Moves], Position,D ,MaxMin, Record, Best) :-
	move(Move, Position, Position1), 
	minimax(D, Position1, MaxMin, MoveX, Value), 
	update(Move , Value , Record, Record1),
	evaluate_and_choose([], Position, D, MaxMin, Record, Record).

minimax (0, Position, MaxMin, Move, Value) :-
	value(Position, V),
	Value is  V*MaxMin.

minimax(D, Position, MaxMin, Move, Value) :-
	D>0, 
	findall(M, move(Position, M), Moves),
	D1 is D - 1, 
	MinMax is -MaxMin, 
	evaluate_and_choose(Moves, Position, D1, MinMax, (nil,-1000), (Move,Value)).

update(Move, Value, (Move1,Value1), (Move,Value)) :-
	Value <= Value1.	

update(Move, Value, (Move1,Value1), (Move,Value)) :-
	Value > Value1.	
