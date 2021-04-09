:- use_module(library(lists)).
:- use_module(library(date)).

% ---------------------------------
% FUNCOES AUXILIARES
% ---------------------------------

% Apresenta todas as solucoes
solucoes(T,Q,S) :- findall(T,Q,S).

% Elimina elementos repetidos de uma lista 
repetidos([],[]).
repetidos([X|L],[X|NL]) :- removerElem(L,X,TL), repetidos(TL,NL).

removerElem([],_,[]).
removerElem([X|L],X,NL) :- removerElem(L,X,NL).
removerElem([X|L],Y,[X|NL]) :- X \== Y, removerElem(L,Y,NL).

% Verifica se um elemento pertence a uma lista
pertence(A,[A|XS]).
pertence(A,[_|XS]) :- pertence(A,XS).

% Verifica se duas listas têm elementos em comum
temElementosComum([H|_], L2) :- pertence(H, L2).
temElementosComum([_|T], L2) :- temElementosComum(T, L2).

% Calcular a idade
calcularIdade(IdU,R) :- utente(IdU,_,_,_,DNasc,_,_,_,_,_,_),
                        split_string(DNasc, "-", "", Sp),
                        nth0(0,Sp,Ano), nth0(1,Sp,Mes), nth0(2,Sp,Dia),
                        get_date_time_value(year, AnoN), get_date_time_value(month, MesN), get_date_time_value(day, DiaN),
                        atom_number(Ano, Year), atom_number(Mes, Month), atom_number(Dia, Day),
                        atom_string(AnoN, YearN), atom_number(YearN, YearNN),
                        atom_string(MesN, MonthN), atom_number(MonthN, MonthNN),
                        atom_string(DiaN, DayN), atom_number(DayN, DayNN),
                        Age is (YearNN - Year),
                        (Month > MonthNN -> AgeN is Age-1 ;
                        Month < MonthNN -> AgeN is Age ;
                            (Day > DayNN -> AgeN is Age-1 ;
                            AgeN is Age)),
                        R = AgeN.

% Obter a data atual
get_date_time_value(Key, Value) :-
    get_time(Stamp),
    stamp_date_time(Stamp, DateTime, local),
    date_time_value(Key, DateTime, Value).

% Verifica se um contrato ainda esta em vigor
prazoExpirado(data(A,M,D), P) :- calculaPrazo(A,M,D,P,Prazo),
                                 datime(Hoje), !,
                                 comparaDatas(Hoje,Prazo).

% retorna uma lista de todos os ids dos utentes
listaIdUtentes(L) :- findall(X,utente(X,_,_,_,_,_,_,_,_,_,_),L).

% Intersecao entre duas listas
intersecao([], _, []).
intersecao([H1|T1], L2, [H1|R]) :- member(H1, L2), intersecao(T1, L2, R).
intersecao([_|T1], L2, R) :- intersecao(T1, L2, R).



% Profissoes de utentes correspondentes a fase 1
profissao1Fase(IdU) :- utente(IdU,_,_,_,_,_,_,_,P,_,_),
                       P = 'Profissional de Saude'.

% Doencas correspondentes a fase 1 (50 ou mais anos)
doencas1Fase(IdU) :- utente(IdU,_,_,_,_,_,_,_,_,D,_),
                     A = ['Insuficiencia renal','Doenca renal cronica','Doenca coronaria','DPOC'],
                     temElementosComum(A,D).

% Doencas correspondentes a fase 2 (50 a 64 anos)
doencas2Fase(IdU) :- utente(IdU,_,_,_,_,_,_,_,_,D,_),
                     A = ['Diabetes','Neoplasia maligna ativa','Doenca renal cronica','Insuficiencia hepatica','Hipertensao arterial','Obesidade'],
                     temElementosComum(A,D).


nomeDoUtente(UId,X) :- utente(UId,X,_,_,_,_,_,_,_,_,_).


% Verifica se um elemento esta vacinado numa certa fase
checkVacinado(UId,X,F) :- vacinacao(A,UId,B,C,F).

vacinados(X) :- findall(UId,vacinacao(_,UId,_,_,_),X).


% quantas vacinas recebeu
quantasVacinas(IDU, N) :- Id=IDU,findall(Id,vacinacao(_,Id,_,_,_),X),length(X,N).

%parse de Data
parseData(K,A,M,D) :- split_string(K, "-", "", Sp),
                        nth0(0,Sp,Ano), nth0(1,Sp,Mes), nth0(2,Sp,Dia),
                        atom_number(Ano, Year), atom_number(Mes, Month), atom_number(Dia, Day),
                        (A is Year, M is Month, D is Day).

%ve se data 1 é antes de data 2 (1 = True , 0 = False)
comparaDatas(A1,_,_,A2,_,_,0):- A1 > A2.
comparaDatas(A1,M1,_,A2,M2,_,0):- M1 > M2, A1 >= A2.
comparaDatas(A1,M1,D1,A2,M2,D2,0):- D1 > D2, A1 >= A2, M1 >= M2.
comparaDatas(_,_,_,_,_,_,1).

comparaDatasStr(X1,X2,R):- parseData(X1,A1,M1,D1), parseData(X2,A2,M2,D2), comparaDatas(A1,M1,D1,A2,M2,D2,R).

% check a fase pertencente a um Dia (vou dar meio hard-code porque estou com sono)
checkFase(D,X):- fase(X,DI,DF), comparaDatasStr(D,DI,0), comparaDatasStr(D,DF,1). 









