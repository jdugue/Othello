%--------------------------------------------------
%	@Mohammed
%	Affichage du plateau d'un jeu reçu
% 	Affiche l'ensemble du plateau en variant la colonne et ligne de -N à N
% 	PN correspond à la liste des pions noirs
% 	PB correspond à la liste des pions blancs

	display(P) :- write('	A B C D E F G H\n1	'), display_elem(-4, 4, P).
	
%--------------------------------------------------


%--------------------------------------------------
%	@Mohammed
%	Retourne en arguments N1 et N la position des pions à afficher

	display_elem(4, -4, P) :- !, display_cell([4, -4], P), write('\n\n').

	% Si on est en fin de ligne
	display_elem(4, L, P) :-
		display_cell([4, L], P), 
		write('\n'), 
		voisin_superieur(L1, L), !, % Si on est est pas à la dernière ligne
		write('	'),
		display_elem(-4, L1, P).
		
	% Sinon
	display_elem(C, L, P) :-
		display_cell([C, L], P), 
		voisin_superieur(C, C1), 
		display_elem(C1, L, P).

%--------------------------------------------------



%--------------------------------------------------
%	@Mohammed
% 	Affichage d'une case
% 	Présentation
%		Pion noir = x
%		Pion blanc = o
%		Case vide = .
	display_cell(C, PN, PB) :-
		write(' '),
		(member(C, PN) ->
			write('x');
			(member(C, PB) ->
				write('o');
				write('.')
			)
		).

%--------------------------------------------------
