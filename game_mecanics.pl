
%--------------------------------------------------
% pionsJoueur(+Couleur, +Plateau, -PionsJoueur)
% @Tanguy
%
% Récupère les pions (PionsJoueur) d'un joueur selon sa couleur (Couleur)
%
% ex:
% ? - pionsJoueur(w, [[[1,1],[-1,-1]],[[1,-1],[-1,1]]], pions).
% > pions = [[1,1],[-1,-1]]

pionsJoueur(w, [PionsJ1|[PionsJ2]], PionsJ1).
pionsJoueur(b, [PionsJ1|[PionsJ2]], PionsJ2).

%------------- fin pionsJoueur() ------------------


%--------------------------------------------------
% append(+Liste1,+Liste2,+ListeConcaténée)
% @Tanguy
%
% Ajoute Liste2 à la suite de Liste1
%
% ex:
% ? - append([a,b,c],[d],R).
% > R = [a,b,c,d]

append([ ], L1, L1).
append([A|L1],L2,[A|L3]) :- append(L1,L2,L3).

%------------- fin append() ------------------
									