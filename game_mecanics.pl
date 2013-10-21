
%--------------------------------------------------
% pionsJoueur(+Couleur, +Plateau, -PionsJoueur)
% @Tanguy
%
% Récupère les pions (PionsJoueur) d'un joueur selon sa couleur (Couleur)
%
% ex:
% ? - pionsJoueur(w, [[[1,1],[-1,-1]],[[1,-1],[-1,1]]], Pions).
% > Pions = [[1,1],[-1,-1]]

pionsJoueur(g, [PionsJ1|[_]], PionsJ1).
pionsJoueur(r, [_|[PionsJ2]], PionsJ2).

%------------- fin pionsJoueur() ------------------


%--------------------------------------------------
% append(+Liste1,+Liste2,+ListeConcaténée)
% @Tanguy
%
% Ajoute Liste2 à la suite de Liste1
% !! la suppression ne marche que si Liste2 est en bout de chaine de Liste 1
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

setPionsJoueur(g,Pions,[_|[J2]],[Pions|[J2]]). 
setPionsJoueur(r,Pions,[J1|[_]],[J1|[Pions]]). 

%------------- fin setPionsJoueur() ------------------


%--------------------------------------------------
% ajoutePion(+Pion,+Couleur,+Plateau,-NewPlateau)
% @Tanguy
%
% Ajoute +Pion à la liste des pions du joueur selon sa couleur (+Couleur)
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
% Retire Pion de la liste des pions du joueur selon sa couleur (+Couleur)
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

joueurDuPion(Pion, [J1|[_]], g) :- memberchk(Pion, J1).
joueurDuPion(Pion, [_|[J2]], r) :- memberchk(Pion, J2).

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
% retourne_all(+ListeARetourner,+Plateau,-NewPlateau)
% @Mael
%
% Chaque élément de ListeARetourner est retourné, on renvoie le nouveau plateau ainsi formé
%
% ex:
% ? - retourne_all([[1,1],[-1,-1]], [[[1,1],[-1,-1],[2,1]],[[1,-1],[-1,1]]], Plateau).
%
retourne_all([],_,NewPlateau).
retourne_all([T|Q], Plateau ,NewPlateau) :-
	retourne(T,Plateau ,PlateauTemp),
	retourne_all(Q,PlateauTemp ,NewPlateau).
	
%------------- fin retourne_all() -------------------

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

est_vide(Position,[J1|[J2]]) :- not(member(Position,J1)), not(member(Position,J2)).

%------------- fin est_vide() ------------------

%--------------------------------------------------
% all_cases_vides(+Positions,+Plateau,-Vides)
% @Tanguy
%
% Renvoie la liste des +Positions qui sont vides dans -Vides.
%
% ex:
% ? - cases_vides([[-2,1],[1,1],[-3,1],[3,3]],[[[1,1],[-1,-1],[2,1]],[[1,-1],[-1,1]]],X).
%
/**
cases_vides([Pos],Plateau,[Pos]) :- est_vide(Pos,Plateau).
cases_vides([_],_,[]).
cases_vides([T|Q],Plateau,[T|Vides]) :- est_vide(T,Plateau), cases_vides(Q,Plateau,Vides).
cases_vides([_|Q],Plateau,Vides) :- cases_vides(Q,Plateau,Vides).
**/

cases_vides(ListeCases, Plateau, Case) :-
	member(Case, ListeCases),
	est_vide(Case, Plateau).

all_cases_vides(ListeCases, Plateau, ListeCasesVides) :-
	findall(Case, cases_vides(ListeCases, Plateau, Case), ListeCasesVides).
	

%------------- fin cases_vides() ------------------

%--------------------------------------------------
% depile(+ListeDeListe,-Liste)
% @Tanguy
%
% Prend une +ListeDeListe de profondeur N et retourne une -Liste de profondeur N-1
%
% ex:
% ? - depile([[a,b],[c,d],[d,e]],R).
% R = [d, e, c, d, a, b]

depile([T], T).
depile([T|Q], R) :- depile(Q, R2), append(R2, T, R).

%------------- fin depile() ------------------

valide_case_suivante(Case , Direction , Plateau , Couleur) :-
	case_voisine(Case, Direction , CaseVoisine),
	not(est_vide(CaseVoisine , Plateau)),
	couleur_adversaire(Couleur,CouleurAdv),
	joueurDuPion(CaseVoisine , Plateau , CouleurAdv ).
	
%---------------------------------------
% check_sandwich(+Case, +Direction , +Plateau , +Couleur)
% Case : la case vide pour laquelle on veut checker
% Direction : la direction dans laquelle on check
% Plateau
% Couleur : la couleur qu'on veut jouer
% Liste : La liste des pions à retourner
% @Tanguy
%
% Renvoit true si un sandwich est possible pour une +Case donnée.
% 
check_sandwich(Case, Direction, Plateau, Couleur) :-
	valide_case_suivante(Case, Direction, Plateau, Couleur),
	case_voisine(Case, Direction, Voisine),
	calcul_check_sandwich(Voisine, Direction, Plateau, Couleur).

calcul_check_sandwich(Case, Direction, Plateau, Couleur) :-
	case_voisine(Case, Direction, Voisine),
	joueurDuPion(Voisine, Plateau, Couleur).
	
calcul_check_sandwich(Case, Direction, Plateau, Couleur) :-
	valide_case_suivante(Case, Direction, Plateau, Couleur),
	case_voisine(Case, Direction, Voisine),
	calcul_check_sandwich(Voisine, Direction, Plateau, Couleur).
	
%--------- fin check_sandwich() -------
	
	
%---------------------------------------
% sandwich(+Case, +Direction , +Plateau , +Couleur , -Liste)
% @Tanguy & Mael
%
% Renvoie les  cases prises en sandwich depuis +Case dans
% dans une +Direction
% 

sandwich(Case, Direction, Plateau, Couleur, CasesSandwich) :-
	temp_sandwich(Case, Direction, Plateau, Couleur, [_|CasesSandwich]).

temp_sandwich(Case, Direction, Plateau, Couleur, [Case]) :- 
	case_voisine(Case, Direction, Voisine),
	joueurDuPion(Voisine, Plateau, Couleur).

temp_sandwich(Case, Direction, Plateau, Couleur, [Case| CaseSand]) :- 
	case_voisine(Case, Direction, Voisine), 
	not(est_vide(Voisine, Plateau)),
	temp_sandwich(Voisine, Direction, Plateau, Couleur, CaseSand).
	
%--------- fin sandwich() ---------------
	
	
%---------------------------------------
% cases_a_retourner(+Case, +Plateau , +Couleur , -Liste)
% @Tanguy 
%
% Renvoie les cases à retourner (-Liste) si on joue en +Case
% 

cases_a_retourner(Case,Plateau,Couleur,ARetourner) :- 
	findall(CasesRetourner,sandwich(Case , _ , Plateau , Couleur , CasesRetourner),ARetournerTemp),
	depile(ARetournerTemp, ARetourner).
	
%--------- fin sandwich() ---------------

	

	

