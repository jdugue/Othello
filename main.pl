:- [regles].
:- [display].
:- [game_mecanics].
:- [ia_random].

jouer(Jeu) :- 
	init_plateau(Plateau),
	display(Plateau),
	jouer(Jeu).
