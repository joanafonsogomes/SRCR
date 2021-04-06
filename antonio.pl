% apresenta todas as solucoes
solucoes(T,Q,S) :- findall(T,Q,S).

vacinados1Dose(R) :- solucoes(UId,vacinacao(A,UId,B,C,1),R).


vacinados2Doses(R) :- solucoes(UId,vacinacao(A,UId,B,C,1),L1),
                solucoes(UId,vacinacao(A,UId,B,C,2),L2),
                intersecao(L1,L2,R).
