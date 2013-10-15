:- [regles].
:- [display].
:- [game_mecanics].

jouer(Jeu) :- 
	initialiser(Plateau),
	diplay(Plateau),
	jouer().
