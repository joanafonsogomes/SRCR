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

% Averigua se elemento pertence a uma lista
pertence(A,[A|XS]).
pertence(A,[X|XS]) :- pertence(A,XS).

% ========== ASSIGNMENT ==========
% Identificar pessoas nao vacinadas que sao candidatas em vacinacao (para uma fase em especifico)

% Auxs ASSIGNMENT

profissao1Fase(IdU) :- utente(IdU,_,_,_,_,_,_,_,P,_,_),
                        P = 'Profissional de Saude'.

doencas1Fase(IdU) :- utente(IdU,_,_,_,_,_,_,_,_,D,_),
                    A = ['Insuficiencia renal','Doenca renal cronica','Doenca coronaria','DPOC'],
                    common_elements(A,D).

doencas2Fase(IdU) :- utente(IdU,_,_,_,_,_,_,_,_,D,_),
                    A = ['Diabetes','Neoplasia maligna ativa','Doenca renal cronica','Insuficiencia hepatica','Hipertensao arterial','Obesidade'],
                    common_elements(A,D).

% verificar se duas listas têm elementos em comum
membereq(X, [H|_]) :-
    X == H.
membereq(X, [_|T]) :-
    membereq(X, T).

common_elements([H|_], L2) :-
    membereq(H, L2).
common_elements([_|T], L2) :-
    common_elements(T, L2).


% --- Totalmente ---
candidatosVacinacaoT(1,R) :- candidatosVacinacaoTAux(S),
                        findall(X,(member(X,S),calcularIdade(X,C), C>=80), I),
                        findall(X,(member(X,S),profissao1Fase(X)), Pr),
                        findall(X,(member(X,S),doencas1Fase(X),calcularIdade(X,C),C>=50), Do),
                        append(I,Pr,App), append(App,Do,App2),
                        repetidos(App2,R).

candidatosVacinacaoT(2,R) :- candidatosVacinacaoTAux(S),
                        findall(X,(member(X,S),calcularIdade(X,C),C>=65), I), 
                        findall(X,(member(X,S),doencas2Fase(X),calcularIdade(X,C),C>=50,C=<64), Do),
                        append(I,Do,App), repetidos(App,Rep),
                        candidatosVacinacaoT(1,F1),
                        findall(X,(member(X,Rep),\+member(X,F1)), R).

candidatosVacinacaoT(3,R) :- candidatosVacinacaoTAux(S),
                        candidatosVacinacaoT(1,F1),
                        candidatosVacinacaoT(2,F2),
                        append(F1,F2,App), repetidos(App,Rep),
                        findall(X,(member(X,S),\+member(X,Rep)), R).

candidatosVacinacaoT(A,R) :- \+ pertence(A,[1,2,3]) -> write('Fase invalida. As fases podem ser 1, 2 ou 3.'),
                        fail.

% utentes que ainda nao levaram nenhuma vacina
candidatosVacinacaoTAux(R) :- % encontrar os ids de utentes candidatos
                        solucoes(IdU,utente(IdU,_,_,_,DNasc,_,_,_,P,D,_),V),
                        % encontrar o id dos que ja foram vacinados
                        solucoes(IdU, vacinacao(_,IdU,_,_,T), L),
                        repetidos(L,W),
                        % ver os que pertencem a uma e nao ao outro
                        findall(X,(member(X,V),\+member(X,W)),R).
                        

% ---- Parcialmente ----

candidatosVacinacaoP(1,R) :- candidatosVacinacaoPAux(S),
                        findall(X,(member(X,S),calcularIdade(X,C), C>=80), I),
                        findall(X,(member(X,S),profissao1Fase(X)), Pr),
                        findall(X,(member(X,S),doencas1Fase(X),calcularIdade(X,C),C>=50), Do),
                        append(I,Pr,App), append(App,Do,App2),
                        repetidos(App2,R).

candidatosVacinacaoP(2,R) :- candidatosVacinacaoPAux(S),
                        findall(X,(member(X,S),calcularIdade(X,C),C>=65), I), 
                        findall(X,(member(X,S),doencas2Fase(X),calcularIdade(X,C),C>=50,C=<64), Do),
                        append(I,Do,App), repetidos(App,Rep),
                        candidatosVacinacaoP(1,F1),
                        findall(X,(member(X,Rep),\+member(X,F1)), R).

candidatosVacinacaoP(3,R) :- candidatosVacinacaoPAux(S),
                        candidatosVacinacaoP(1,F1),
                        candidatosVacinacaoP(2,F2),
                        append(F1,F2,App), repetidos(App,Rep),
                        findall(X,(member(X,S),\+member(X,Rep)), R).

candidatosVacinacaoP(A,R) :- \+ pertence(A,[1,2,3]) -> write('Fase invalida. As fases podem ser 1, 2 ou 3.'),
                        fail.

% utentes que so levaram a 1 vacina
candidatosVacinacaoPAux(R) :- % encontrar os ids de utentes candidatos
                        solucoes(IdU,utente(IdU,_,_,_,DNasc,_,_,_,P,D,_),V),
                        % encontrar o id dos que fizeram a toma 1
                        solucoes(IdU, vacinacao(_,IdU,_,_,1), T1),
                        % encontrar o id dos que fizeram a toma 2
                        solucoes(IdU, vacinacao(_,IdU,_,_,2), T2),
                        % ver os que pertencem a uma e nao ao outro
                        findall(X,(member(X,V),member(X,T1),\+member(X,T2)),R).

% =========== ASSIGNMENT JORGE ===========

qualFaseJoana(IdU,R) :- calcularIdade(IdU,I),
                        (I >= 80 -> R=1 ;
                        I >= 50 , doencas1Fase(IdU) -> R=1 ;
                        I >= 65 -> R = 2 ;
                        I >= 50, I=<64, doencas2Fase(IdU) -> R=2 ;
                        R = 3).


% =========== TESTES ===========


% listarUtenteNum(Num,R) :- solucoes((a,b,Num,d,e,f,g,h,i,j,k,l,p),utente(a,b,Num,d,e,f,g,h,i,j,k,l,p),R).

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
