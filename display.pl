:- [regles].
:- [color].
%--------------------------------------------------
%	@Mohammed
%	Affichage du plateau d'un jeu reçu
% 	Affiche l'ensemble du plateau en variant la colonne et ligne de -N à N
% 	PN correspond à la liste des pions noirs
% 	PB correspond à la liste des pions blancs
%	ex : display([[[1,1],[2,1]],[[1,-1],[-4,4]]]).

	display([PB, PN]) :- print('   A B C D E F G H\n  '), display_elem(-4, 4, [PB, PN]).
	
%--------------------------------------------------


%--------------------------------------------------
%	@Mohammed
%	Retourne en arguments N1 et N la position des pions à afficher
%	param1 : numéro de la colonne 
%	param1 : numéro de la ligne
%	param3 : liste : [pions noirs, pions blancs] 

	display_elem(4, -4, [PB, PN]) :- !, display_cell([4, -4], [PB, PN]), print('  -4\n\n').

	% Si on est en fin de ligne
	display_elem(4, L, [PB, PN]) :-
		display_cell([4, L], [PB, PN]), 
		print('  '),
		print(L),
		print('\n'), 
		voisin_superieur(L1, L), !, % On passe à la ligne suivante
		print('  '),
		display_elem(-4, L1, [PB, PN]).
		
	% Sinon
	display_elem(C, L, [PB, PN]) :-
		display_cell([C, L], [PB, PN]), 
		voisin_superieur(C, C1), % On passe à la colonne suivante
		display_elem(C1, L, [PB, PN]).

%--------------------------------------------------



%--------------------------------------------------
%	@Mohammed
% 	Affichage d'une case
% 	Présentation
%		Pion noir = x
%		Pion blanc = o
%		Case vide = .
	display_cell(C, [PB, PN]) :-
		print(' '),
		(member(C, PN) ->
			ansi_format([fg(red)], '●', []);
			(member(C, PB) ->
				ansi_format([fg(green)], '●', []);
				print('.')
			)
		).

%--------------------------------------------------
