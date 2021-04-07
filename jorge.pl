:- include('baseconhecimento.pl').
:- include('auxiliares.pl').

doencasFase1(['Insuficiencia cardiaca', 'Doenca coronaria', 'Insuficiencia renal', 'DPOC']).
doencasFase2(['Diabetes','Neoplasia maligna ativa','Doenca renal cronica','Insuficiencia hepatica','Hipertensao arterial','Obesidade']).

membereq(X, [H|_]) :-
    X == H.
membereq(X, [_|T]) :-
    membereq(X, T).

common_elements([H|_], L2) :-
    membereq(H, L2).
common_elements([_|T], L2) :-
    common_elements(T, L2).

getProfissao(IDU,G) :- utente(IDU,_,_,_,_,_,_,_,G,_,_).
getDoencas(IDU,D) :- utente(IDU,_,_,_,_,_,_,_,_,D,_).

%teste(L1,R):- common_elements(doencasFase1)
teste(IDU,L,R) :- doencasFase1(X),
                  doencasFase2(Y),
                  calcularIdade(IDU,Idade),
                  getProfissao(IDU,Prof),
                  ((common_elements(L,X), Idade >= 50; Idade >= 80; Prof == 'Profissional de Saude') -> R is 1;
                  (common_elements(L,Y), Idade >= 50, Idade =< 64; Idade >= 65) -> R is 2;
                  R is 3).

/*
teste(L) :- doencasFase1(X),
                doencasFase2(Y),
                common_elements(L,X);
                common_elements(L,Y).

qualFase(IDU,1) :- getDoencas(IDU,D),
                   calcularIdade(IDU,I),
                   teste(D),
                   I >= 50.
qualFase(IDU,1) :- calcularIdade(IDU,I),
                   I >= 80.
qualFase(IDU,1) :- getProfissao(IDU,P),
                   P == 'Profissional de Saude'.

qualFase(IDU,2) :- calcularIdade(IDU,I),
                   I >= 65.
qualFase(IDU,2) :- getDoencas(IDU,D),
                   calcularIdade(IDU,I),
                   teste(D),
                   I >= 50,
                   I =< 64.

qualFase(IDU,3).
*/
%doencasUtente(UId,H) :- utente(UId,X,A,B,C,D,E,F,G,H,I).


%qualFase(UID,N,NSS,G,DN,E,NT,M,P,DC,T1,T2,1) :- utente(UID,N,NSS,G,DN,E,NT,M,P,,T1,T2)