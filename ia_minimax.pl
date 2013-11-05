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
/*
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
*/

/* Algo minimax d'apres le livre The Art Of Prolog */
/*
evaluate_and_choose([Move|Moves], Position,D ,MaxMin, Record, Best) :-
	move(Move, Position, Position1), 
	minimax(D, Position1, MaxMin, MoveX, Value), 
	update(Move , Value , Record, Record1),
	evaluate_and_choose(Moves, Position, D, MaxMin, Record1, Best).
	
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

update(Move, Value, (Move1,Value1), (Move,Value1)) :-
	Value <= Value1.	

update(Move, Value, (Move1,Value1), (Move,Value)) :-
	Value > Value1.	
*/	
	
%Adaptation
choix_move_MM([], _,_, 3, _, (MRecord,VRecord), (MRecord,VRecord)).
choix_move_MM([], _,_, _, _, (_,VRecord), (_,VRecord)).
choix_move_MM([Move|[]], _,_,_ ,_, _, (Move,_)).
choix_move_MM([Move|Moves], Couleur,Plateau,Profondeur ,MaxMin, Record, Choix) :-
	%notrace,
	%print(Move + Profondeur),nl,
	cases_a_retourner(Move,Plateau,Couleur,ARetourner),
	retourne_all(ARetourner,Plateau,PlateauTemp),
	ajoutePion(Move,Couleur,PlateauTemp,NewPlateau),
	%display(NewPlateau),
	minimax(Couleur,Profondeur, NewPlateau, MaxMin, Move, Value), 
	%print('value'+Value),nl,
	update(Move , Value , Record, NewRecord),
	%print(Profondeur+'nwRec' + NewRecord),nl,
	%trace,
	choix_move_MM(Moves,Couleur, Plateau, Profondeur, MaxMin, NewRecord, Choix).
	%notrace.

minimax(_,0, _, MaxMin, Move, Value) :-
	valeur_case(Move,V),
	Value is  V*MaxMin.

minimax(Couleur,Profondeur, Plateau, MaxMin, Move, Value) :-
	Profondeur>0, 
	couleur_adversaire(Couleur,Adv),
	coups_legaux(Adv, Plateau, Coups),
	%print(Coups),nl,
	NewProfondeur is Profondeur - 1, 
	MinMax is -MaxMin, 
	choix_move_MM(Coups, Adv,Plateau, NewProfondeur, MinMax, (nil,-1000), (Move,Value)).

update(_, Value, (Move1,Value1), (Move1,Value1)) :-
	Value =< Value1.	

update(Move, Value, (_,Value1), (Move,Value)) :-
	Value > Value1.	
