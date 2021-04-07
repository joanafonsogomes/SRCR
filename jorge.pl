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
teste(IDU,R) :- doencasFase1(X),
                doencasFase2(Y),
                calcularIdade(IDU,Idade),
                getProfissao(IDU,Prof),
                getDoencas(IDU,Doencas),
                (((common_elements(Doencas,X), Idade >= 50); Idade >= 80; Prof == 'Profissional de Saude') -> R is 1;
                ((common_elements(Doencas,Y), Idade >= 50, Idade =< 64); Idade >= 65) -> R is 2;
                R is 3).