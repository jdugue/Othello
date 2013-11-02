:- [regles].
:- [display].
:- [game_mecanics].
:- [ia_position].

playAll(Jeu) :- 
	init_plateau(Plateau),
	display(Plateau),
	jouer(Plateau,g).


%Fin de jeu, plus aucun coup légal pour les joueurs
jouer(Plateau,Couleur) :-
	coups_legaux(Couleur, Plateau, Coups),
	length(Coups,L),
	L == 0,
	couleur_adversaire(Couleur,Adv),
	coups_legaux(Adv, Plateau, CoupsAdv),
	length(CoupsAdv,L2),
	L2 == 0,
	affichage_resultat(Plateau).
	
%Pas fin de jeu, mais joueur bloqué
jouer(Plateau,Couleur) :-
	coups_legaux(Couleur, Plateau, Coups),
	length(Coups,L),
	L == 0,
	couleur_adversaire(Couleur,Adv),
	jouer(Plateau,Adv).

%Déroulement normal
jouer(Plateau,Couleur) :-
	coups_legaux(Couleur, Plateau, Coups),
	choix_move(Coups,Plateau,Couleur,Choix),
	cases_a_retourner(Choix,Plateau,Couleur,ARetourner),
	retourne_all(ARetourner,Plateau,PlateauTemp),
	ajoutePion(Choix,Couleur,PlateauTemp,NewPlateau),
	display(NewPlateau),
	%sleep(5),
	couleur_adversaire(Couleur,Adv),
	jouer(NewPlateau,Adv). %On ajoute le pion que l'on a décidé de jouer
	
	
affichage_resultat([J1|[J2]]) :-
	length(J1,L1),
	length(J2,L2),
	write('Green='+L1),nl,
	write('Red='+L2),nl,
	vainqueur(L1,L2).
	
vainqueur(L1,L2) :-
	L1<L2,
	write('Red gagne !').
	
vainqueur(L1,L2) :-
	L1>L2,
	write('Green gagne !').
	
vainqueur(L1,L1) :-
	write('Egalité !').	
	
