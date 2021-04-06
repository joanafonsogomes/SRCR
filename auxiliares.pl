% Auxiliares
/*
% Insere conhecimento na base de conhecimento
novoConhecimento(T) :- solucoes(I, +T::I, Linv),
                        insercao(T),
                        teste(Linv).*/

% Verifica se a segunda data e anterior a primeira
comparaDatas(datime(AH,MH,DH,,,_),data(AP,MP,DP)) :-
    AP < AH;
    (AP =:= AH, (MP < MH;
                (MP =:= MH, DP < DH))).

% Verifica se uma data e valida
dataValida(data(A,M,D)) :- (pertence(M,[1,3,5,7,8,10,12]), D >= 1, D =< 31);
                            (pertence(M,[4,6,9,11]), D >= 1, D =< 30);
                            (M =:= 2, (mod(A,4) =:= 0, D >= 1, D =< 29);
                            (D >= 1, D =< 28)).

% Verifica se um contrato ainda esta em vigor
prazoExpirado(data(A,M,D), P) :- calculaPrazo(A,M,D,P,Prazo),
                                datime(Hoje), !,
                                comparaDatas(Hoje,Prazo).

% Calcular idade %
% teste

% retorna uma lista de todos os ids dos utentes
listaIdUtentes(L) :- findall(X,utente(X,A,B,C,D,E,F,G,H,I,J),L).

% Intersecao entre 2 listas
intersecao([], _, []).

intersecao([H1|T1], L2, [H1|Res]) :-
    member(H1, L2),
    intersecao(T1, L2, Res).

intersecao([_|T1], L2, Res) :-
    intersecao(T1, L2, Res).
