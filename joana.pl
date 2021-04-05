% apresenta todas as solucoes
solucoes(T,Q,S) :- findall(T,Q,S).

% Averigua se elemento pertence a uma lista
pertence(A,[A|XS]).
pertence(A,[X|XS]) :- pertence(A,XS).


% Elimina elementos repetidos de uma lista 
repetidos( [],[] ).
repetidos( [X|L],[X|NL] ) :- removerElem( L,X,TL ), repetidos( TL,NL ).

removerElem( [],_,[] ).
removerElem( [X|L],X,NL ) :- removerElem( L,X,NL ).
removerElem( [X|L],Y,[X|NL] ) :- X \== Y, removerElem( L,Y,NL ).

% TESTE
% listarUtenteNum(Num,R) :- solucoes((a,b,Num,d,e,f,g,h,i,j,k,l,p),utente(a,b,Num,d,e,f,g,h,i,j,k,l,p),R).

% utentes que tomaram uma certa vacina
utentesVacina(V,R) :- solucoes(IDU, vacinacao(ID,IDU,D,V,T,F), R).

% ID dos utentes que já tomaram a primeira toma da vacina
utentesToma1True(R) :- solucoes(IDU, vacinacao(ID,IDU,D,V,1,'True'), R).

% ID dos utentes que ainda nao tomaram a primeira dose da vacina
utentesToma1False(R) :- solucoes(IDU, vacinacao(ID,IDU,D,V,1,'False'), R).