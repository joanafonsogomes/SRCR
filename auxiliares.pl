:- use_module(library(lists)).
:- use_module(library(date)).

% ---------------------------------
% FUNCOES AUXILIARES
% ---------------------------------

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

% Get current date
get_date_time_value(Key, Value) :-
    get_time(Stamp),
    stamp_date_time(Stamp, DateTime, local),
    date_time_value(Key, DateTime, Value).
% Verifica se um contrato ainda esta em vigor
prazoExpirado(data(A,M,D), P) :- calculaPrazo(A,M,D,P,Prazo),
                                datime(Hoje), !,
                                comparaDatas(Hoje,Prazo).

% retorna uma lista de todos os ids dos utentes
listaIdUtentes(L) :- findall(X,utente(X,A,B,C,D,E,F,G,H,I,J),L).

% Intersecao entre 2 listas
intersecao([], _, []).

intersecao([H1|T1], L2, [H1|Res]) :-
    member(H1, L2),
    intersecao(T1, L2, Res).

intersecao([_|T1], L2, Res) :-
    intersecao(T1, L2, Res).
