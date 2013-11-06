/* Algo minimax_MR d'apres le livre The Art Of Prolog */
/*
evaluate_and_choose([Move|Moves], Position,D ,MaxMin, Record, Best) :-
	move(Move, Position, Position1), 
	minimax_MR(D, Position1, MaxMin, MoveX, Value), 
	update(Move , Value , Record, Record1),
	evaluate_and_choose(Moves, Position, D, MaxMin, Record1, Best).
	
evaluate_and_choose([], Position, D, MaxMin, Record, Record).

minimax_MR (0, Position, MaxMin, Move, Value) :-
	value(Position, V),
	Value is  V*MaxMin.

minimax_MR(D, Position, MaxMin, Move, Value) :-
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
choix_move_MM_MR([], _,_, 2, _, (MRecord,VRecord), (MRecord,VRecord)).
choix_move_MM_MR([], _,_, _, _, (_,VRecord), (_,VRecord)).
choix_move_MM_MR([Move|[]], _,_,_ ,_, _, (Move,_)).
choix_move_MM_MR([Move|Moves], Couleur,Plateau,Profondeur ,MaxMin, Record, Choix) :-
	cases_a_retourner(Move,Plateau,Couleur,ARetourner),
	retourne_all(ARetourner,Plateau,PlateauTemp),
	ajoutePion(Move,Couleur,PlateauTemp,NewPlateau),
	minimax_MR(Couleur,Profondeur,Plateau, NewPlateau, MaxMin, Move, Value), 
	update(Move , Value , Record, NewRecord),
	choix_move_MM_MR(Moves,Couleur, Plateau, Profondeur, MaxMin, NewRecord, Choix).

minimax_MR(Couleur,0, Old,Plateau, MaxMin, Move, Value) :-
	cases_a_retourner(Move,Old,Couleur,RetourneCoup),
	length(RetourneCoup,V),
	print('mmMR'),nl,
	Value is  V*MaxMin.

minimax_MR(Couleur,Profondeur, Old,Plateau, MaxMin, Move, Value) :-
	Profondeur>0, 
	couleur_adversaire(Couleur,Adv),
	coups_legaux(Adv, Plateau, Coups),
	NewProfondeur is Profondeur - 1, 
	MinMax is -MaxMin, 
	choix_move_MM_MR(Coups, Adv,Plateau, NewProfondeur, MinMax, (nil,-1000), (Move,Value)).

update(_, Value, (Move1,Value1), (Move1,Value1)) :-
	Value =< Value1.	

update(Move, Value, (_,Value1), (Move,Value)) :-
	Value > Value1.	
