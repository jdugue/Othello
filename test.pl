dernier_element( [ H | [ ] ],H). 	%Condition d’arrêt de la récursivité
	dernier_element([ H | T ], Dernier) :-
		dernier_element(T,Dernier).                          	%Récursivité
