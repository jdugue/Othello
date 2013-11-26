%--------------------------------------------------
% choix_move(+ListMoves,Plateau,Couleur -Move)
% @Mael
%
% Retourne le move chois par l'IA

choix_move_RAND([],_,_, []).
choix_move_RAND(Coups,_,_,Choix) :-
        length(Coups, Length),
        random(0, Length, Index),
        nth0(Index, Coups, Choix).

%------------- fin choix_move() ------------------


