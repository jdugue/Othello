:- [regles].

%--------------------------------------------------
%	@Mohammed
%	Affichage du plateau d'un jeu reçu
% 	Affiche l'ensemble du plateau en variant la colonne et ligne de -N à N
% 	PN correspond à la liste des pions noirs
% 	PB correspond à la liste des pions blancs
%	ex : display([[[1,1],[2,1]],[[1,-1],[-4,4]]]).

	display([PN, PB]) :- write('   A B C D E F G H\n1  '), display_elem(-4, 4, [PN, PB]).
	
%--------------------------------------------------


%--------------------------------------------------
%	@Mohammed
%	Retourne en arguments N1 et N la position des pions à afficher
%	param1 : numéro de la colonne 
%	param1 : numéro de la ligne
%	param3 : liste : [pions noirs, pions blancs] 

	display_elem(4, -4, [PN, PB]) :- !, display_cell([4, -4], [PN, PB]), write('\n\n').

	% Si on est en fin de ligne
	display_elem(4, L, [PN, PB]) :-
		display_cell([4, L], [PN, PB]), 
		write('\n'), 
		voisin_superieur(L1, L), !, % On passe à la ligne suivante
		write('  '),
		display_elem(-4, L1, [PN, PB]).
		
	% Sinon
	display_elem(C, L, [PN, PB]) :-
		display_cell([C, L], [PN, PB]), 
		voisin_superieur(C, C1), % On passe à la colonne suivante
		display_elem(C1, L, [PN, PB]).

%--------------------------------------------------



%--------------------------------------------------
%	@Mohammed
% 	Affichage d'une case
% 	Présentation
%		Pion noir = x
%		Pion blanc = o
%		Case vide = .
	display_cell(C, [PN, PB]) :-
		write(' '),
		(member(C, PN) ->
			write('x');
			(member(C, PB) ->
				write('o');
				write('.')
			)
		).

%--------------------------------------------------
