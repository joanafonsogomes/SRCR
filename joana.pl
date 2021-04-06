use_module(library(lists)).

% ========= POSSIBLE AUXILIAR FUNC =========

% apresenta todas as solucoes
solucoes(T,Q,S) :- findall(T,Q,S).

% Elimina elementos repetidos de uma lista 
repetidos( [],[] ).
repetidos( [X|L],[X|NL] ) :- removerElem( L,X,TL ), repetidos( TL,NL ).

removerElem( [],_,[] ).
removerElem( [X|L],X,NL ) :- removerElem( L,X,NL ).
removerElem( [X|L],Y,[X|NL] ) :- X \== Y, removerElem( L,Y,NL ).

add_tail([],X,[X]).
add_tail([H|T],X,[H|L]):-add_tail(T,X,L).

% ========== ASSIGNMENT ==========

% Identificar pessoas nao vacinadas que sao candidatas em vacinacao (para uma fase em especifico)

% Totalmente. F->Fase
/*
candidatosVacinacaoT(F,R) :- ( F = 1 -> 
                            ( I-> )
                            solucoes((IdU, NSS, G, N, DNasc, E, Telefone, M, Prof, Dc, IdC),utente((IdU, NSS, G, N, DNasc, E, Telefone, M, Prof, Dc, IdC)),R) ; 
                            else_clause ),*/

% Parcialmente. F==Fase
% candidatosVacinacaoT(F,R) :- solucao()


% =========== TESTES ===========


% listarUtenteNum(Num,R) :- solucoes((a,b,Num,d,e,f,g,h,i,j,k,l,p),utente(a,b,Num,d,e,f,g,h,i,j,k,l,p),R).

% utentes que tomaram uma certa vacina
utentesVacina(V,R) :- solucoes(IDU, vacinacao(ID,IDU,D,V,T,F), R).

% --------------------

% ID dos utentes que são candidatos a vacinas
utentesCandidatos(R) :- solucoes(IDU, vacinacao(ID,IDU,D,V,T,F), L),
                        repetidos( L,R ).

% --------------------

% ID dos utentes que são candidatos a vacinas e que ainda nao tomaram foram vacinados % ASSIGNMENT
/*utentesNoToma(L,R) :- utentesNoToma1(H|T),
                    utentesNoToma2(L),

utentesNoToma1(R) :- solucoes(IDU, vacinacao(ID,IDU,D,V,1,'False'), R). 

utentesNoToma2(R) :- solucoes(IDU, vacinacao(ID,IDU,D,V,2,'False'), R). */

% --------------------

% ID dos utentes que já tomaram a primeira toma da vacina
utentesToma1True(R) :- solucoes(IDU, vacinacao(ID,IDU,D,V,1,'True'), R).
