% apresenta todas as solucoes
solucoes(T,Q,S) :- findall(T,Q,S).

vacinados1Dose(R) :- solucoes(UId,vacinacao(A,UId,B,C,1),R).


vacinados2Doses(R) :- solucoes(UId,vacinacao(A,UId,B,C,1),L1),
                solucoes(UId,vacinacao(A,UId,B,C,2),L2),
                intersecao(L1,L2,R).

% by request (Pode dar jeito no futuro)
nomeDoUtente(UId,X) :- utente(UId,X,A,B,C,D,E,F,G,H,I).

% Averigua se elemento esta vacinado
checkVacinado(UId,X,F) :- vacinacao(A,UId,B,C,F).

% Elimina os utentes vacinados
naoVacinados(R) :- listaIdUtentes(X),
                   naoVacinadosAux(X,[],R).

naoVacinadosAux([],Acc,Acc).
naoVacinadosAux([H|T],Acc,R) :- checkVacinado(H,Acc,1),checkVacinado(H,Acc,2), naoVacinadosAux(T,Acc,R).
naoVacinadosAux([H|T],Acc,R) :- naoVacinadosAux(T,[H|Acc],R).

% Só primeira dose 
apenasPrimeiraDoseVacinados(R) :- listaIdUtentes(X),
                            apenasPrimeiraDoseVacinadosAux(X,[],R).

apenasPrimeiraDoseVacinadosAux([],Acc,Acc).
apenasPrimeiraDoseVacinadosAux([H|T],Acc,R) :- (checkVacinado(H,Acc,1),\+checkVacinado(H,Acc,2)), apenasPrimeiraDoseVacinadosAux(T,[H|Acc],R).
apenasPrimeiraDoseVacinadosAux([H|T],Acc,R) :- apenasPrimeiraDoseVacinadosAux(T,Acc,R).
