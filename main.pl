:- [regles].
:- [display].
:- [game_mecanics].
:- [ia_random].
:- [ia_position].
:- [ia_max_retour].

playAll(Joueurs) :- 
	init_plateau(Plateau),
	display(Plateau),
	jouer(Plateau,g,Joueurs).

jouer([[]|J2],_,_) :-
	affichage_resultat([[]|J2]).
	
jouer([J1|[]],_,_) :-
	affichage_resultat([J1|[]]).

%Fin de jeu, plus aucun coup légal pour les joueurs
jouer(Plateau,Couleur,_) :-
	coups_legaux(Couleur, Plateau, Coups),
	length(Coups,L),
	L == 0,
	couleur_adversaire(Couleur,Adv),
	coups_legaux(Adv, Plateau, CoupsAdv),
	length(CoupsAdv,L2),
	L2 == 0,
	affichage_resultat(Plateau).
	
%Pas fin de jeu, mais joueur bloqué
jouer(Plateau,Couleur,_) :-
	coups_legaux(Couleur, Plateau, Coups),
	length(Coups,L),
	L == 0,
	couleur_adversaire(Couleur,Adv),
	jouer(Plateau,Adv,_).

%Déroulement normal
jouer(Plateau,Couleur,Joueurs) :-
	coups_legaux(Couleur, Plateau, Coups),
	trouver_bon_choix(Couleur,Joueurs,Plateau,Coups,Choix),
	cases_a_retourner(Choix,Plateau,Couleur,ARetourner),
	retourne_all(ARetourner,Plateau,PlateauTemp),
	ajoutePion(Choix,Couleur,PlateauTemp,NewPlateau),
	display(NewPlateau),
	%sleep(5),
	couleur_adversaire(Couleur,Adv),
	jouer(NewPlateau,Adv,Joueurs). %On ajoute le pion que l'on a décidé de jouer
	
	
%Permet de trouver quelle stratégie jouer	
trouver_bon_choix(g,[rand,_],Plateau,Coups,Choix) :-
	choix_move_RAND(Coups,Plateau,g,Choix).
		
trouver_bon_choix(r,[_,rand],Plateau,Coups,Choix) :-
	choix_move_RAND(Coups,Plateau,r,Choix).
	
trouver_bon_choix(g,[pos,_],Plateau,Coups,Choix) :-
	choix_move_POS(Coups,Plateau,g,Choix).
	
trouver_bon_choix(r,[_,pos],Plateau,Coups,Choix) :-
	choix_move_POS(Coups,Plateau,r,Choix).	
	
trouver_bon_choix(g,[mr,_],Plateau,Coups,Choix) :-
	choix_move_MR(Coups,Plateau,g,Choix).	
	
trouver_bon_choix(r,[_,mr],Plateau,Coups,Choix) :-
	choix_move_MR(Coups,Plateau,r,Choix).	
	
	
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
	
