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


move(Move, Plateau, Couleur, NewPlateau) :-
	cases_a_retourner(Move,Plateau,Couleur,ARetourner),
	retourne_all(ARetourner,Plateau,PlateauTemp),
	ajoutePion(Move,Couleur,PlateauTemp,NewPlateau).
	
	
%Adaptation
choix_move_MM([Move|Moves], Couleur,Plateau,Profondeur ,MaxMin, Record, Choix) :-
	%notrace,
	move(Move, Plateau, Couleur, NewPlateau),
	%print(Move+Profondeur+Couleur),nl,
	minimax(Couleur,Profondeur, NewPlateau, MaxMin, Move, Value), 
	%print(Profondeur+Record),nl,
	update(Move , Value , Record, NewRecord),
	%trace,
	choix_move_MM(Moves,Couleur, Plateau, Profondeur, MaxMin, NewRecord, Choix),notrace.
choix_move_MM([], Couleur,Plateau,Profondeur ,MaxMin, (Test,Record),(_,Record)).
choix_move_MM([], Couleur,Plateau,3 ,MaxMin, (Test,Record),(Test,Record)).

minimax(_,0, _, MaxMin, Move, Value) :-
	valeur_case(Move,V),
	Value is  V*MaxMin.

minimax(Couleur,Profondeur, Plateau, MaxMin, Move, Value) :-
	Profondeur>0, 
	couleur_adversaire(Couleur,Adv),
	coups_legaux(Adv, Plateau, Coups),
	NewProfondeur is Profondeur - 1, 
	MinMax is -MaxMin, 
	choix_move_MM(Coups, Adv,Plateau, NewProfondeur, MinMax, (nil,-1000), (Move,Value)).

update(_, Value, (Move1,Value1), (Move1,Value1)) :-
	Value =< Value1.	

update(Move, Value, (_,Value1), (Move,Value)) :-
	Value > Value1.	
