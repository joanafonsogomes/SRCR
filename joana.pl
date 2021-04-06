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


% -- Totalmente. F = Fase
candidatosVacinacaoT(F,R) :- ( F = 1 ->
                        solucoes(IdU,utente(IdU,_,_,_,DNasc,_,_,_,P,D,_),S),
                        findall(X,(member(X,S),calcularIdade(X,C), C>=80), I),
                        findall(X,(member(X,S),profissao1Fase(X)), Pr),
                        findall(X,(member(X,S),doencas1Fase(X),calcularIdade(X,C),C>=50), Do),
                        append(I,Pr,App), append(App,Do,App2),
                        repetidos(App2,R) ;
                        F = 2 ->
                        solucoes(IdU,utente(IdU,_,_,_,DNasc,_,_,_,P,D,_),S),
                        findall(X,(member(X,S),calcularIdade(X,C),C>=65), I), 
                        findall(X,(member(X,S),doencas2Fase(X),calcularIdade(X,C),C>=50,C=<64), Do),
                        append(I,Do,App), repetidos(App,R) ;
                        solucoes(IdU,utente(IdU,_,_,_,DNasc,_,_,_,P,D,_),S),
                        findall(X,(member(X,S),calcularIdade(X,C), C>=80), I),
                        findall(X,(member(X,S),profissao1Fase(X)), Pr),
                        findall(X,(member(X,S),doencas1Fase(X),calcularIdade(X,C),C>=50), Do),
                        findall(X,(member(X,S),calcularIdade(X,C), C>=65), I2), 
                        findall(X,(member(X,S),doencas2Fase(X),calcularIdade(X,C), C>=50, C=<64), Do2),
                        append(I,Pr,App) , append(App,Do,App2), append(App2,I2,App3), append(App3,Do2,App4),
                        repetidos(App4,R) ).
                        % findall(X,(member(X,S),\+member(X,App5)), R) ).

% utentes que ainda nao levaram nenhuma vacina
candidatosVacinacaoTAux(R) :- % encontrar os ids de utentes candidatos
                        solucoes(IdU,utente(IdU,_,_,_,DNasc,_,_,_,P,D,_),V),
                        % encontrar o id dos que ja foram vacinados
                        solucoes(IdU, vacinacao(_,IdU,_,_,T), L),
                        repetidos(L,W),
                        % ver os que pertencem a uma e nao ao outro
                        findall(X,(member(X,V),\+member(X,W)),R).
                        

% -- Parcialmente. F = Fase
% candidatosVacinacaoT(F,R) :- solucao()


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
