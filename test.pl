choix_best(V1,V2,Best) :-
	V1<V2,
	Best is V2.
	
choix_best(V1,V2,Best) :-
	V1>V2,
	Best is V1.
	
choix_best(V1,V2,Best) :-
	V1==V2,
	Best is V2.
