%--------------------------------------------------
% choix_move(+ListMoves, -Move)
% @Mael
%
% Retourne le move chois par l'IA
%
% ex:
% ? - choix_move([[2,1],[3,2],[-3,4],[-1,4],[2,3],[-4,4]],R).

choix_move_LAZY([], []).
choix_move_LAZY([T|_],_,_,T).

%------------- fin choix_move() ------------------


