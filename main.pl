:- [regles].
:- [display].
:- [game_mecanics].
:- [ia_random].

playAll(Jeu) :- 
	init_plateau(Plateau),
	display(Plateau),
	jouer(Plateau,r).

jouer(Plateau,Couleur) :- 
jouer(Plateau,Couleur) :-
	coups_legaux(Couleur, Plateau, Coups),
	choix_move(Coups,Choix),
	cases_a_retourner(Choix,Plateau,Couleur,ARetourner),
	retourne_all(ARetourner,Plateau,PlateauTemp),
	ajoutePion(Choix,Couleur,PlateauTemp,NewPlateau),
	display(NewPlateau),
	couleur_adversaire(Couleur,Adv),
	jouer(NewPlateau,Adv). %On ajoute le pion que l'on a décidé de jouer
	
