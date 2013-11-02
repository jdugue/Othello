/***************************************************************************************************************************************
	Initialise un plateau de jeu.
	Structure d'une case: [Colonne, Ligne]
	Par exemple, la case [-4, 4] est la case en haut à gauche du plateau et [4, 4] celle en haut à droite.
***************************************************************************************************************************************/
init_plateau([[[1, 1], [-1, -1]], [[-1, 1], [1, -1]]]).
faux_plateau([[[1, 1], [1, -1]], [[1, 2]]]).


%--------------------------------------------------
% voisin_superieur(+X, -Y) OU voisin_superieur(-X, +Y)
% @Joss
%
% Renvoie la valeur de l'indice superieur(resp. inferieur) ˆ celui pass en argument.
%
% ex:
% ? - voisin_superieur(1, Y).
% > Y = 2

voisin_superieur(-4, -3).
voisin_superieur(-3, -2).
voisin_superieur(-2, -1).
voisin_superieur(-1, 1).
voisin_superieur(1, 2).
voisin_superieur(2, 3).
voisin_superieur(3, 4).
	
%----------- fin voisin_superieur() ---------------


%--------------------------------------------------
% case_voisine(+Case, +Direction, -CaseVoisine) OU case_voisine(+Case, -Direction, -CaseVoisine)
% @Joss
%
% Renvoie la case voisine ˆ Case suivant Direction. La Direction est un des points cardinaux (N, N-E, E, S-E, S, S-O, O, N-O).
% OU
% Renvoie toutes les cases voisines de Case.
%
% ex:
% ? - case_voisine([1,1], sud, Voisine).
% > Voisine = [1,-1]
% ? - case_voisine([1,1], D, C).
% > D = est,		D = sudEst,		D = sud,		D = sudOuest,	D = ouest,		D = nordOuest,	D = nord,		D = nordEst,
%	C = [2, 1] ;	C = [2, -1] ;	C = [1, -1] ;	C = [-1, -1] ;	C = [-1, 1] ;	C = [-1, 2] ;	C = [1, 2] ;	C = [2, 2]

case_voisine([Xd, Yd], est, [Xa, Yd]) :- voisin_superieur(Xd, Xa).
case_voisine([Xd, Yd], sudEst, [Xa, Ya]) :- voisin_superieur(Xd, Xa), voisin_superieur(Ya, Yd).
case_voisine([Xd, Yd], sud, [Xd, Ya]) :- voisin_superieur(Ya, Yd).
case_voisine([Xd, Yd], sudOuest, [Xa, Ya]) :- voisin_superieur(Xa, Xd), voisin_superieur(Ya, Yd).
case_voisine([Xd, Yd], ouest, [Xa, Yd]) :- voisin_superieur(Xa, Xd).
case_voisine([Xd, Yd], nordOuest, [Xa, Ya]) :- voisin_superieur(Xa, Xd), voisin_superieur(Yd, Ya).
case_voisine([Xd, Yd], nord, [Xd, Ya]) :- voisin_superieur(Yd, Ya).
case_voisine([Xd, Yd], nordEst, [Xa, Ya]) :- voisin_superieur(Xd, Xa), voisin_superieur(Yd, Ya).

%------------- fin case_voisine() -----------------



%--------------------------------------------------
% cases_voisines_pos(+Case, -Liste)
% @Joss_et_Ianic
%
% Retourne toutes les cases adjacentes ˆ Case.
%
% ex:
% ? - cases_voisines_pos([1,1], Liste).
% > Liste = [[2, 1], [2, -1], [1, -1], [-1, -1], [-1, 1], [-1, 2], [1, 2], [2, 2]]

cases_voisines_pos(Case, Liste) :-
	findall(Voisin, case_voisine(Case, _, Voisin), Liste).
	
%----------- fin cases_voisines_pos() -------------


%--------------------------------------------------	
% calcul_cases_voisines(+Cases, -CasesVoisines)
% @Tanguy_et_Thomas
%
% Retourne la liste de toutes les cases adjacentes aux Cases.
%
% ex:
% ? - calcul_cases_voisines([[1,1],[-1,-1]],CasesVoisines).
% > CasesVoisines = [[2, 1], [2, -1], [1, -1], [-1, -1], [-1, 1], [-1, 2], [1, 2], [2, 2], [1, -1], [1, -2], [-1, -2], [-2, -2], [-2, -1], [-2, 1], [-1, 1], [1, 1]] 

calcul_cases_voisines([Pos], CasesVoisines) :- cases_voisines_pos(Pos, CasesVoisines).
calcul_cases_voisines([T|Q], CasesVoisines) :-
	calcul_cases_voisines(Q, OldVoisines), cases_voisines_pos(T, NewVoisines), append(NewVoisines, OldVoisines, CasesVoisines).

%---------- fin calcul_cases_voisines() -----------
	
	
%--------------------------------------------------
% cases_voisines_joueur(+Couleur, +Plateau, -Cases)
% @Tanguy_et_Thomas
%
% Retourne toutes les cases voisines aux pions du joueur Couleur, sans 
% doublons.
%
% ex:
% ? - cases_voisines_joueur(b, [[[1,1],[-1,-1]],[[1,-1],[-1,1]]], Cases).
% > Cases = [[-2, -1], [-2, 1], [-2, 2], [-1, -2], [-1, -1], [-1, 1], [-1, 2], [1, -2], [1, -1], [1, 1], [1, 2], [2, -2], [2, -1], [2, 1]] 

