%Extensão do metapredicado not
not( Questao ) :- Questao, !, fail.
not( Questao ).

%INVARIANTES UNIVERSAIS%

%Garante que não há conhecimento perfeito positivo repetido
+T :: (solucoes(T, T, R),
       length(R, 1)).

%Garante que não há conhecimento perfeito negativo repetido
+(-T) :: (solucoes(T, -T, R),
       length(R, 1)).

%Garante não haver contradições entre conhecimento perfeito
+T :: not(-T).
+(-T) :: not(T).

%Garante que não há exceções repetidas (mudar nome caso não chamemos excecao)
+(excecao(T)) :: (solucoes(T,excecao(T),R),                
                 length(R,1)).

%INVARIANTES ESPECIFICOS%

%UTENTE%

%Garantir que não posso eliminar um elemento se tiver vacinacoes marcadas
-utente(Id,_,_,_,_,_,_,_,_,_,_) :: (findall(Id, vacinacao(_,Id,_,_,_), R),
                                    length(R, 0)).

%CONHECIMENTO PERFEITO POSITIVO%

% Garantir que o ID de cada utente é único:
+utente(Id,_,_,_,_,_,_,_,_,_,_) :: (solucoes(Id, utente(Id,_,_,_,_,_,_,_,_,_,_), R),
                                   length(R, 1)).

%Os utentes só podem ser do sexo masculino ou feminino
+utente(_,_,_,G,_,_,_,_,_,_,_) :: genderValido(G).

%Os utentes têm de ter um ID de centro existente
+utente(_,_,_,_,_,_,_,_,_,_,IdC) :: centro(IdC,_,_,_,_).

%Garantir  que  utentes  com  IDs  diferentes tem diferente  informacao 
+utente(Id,N,NSS,G,DN,E,TLF,M,P,D,IDC) :: (solucoes((Id,NSS,E,TLF), utente(_,_,NSS,_,_,E,TLF,_,_,_,_), R), 
                                            length(R,1)).

% Garantir que o género do utente é 'M' ou 'F'
+utente(_,_,_,G,_,_,_,_,_,_,_) :: generoValido(G).

%CONHECIMENTO PERFEITO NEGATIVO%

% Garantir que o ID de cada utente é único:
+(-utente(Id,_,_,_,_,_,_,_,_,_,_)) :: (solucoes(Id, -utente(Id,_,_,_,_,_,_,_,_,_,_), R),
                                   length(R, 1)).

%Os utentes só podem ser do sexo masculino ou feminino
+(-utente(_,_,_,G,_,_,_,_,_,_,_)) :: genderValido(G).

%Os utentes têm de ter um ID de centro existente
+(-utente(_,_,_,_,_,_,_,_,_,_,IdC)) :: centro(IdC,_,_,_,_).

%Garantir  que  utentes  com  IDs  diferentes tem diferente  informacao 
+(-utente(Id,N,NSS,G,DN,E,TLF,M,P,D,IDC)) :: (solucoes((Id,NSS,E,TLF), -utente(_,_,NSS,_,_,E,TLF,_,_,_,_), R), 
                                            length(R,1)).

% Garantir que o género do utente é 'M' ou 'F'
+(-utente(_,_,_,G,_,_,_,_,_,_,_)) :: generoValido(G).


%STAFF%

%Garantir que não posso eliminar um funcionario se tiver vacinacoes marcadas
-staff(Id,_,_,_,_) :: (findall(Id, vacinacao(Id,_,_,_,_), R),
                        length(R, 0)).

%CONHECIMENTO PERFEITO POSITIVO%

% Garantir que o ID de cada staff é único:
+staff(Id,_,_,_) :: (solucoes(Id, staff(Id,_,_,_), R),
                                     length(R, 1)).

%Garantir que  funcionarios  com  IDs  diferentes  tˆem diferente  informacao 
+staff(Id,_,SS,T,C) :: (solucoes((SS,T,C), staff(_,_,SS,T,C), R), 
                                            length(R,1)).

%CONHECIMENTO PERFEITO NEGATIVO%

% Garantir que o ID de cada staff é único:
+(-staff(Id,_,_,_)) :: (solucoes(Id, -staff(Id,_,_,_), R),
                                     length(R, 1)).

%Garantir que  funcionarios  com  IDs  diferentes  tˆem diferente  informacao 
+(-staff(Id,_,SS,T,C)) :: (solucoes((SS,T,C), -staff(_,_,SS,T,C), R), 
                                            length(R,1)).

%CENTRO%

%Garantir que não posso eliminar um centro se tiver vacinacoes marcadas
-centro(Id,_,_,_,_) :: (findall(sId,staff(sId,_,_,_,Id),R),
                     length(R, 0)).

%CONHECIMENTO PERFEITO POSITIVO%

% Garantir que o ID de cada centro é único:
+centro(Id,_,_,_,_) :: (solucoes(Id, centro(Id,_,_,_,_), R),
                     length(R, 1)).

%Garantir  que  centros  com  IDs  diferentes  tˆem diferente  informacao 
+centro(Id,N,_,T,E) :: (solucoes((Id,N,T,E), centro(_,N,_,T,E), R), 
                     length(R,1)).

%CONHECIMENTO PERFEITO NEGATIVO%

% Garantir que o ID de cada centro é único:
+(-centro(Id,_,_,_,_)) :: (solucoes(Id, -centro(Id,_,_,_,_), R),
                     length(R, 1)).

%Garantir  que  centros  com  IDs  diferentes  tˆem diferente  informacao 
+(-centro(Id,N,_,T,E)) :: (solucoes((Id,N,T,E), -centro(_,N,_,T,E), R), 
                     length(R,1)).
                
%VACINACAO (NÃO É MUNDO FECHADO)%

% Garantir que não há vacinações repetidas:
+vacinacao(Id,B,C,D,E) :: (solucoes(Id, vacinacao(Id,B,C,D,E), R),
                     length(R, 1)).

%Adicionar uma vacinaçao da toma 2 requer que a toma 1 ja esteja na base de conhecimento:
+vacinacao(S,U,_,_,2) :: vacinacao(S,U,_,_,1).

%FASE%

%Garantir que o inicio de uma fase seja antes do fim da mesma
+fase(_,DI,DF) :: comparaDatasStr(DI,DF).

%Garantir que o inicio de uma fase seja antes do fim da mesma
+(-fase(_,DI,DF)) :: comparaDatasStr(DI,DF).