% -- INVARIANTES --
%Só pode haver 1 utente por id TODO: Mudar para solucoes quando for implementado nas auxiliares
+utente(Id,N,nS,G,DataNasc,C,Email,Tlm,M,P,D,IdC) :: (findall(Id, utente(Id,_,_,_,_,_,_,_,_,_,_,_), R),
                            length(R, 1)).
%Garantir que não posso eliminar um elemento se tiver vacinacoes marcadas
-utente(Id,N,nS,G,DataNasc,C,Email,Tlm,M,P,D,IdC) :: (findall(Id, vacinacao(_,Id,_,_,_), R),
                            \+length(R, 0)).

-staff(Id,N,nS,Email,IdC) :: (findall(Id, vacinacao(Id,_,_,_,_), R),
                            \+length(R, 0)).

-centro(Id,N,M,Tlm,Email) :: (findall(sId,staff(sId,_,_,_,Id),R),
                            \+length(R, 0)).