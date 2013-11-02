voyelle(a).
voyelle(e).
voyelle(i).
voyelle(o).
voyelle(u).
voyelle(y).


filtre([Lettre], [Lettre]) :- voyelle(Lettre).
filtre([_], []).

filtre([TeteMot|QueueMot], [TeteMot|QueueVoyelle]) :-
	voyelle(TeteMot),
	filtre(QueueMot, QueueVoyelle).

filtre([_|QueueMot],Voyelles) :- 
	filtre(QueueMot, Voyelles).
	
filtre_ameliore(Mot,ListeUnique) :-	findall(Listes, filtre(Mot, Listes), [ListeUnique|_]).




filtre_ameliore_bis([Lettre], [Lettre]) :- voyelle(Lettre).
filtre_ameliore_bis([_], []).

filtre_ameliore_bis([TeteMot|QueueMot], [TeteMot|QueueVoyelle]) :-
	voyelle(TeteMot),
	!,
	filtre_ameliore_bis(QueueMot, QueueVoyelle).

filtre_ameliore_bis([_|QueueMot],Voyelles) :-
	!, 
	filtre_ameliore_bis(QueueMot, Voyelles).
	
	
	





filtre_parfait([Lettre], [Lettre]) :- voyelle(Lettre).
filtre_parfait([Lettre], []) :- not(voyelle(Lettre)).

filtre_parfait([TeteMot|QueueMot], [TeteMot|QueueVoyelle]) :-
	voyelle(TeteMot),
	filtre_parfait(QueueMot, QueueVoyelle).

filtre_parfait([TeteMot|QueueMot],Voyelles) :- 
	not(voyelle(TeteMot)),
	filtre_parfait(QueueMot, Voyelles).