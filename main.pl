:- [regles].
:- [display].
:- [game_mecanics].
:- [ia_random].

jouer(Jeu) :- 
	initialiser(Plateau),
	diplay(Plateau),
	jouer(Jeu).
