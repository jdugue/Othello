%--------------------------------------------------
% choix_move(+ListMoves, -Move)
% @Mael
%
% Retourne le move chois par l'IA
%
% ex:
% ? - choix_move([[2,1],[3,2],[-3,4],[-1,4],[2,3],[-4,4]],R).

choix_move([], []).
choix_move(List, Elt) :-
        length(List, Length),
        random(0, Length, Index),
        nth0(Index, List, Elt).

%------------- fin choix_move() ------------------


