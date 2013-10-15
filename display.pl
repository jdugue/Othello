%--------------------------------------------------
%	@Mohammed
%	Affichage du plateau d'un jeu reçu
% 	Affiche l'ensemble du plateau en variant la colonne et ligne de -N à N
% 	PN correspond à la liste des pions noirs
% 	PB correspond à la liste des pions blancs

	display(N, PN, PB) :- N1 is N*(-1), display_output(N1, N, [N, PN, PB]).

%--------------------------------------------------


%--------------------------------------------------
%	@Mohammed
%	Retourne en arguments N1 et N la position des pions à afficher

	display_output(N, N1, [N, PN, PB]) :- 
		N1 is N*(-1),
		!,
		display_cell([N, N1], PN, PB),
		write('\n\n').
	
	% Réaliser un retour à la ligne à la fin de la ligne
	display_output(N, L, [N, PN, PB]) :- 
		display_cell([N, L], PN, PB),
		write('\n'),
		voisin_superieur(N, L1, L), !,
		C1 is N*(-1),
		display_output(C1, L1, [N, PN, PB]).
	
	display_output(C, L, [N, PN, PB]) :- 
		display_cell([C, L], PN, PB),
		voisin_superieur(N, C, C1),
		display_output(C1, L, [N, PN, PB]).

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
