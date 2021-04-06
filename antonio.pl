% apresenta todas as solucoes
solucoes(T,Q,S) :- findall(T,Q,S).

vacinados1Dose(R) :- solucoes(UId,vacinacao(A,UId,B,C,1),R).


vacinados2Doses(R) :- solucoes(UId,vacinacao(A,UId,B,C,1),L1),
                solucoes(UId,vacinacao(A,UId,B,C,2),L2),
                intersecao(L1,L2,R).

% by request (Pode dar jeito no futuro)
nomeDoUtente(UId,X) :- utente(UId,X,A,B,C,D,E,F,G,H,I).

% Averigua se elemento esta vacinado
checkVacinado(UId,X) :- vacinacao(A,UId,B,C,D).

% Elimina os utentes vacinados
naoVacinados(R) :- listaIdUtentes(X),
                   naoVacinadosAux(X,[],R).

naoVacinadosAux([],Acc,Acc).
naoVacinadosAux([H|T],Acc,R) :- checkVacinado(H,Acc), naoVacinadosAux(T,Acc,R).
naoVacinadosAux([H|T],Acc,R) :- naoVacinadosAux(T,[H|Acc],R).