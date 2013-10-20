:- [regles].
:- [display].
:- [game_mecanics].
:- [ia_random].

jouer(Jeu) :- 
	init_plateau(Plateau),
	display(Plateau),
	jouer(Jeu).

jouer(Plateau,Couleur) :-
	coups_legaux(Couleur, Plateau, Coups),
	choix_move(Coups,Choix).
	%sandwich(),
	%retourne(),
	%ajoutePion(). %On ajoute le pion que l'on a décidé de jouer
	
