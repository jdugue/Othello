/* Algo minimax_POS d'apres le livre The Art Of Prolog */
/*
evaluate_and_choose([Move|Moves], Position,D ,MaxMin, Record, Best) :-
	move(Move, Position, Position1), 
	minimax_POS(D, Position1, MaxMin, MoveX, Value), 
	update(Move , Value , Record, Record1),
	evaluate_and_choose(Moves, Position, D, MaxMin, Record1, Best).
	
evaluate_and_choose([], Position, D, MaxMin, Record, Record).

minimax_POS (0, Position, MaxMin, Move, Value) :-
	value(Position, V),
	Value is  V*MaxMin.

minimax_POS(D, Position, MaxMin, Move, Value) :-
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
choix_move_MM_POS([], _,_, 2, _, (MRecord,VRecord), (MRecord,VRecord)).
choix_move_MM_POS([], _,_, _, _, (_,VRecord), (_,VRecord)).
choix_move_MM_POS([Move|[]], _,_,_ ,_, _, (Move,_)).
choix_move_MM_POS([Move|Moves], Couleur,Plateau,Profondeur ,MaxMin, Record, Choix) :-
	cases_a_retourner(Move,Plateau,Couleur,ARetourner),
	retourne_all(ARetourner,Plateau,PlateauTemp),
	ajoutePion(Move,Couleur,PlateauTemp,NewPlateau),
	minimax_POS(Couleur,Profondeur, NewPlateau, MaxMin, Move, Value), 
	update(Move , Value , Record, NewRecord),
	choix_move_MM_POS(Moves,Couleur, Plateau, Profondeur, MaxMin, NewRecord, Choix).

minimax_POS(Couleur,0, NewPlateau, MaxMin, Move, Value) :-
	valeur_case(Move,V),
	print('mmPOS'),nl,
	Value is  V*MaxMin.

minimax_POS(Couleur,Profondeur, Plateau, MaxMin, Move, Value) :-
	Profondeur>0, 
	couleur_adversaire(Couleur,Adv),
	coups_legaux(Adv, Plateau, Coups),
	NewProfondeur is Profondeur - 1, 
	MinMax is -MaxMin, 
	choix_move_MM_POS(Coups, Adv,Plateau, NewProfondeur, MinMax, (nil,-1000), (Move,Value)).

update(_, Value, (Move1,Value1), (Move1,Value1)) :-
	Value =< Value1.	

update(Move, Value, (_,Value1), (Move,Value)) :-
	Value > Value1.	
