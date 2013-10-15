:- [regles].
:- [color].
%--------------------------------------------------
%	@Mohammed
%	Affichage du plateau d'un jeu reçu
% 	Affiche l'ensemble du plateau en variant la colonne et ligne de -N à N
% 	PR correspond à la liste des pions rouges
% 	PV correspond à la liste des pions verts
%	ex : display([[[1,1],[2,1]],[[1,-1],[-4,4]]]).

	display([PV, PR]) :- print('   A B C D E F G H\n  '), display_elem(-4, 4, [PV, PR]).
	
%--------------------------------------------------


%--------------------------------------------------
%	@Mohammed
%	Retourne en arguments N1 et N la position des pions à afficher
%	param1 : numéro de la colonne 
%	param1 : numéro de la ligne
%	param3 : liste : [pions noirs, pions blancs] 

	display_elem(4, -4, [PV, PR]) :- !, display_cell([4, -4], [PV, PR]), print('  -4\n\n').

	% Si on est en fin de ligne
	display_elem(4, L, [PV, PR]) :-
		display_cell([4, L], [PV, PR]), 
		print('  '),
		print(L),
		print('\n'), 
		voisin_superieur(L1, L), !, % On passe à la ligne suivante
		print('  '),
		display_elem(-4, L1, [PV, PR]).
		
	% Sinon
	display_elem(C, L, [PV, PR]) :-
		display_cell([C, L], [PV, PR]), 
		voisin_superieur(C, C1), % On passe à la colonne suivante
		display_elem(C1, L, [PV, PR]).

%--------------------------------------------------



%--------------------------------------------------
%	@Mohammed
% 	Affichage d'une case
% 	Présentation
%		Case vide = .
	display_cell(C, [PV, PR]) :-
		print(' '),
		(member(C, PR) ->
			ansi_format([fg(red)], '●', []);
			(member(C, PV) ->
				ansi_format([fg(green)], '●', []);
				print('.')
			)
		).

%--------------------------------------------------