cases_voisines_joueur(Couleur, Plateau, Cases) :-
	pionsJoueur(Couleur, Plateau, Pions), calcul_cases_voisines(Pions, TempCases), sort(TempCases, Cases).

%---------- fin cases_voisines_joueur() -----------


%--------------------------------------------------
% est_vide(+Position,+Plateau)
% @Tanguy_et_Thomas
%
% Regarde si la case Position est vide.
%
% ex:
% ? - est_vide([3,3],[[[1,1],[-1,-1]],[[1,-1],[-1,1]]]).
% > Yes
% ? - est_vide([1,1],[[[1,1],[-1,-1]],[[1,-1],[-1,1]]]).
% > No

est_vide(Position,[J1|[J2]]) :- not(memberchk(Position,J1)), not(memberchk(Position,J2)).

%------------- fin est_vide() ---------------------


%--------------------------------------------------
% calcul_cases_vides(+Positions,+Plateau,-Vides)
% @Tanguy_et_Thomas
%
% Renvoie la liste des +Positions vides.
%
% ex:
% ? - calcul_cases_vides([[-2,1],[1,1],[-3,1],[3,3]],[[[1,1],[-1,-1]],[[1,-1],[-1,1]]],X).
% > X = [[-2, 1], [-3, 1], [3, 3]]

calcul_cases_vides([Pos],Plateau,[Pos]) :- est_vide(Pos,Plateau).
calcul_cases_vides([Pos],Plateau,[]) :- not(est_vide(Pos, Plateau)).

calcul_cases_vides([T|Q],Plateau,[T|Vides]) :- 
	est_vide(T,Plateau),
	calcul_cases_vides(Q,Plateau,Vides).
	
calcul_cases_vides([T|Q],Plateau,Vides) :-
	not(est_vide(T, Plateau)), 
	calcul_cases_vides(Q,Plateau,Vides).

%------------- fin calcul_cases_vides() -----------


%--------------------------------------------------
% cases_vides(+Positions,+Plateau,-Vides)
% @Tanguy_et_Thomas
%
% Renvoie le premier element de calcul_cases_vides()
%
% ex:
% ? - cases_vides([[-2,1],[1,1],[-3,1],[3,3]],[[[1,1],[-1,-1],[2,1]],[[1,-1],[-1,1]]],X).
% > X = [[-2, 1], [-3, 1], [3, 3]]

cases_vides(Positions,Plateau,ListeCases) :- findall(Vides, calcul_cases_vides(Positions,Plateau,Vides), [ListeCases|_]).

%------------- fin cases_vides() ------------------


%--------------------------------------------------
% calcul_cases_qui_sandwich(+Positions, +Couleur, +Plateau, -CasesOK)
% @Tanguy
%
% Renvoie -UneCasesOK parmis +Positions qui permet un sandwich
%
%
/******
calcul_cases_qui_sandwich([Case], Couleur, Plateau, [Case]) :- 
	check_sandwich(Case, _, Plateau, Couleur).
calcul_cases_qui_sandwich([_], _, _, []).

calcul_cases_qui_sandwich([T|Q], Couleur, Plateau, [T|CasesOK]) :-
	check_sandwich(T, _, Plateau, Couleur),
	calcul_cases_qui_sandwich(Q, Couleur, Plateau, CasesOK).
calcul_cases_qui_sandwich([_|Q], _, Plateau, CasesOK) :-
	calcul_cases_qui_sandwich(Q, _, Plateau, CasesOK).
*****/
	
calcul_cases_qui_sandwich(Cases, Couleur, Plateau, UneCaseOK):-
	member(UneCaseOK, Cases),
	check_sandwich(UneCaseOK, _, Plateau, Couleur).

%------------- fin calcul_cases_qui_sandwich() ------------------


%--------------------------------------------------
% cases_qui_sandwich(+Positions, +Couleur, +Plateau, -CasesOK)
% @Tanguy
%
% Renvoie dans -CasesOK les cases qui permettent un sandwich parmis les cases +Positions
%
%

cases_qui_sandwich(Positions, Couleur, Plateau, ListeCasesOK) :-
	findall(CasesOK, calcul_cases_qui_sandwich(Positions, Couleur, Plateau, CasesOK), ListeCasesOK).

%------------- fin cases_qui_sandwich() ------------------


%--------------------------------------------------
% coups_legaux(Couleur, Plateau, Coups)
% @Tanguy_et_Thomas
%
% Renvoie la liste des coups que le joueur Couleur peut jouer.
%
% ex :
% ? - coups_legaux(b, [[[1,1],[-1,-1]],[[1,-1],[-1,1]]], Coups).
% > Coups =

	
coups_legaux(Couleur, Plateau, Coups) :-
	couleur_adversaire(Couleur,Adversaire),
	cases_voisines_joueur(Adversaire, Plateau, Voisines),
	all_cases_vides(Voisines, Plateau, Vides),
	cases_qui_sandwich(Vides, Couleur, Plateau, Coups).
	
	
%------------- fin coups_legaux() -----------------


%--------------------------------------------------
% couleur_adversaire(+Couleur1, -Couleur2)
% @Joss
%
% Retourne la couleur de l'adversaire de Couleur1.
%
% ex:
% ? - couleur_adversaire(b, X).
% > X = w

couleur_adversaire(r, g).
couleur_adversaire(g, r).

%---------- fin couleur_adversaire() --------------
% ex:
% ? - couleur_adversaire(b, X).
% > X = w

couleur_adversaire(r, g).
couleur_adversaire(g, r).

%---------- fin couleur_adversaire() --------------
