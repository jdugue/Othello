
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

ajoutePion(Pion, Couleur, Plateau, NewPlateau) :-
	pionsJoueur(Couleur, Plateau, Pions), append(Pions, [Pion], NewPions), setPionsJoueur(Couleur, NewPions, Plateau, NewPlateau).

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

retirePion(Pion, Couleur, Plateau, NewPlateau) :-
	pionsJoueur(Couleur, Plateau, Pions), delete(Pions, Pion, NewPions), setPionsJoueur(Couleur, NewPions, Plateau, NewPlateau).

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

retourne(P,Plateau,NewPlateau) :- 
	joueurDuPion(P,Plateau,Couleur), 
	retirePion(P, Couleur,Plateau,Plateau2), 
	couleur_adversaire(Couleur, Adversaire), 
	ajoutePion(P, Adversaire, Plateau2, NewPlateau). 

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

%--------------------------------------------------
% cases_vides(+Positions,+Plateau,-Vides)
% @Tanguy
%
% Renvoie la liste des +Positions vides.
%
% ex:
% ? - cases_vides([[-2,1],[1,1],[-3,1],[3,3]],[[[1,1],[-1,-1],[2,1]],[[1,-1],[-1,1]]],X).
%
cases_vides([Pos],Plateau,[Pos]) :- est_vide(Pos,Plateau).
cases_vides([Pos],Plateau,[]).
cases_vides([T|Q],Plateau,[T|Vides]) :- est_vide(T,Plateau), cases_vides(Q,Plateau,Vides).
cases_vides([T|Q],Plateau,Vides) :- cases_vides(Q,Plateau,Vides).

%------------- fin cases_vides() ------------------

case_suivante(Case , Direction , Plateau , Couleur , []) :- joueurDuPion(Case , Plateau , Couleur ).
%case_suivante(Case , Direction , Plateau , Couleur , []) :- not(case_voisine(Case , Direction,X)).

case_suivante(Case , Direction , Plateau , Couleur , [Case| CaseSand]) :- 
	case_voisine(Case, Direction , CaseVoisine), 
	not(est_vide(CaseVoisine , Plateau)),
	case_suivante(CaseVoisine , Direction , Plateau , Couleur , CaseSand).

%---------------
% sandwich(+Case, +Direction , +Plateau , +Couleur , -Liste)
% Case : la case vide pour laquelle on veut checker
% Direction : la direction dans laquelle on check
% Plateau
% Couleur : la couleur qu'on veut jouer
% Liste : La liste des pions à retourner
% @Joss et Ianic
%
% Quand on se place a une position, renvoie la liste des cases occupées par des pions de la couleur adverse
% jusqu'a ce qu'on retrouve un pion de la couleur Couleur.

sandwich(Case , Direction , Plateau , Couleur , Q) :-
	case_suivante(Case , Direction , Plateau , Couleur , [T| Q]).						
