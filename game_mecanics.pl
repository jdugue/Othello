
%--------------------------------------------------
% pionsJoueur(+Couleur, +Plateau, -PionsJoueur)
% @Tanguy
%
% Récupère les pions (PionsJoueur) d'un joueur selon sa couleur (Couleur)
%
% ex:
% ? - pionsJoueur(w, [[[1,1],[-1,-1]],[[1,-1],[-1,1]]], Pions).
% > Pions = [[1,1],[-1,-1]]

pionsJoueur(w, [PionsJ1|[_]], PionsJ1).
pionsJoueur(b, [_|[PionsJ2]], PionsJ2).

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


%--------------------------------------------------
% setPionsJoueur(+Couleur,+Pions,+Plateau,-NewPlateau)
% @Tanguy
%
% Remplace les pions d'un joueur par les Pions
%
% ex:
% ? - setPionsJoueur(w,[a,b,c],[[d,e,f],[g,h,i]], R).
% > R = [[a,b,c],[g,h,i]]

setPionsJoueur(w,Pions,[J1|[J2]],[Pions|[J2]]). 
setPionsJoueur(b,Pions,[J1|[J2]],[J1|[Pions]]). 

%------------- fin setPionsJoueur() ------------------


%--------------------------------------------------
% ajoutePion(+Pion,+Couleur,+Plateau,-NewPlateau)
% @Tanguy
%
% Ajoute Pion à la liste des pions du joueur selon sa couleur (Couleur)
%
% ex:
% ? - ajoutePion([2,1], w, [[[1,1],[-1,-1]],[[1,-1],[-1,1]]], Plateau).
% > Plateau = [[[1,1],[-1,-1],[2,1]],[[1,-1],[-1,1]]]

ajoutePion(Pion, Couleur, Plateau, NewPlateau) :- pionsJoueur(Couleur, Plateau, Pions), append(Pions, [Pion], NewPions), setPionsJoueur(Couleur, NewPions, Plateau, NewPlateau).

%------------- fin ajoutePion() ------------------


%--------------------------------------------------
% retirePion(+Pion,+Couleur,+Plateau,-NewPlateau)
% @Tanguy
%
% Retire Pion de la liste des pions du joueur selon sa couleur (Couleur)
%
% ex:
% ? - retirePion([2,1], w, [[[1,1],[-1,-1],[2,1]],[[1,-1],[-1,1]]], Plateau).
% > Plateau = [[[1,1],[-1,-1]],[[1,-1],[-1,1]]]

retirePion(Pion, Couleur, Plateau, NewPlateau) :- pionsJoueur(Couleur, Plateau, Pions), delete(Pions, Pion, NewPions), setPionsJoueur(Couleur, NewPions, Plateau, NewPlateau).

%------------- fin retirePion() ------------------


%--------------------------------------------------
% joueurDuPion(+Pion,+Plateau,-Couleur)
% @Tanguy
%
% Renvoi la couleur du joueur qui possede Pion
%
% ex:
% ? - joueurDuPion([1,1], [[[1,1],[-1,-1],[2,1]],[[1,-1],[-1,1]]], Couleur).
% > Couleur = w

joueurDuPion(Pion, [J1|[J2]], w) :- memberchk(Pion, J1).
joueurDuPion(Pion, [J1|[J2]], b) :- memberchk(Pion, J2).

%------------- fin joueurDuPion() ------------------


%--------------------------------------------------
% retourne(+PionARetourner,+Plateau,-NewPlateau)
% @Tanguy
%
% Le PionARetourner est enlevé de la liste du joueur à qui il appartient
% et est ajouté à la liste de l'autre joueur
%
% ex:
% ? - retourne([1,1], [[[1,1],[-1,-1],[2,1]],[[1,-1],[-1,1]]], Plateau).
%

retourne(P,Plateau,NewPlateau) :- joueurDuPion(P,Plateau,Couleur), retirePion(P, Couleur,Plateau,Plateau2), couleur_adversaire(Couleur, Adversaire), ajoutePion(P, Adversaire, Plateau2, NewPlateau). 

%------------- fin retourne() ------------------

%--------------------------------------------------
% est_vide(+Position,+Plateau)
% @Tanguy
%
% Regarde si la case Position est vide.
%
% ex:
% ? - est_vide([3,3],[[[1,1],[-1,-1],[2,1]],[[1,-1],[-1,1]]]).
% ? - est_vide([1,1],[[[1,1],[-1,-1],[2,1]],[[1,-1],[-1,1]]]).
%

est_vide(Position,[J1|[J2]]) :- not(memberchk(Position,J1)), not(memberchk(Position,J2)).

%------------- fin est_vide() ------------------
							
