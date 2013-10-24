filtre([Lettre], [Lettre]) :- voyelle(Lettre).

filtre([_], []).

filtre([TeteMot|QueueMot], [TeteVoyelle|QueueVoyelle]) :- 
voyelle(Tete), filtre(QueueMot, QueueVoyelle).

filtre([TeteMot|QueueMot],Voyelles) :- 
	filtre(QueueMot, Voyelles).