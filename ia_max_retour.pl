:-[game_mecanics].

choix_best(Case,Plateau,Couleur,ActuelBest,NewBest) :-
	cases_a_retourner(Case,Plateau,Couleur,RetourneCoup),
	length(RetourneCoup,N1), 
	cases_a_retourner(ActuelBest,Plateau,Couleur,RetourneBest),
	length(RetourneBest,N2),
	N1<N2,
	NewBest = ActuelBest.	
choix_best(Case,Plateau,Couleur,ActuelBest,NewBest) :-
	cases_a_retourner(Case,Plateau,Couleur,RetourneCoup),
	length(RetourneCoup,N1), 
	cases_a_retourner(ActuelBest,Plateau,Couleur,RetourneBest),
	length(RetourneBest,N2),
	N1>N2,
	NewBest = Case.	
choix_best(Case,Plateau,Couleur,ActuelBest,NewBest) :-
	cases_a_retourner(Case,Plateau,Couleur,RetourneCoup),
	length(RetourneCoup,N1), 
	cases_a_retourner(ActuelBest,Plateau,Couleur,RetourneBest),
	length(RetourneBest,N2),
	N1==N2,
	NewBest = ActuelBest.

calcul([T|[]],Plateau,Couleur,Best,Choix) :- choix_best(T,Plateau,Couleur,Best,Choix).
calcul([T|Q],Plateau,Couleur,Best,Choix):-
	choix_best(T,Plateau,Couleur,Best,NewBest),
	calcul(Q,Plateau,Couleur,NewBest,Choix).
	
choix_move_MR([T|Q],Plateau,Couleur,Choix):-
	Best = T, %Initialise
	calcul(Q,Plateau,Couleur,Best,Choix).



