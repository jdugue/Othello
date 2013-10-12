
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
									