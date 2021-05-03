% ----------------------------------------------
% Invariantes
% ----------------------------------------------


% ---------- Invariantes Universais ------------

% Garante que não há conhecimento perfeito positivo repetido
+T :: (solucoes(T, T, R),
       comprimento(R, 1)).

% Garante que não há conhecimento perfeito negativo repetido
+(-T) :: (solucoes(T, -T, R),
       comprimento(R, 1)).

% Garante não haver contradições entre conhecimento perfeito
+T :: nao(-T).
+(-T) :: nao(T).

% Garante que não há exceções repetidas
+(excecao(T)) :: (solucoes(T,excecao(T),R),                
                 comprimento(R,1)).
 

% --- Invariantes Estruturais e Referenciais ---

% --- Utente

% Garantir que não se pode eliminar um utente que tenha vacinacoes marcadas
-utente(Id,_,_,_,_,_,_,_,_,_,_) :: (findall(Id, vacinacao(_,Id,_,_,_), R),
                                    comprimento(R, 0)).

% Garantir que o ID de cada utente é único:
+utente(Id,_,_,_,_,_,_,_,_,_,_) :: (solucoes(Id, utente(Id,_,_,_,_,_,_,_,_,_,_), R),
                                   comprimento(R, 1)).
+(-utente(Id,_,_,_,_,_,_,_,_,_,_)) :: (solucoes(Id, -utente(Id,_,_,_,_,_,_,_,_,_,_), R),
                                   comprimento(R, 1)).

% Os utentes têm de ter um ID de centro existente
+utente(_,_,_,_,_,_,_,_,_,_,IdC) :: centro(IdC,_,_,_,_).
+(-utente(_,_,_,_,_,_,_,_,_,_,IdC)) :: centro(IdC,_,_,_,_).

% Garantir que utentes com IDs diferentes tem diferente informacao 
+utente(Id,_,NSS,_,_,E,TLF,_,_,_,_) :: (solucoes((Id,NSS,E,TLF), utente(_,_,NSS,_,_,E,TLF,_,_,_,_), R), 
                                          comprimento(R,1)).
+(-utente(Id,_,NSS,_,_,E,TLF,_,_,_,_)) :: (solucoes((Id,NSS,E,TLF), -utente(_,_,NSS,_,_,E,TLF,_,_,_,_), R), 
                                          comprimento(R,1)).

% Garantir que o género do utente é 'M' ou 'F'
+utente(_,_,_,G,_,_,_,_,_,_,_) :: generoValido(G).
+(-utente(_,_,_,G,_,_,_,_,_,_,_)) :: genderValido(G).


% --- Staff

% Garantir que não posso eliminar um funcionario se tiver vacinacoes marcadas
-staff(Id,_,_,_,_) :: (findall(Id, vacinacao(Id,_,_,_,_), R),
                        comprimento(R, 0)).

% Garantir que o ID de cada staff é único:
+staff(Id,_,_,_) :: (solucoes(Id, staff(Id,_,_,_), R),
                            comprimento(R, 1)).
+(-staff(Id,_,_,_)) :: (solucoes(Id, -staff(Id,_,_,_), R),
                            comprimento(R, 1)).

%Garantir que  funcionarios  com  IDs  diferentes  tˆem diferente  informacao 
+staff(_,_,SS,T,C) :: (solucoes((SS,T,C), staff(_,_,SS,T,C), R), 
                            comprimento(R,1)).
+(-staff(_,_,SS,T,C)) :: (solucoes((SS,T,C), -staff(_,_,SS,T,C), R), 
                            comprimento(R,1)).


% --- Centro

% Garantir que não posso eliminar um centro se tiver vacinacoes marcadas
-centro(Id,_,_,_,_) :: (findall(sId,staff(sId,_,_,_,Id),R),
                     comprimento(R, 0)).

%CONHECIMENTO PERFEITO POSITIVO%

% Garantir que o ID de cada centro é único:
+centro(Id,_,_,_,_) :: (solucoes(Id, centro(Id,_,_,_,_), R),
                     comprimento(R, 1)).
+(-centro(Id,_,_,_,_)) :: (solucoes(Id, -centro(Id,_,_,_,_), R),
                     comprimento(R, 1)).

%Garantir que centros com  IDs diferentes têm diferente informacao 
+centro(Id,N,_,T,E) :: (solucoes((Id,N,T,E), centro(_,N,_,T,E), R), 
                     comprimento(R,1)).
+(-centro(Id,N,_,T,E)) :: (solucoes((Id,N,T,E), -centro(_,N,_,T,E), R), 
                     comprimento(R,1)).

            
% --- Vacinação

% Garantir que não há vacinações repetidas
+vacinacao(Id,B,C,D,E) :: (solucoes(Id, vacinacao(Id,B,C,D,E), R),
                     comprimento(R, 1)).

% Adicionar uma vacinaçao da toma 2 requer que a 
% toma 1 ja esteja na base de conhecimento 
% e que ambas as doses sejam do mesmo tipo
+vacinacao(_,U,_,V,2) :: vacinacao(_,U,_,V,1).

% Garantir que a vacinação é efetuada num utente que esteja na base de conhecimento
+vacinacao(_,U,_,_,_) :: utente(U,_,_,_,_,_,_,_,_,_,_).

% Garantir que a vacinação é efetuada por um membro da staff que esteja na base de conhecimento
+vacinacao(S,_,_,_,_) :: staff(S,_,_,_,_).

% Garantir que a vacinação é efetuada por um membro da staff
% que trabalhe no centro onde o utente está escrito
+vacinacao(S,U,_,_,_) :: (staff(S,_,_,_,C), utente(U,_,_,_,_,_,_,_,_,_,C)).


% --- Fase

% Garantir que o inicio de uma fase seja antes do fim da mesma
+fase(_,DI,DF) :: comparaDatasStr(DI,DF).
+(-fase(_,DI,DF)) :: comparaDatasStr(DI,DF).