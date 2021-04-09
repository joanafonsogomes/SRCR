% Este ficheiro vai conter: as declarações iniciais | os invariantes | as funcionalidades.
% ---------------------------------
% SRCR TP1
% ---------------------------------

% -- INCLUDES --
:- include('auxiliares.pl').


:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- op(900,xfy,'::').
:- dynamic utente/11.
:- dynamic staff/5.
:- dynamic centro/5.
:- dynamic vacinacao/6.

%------------------
% INVARIANTES
%------------------

<<<<<<< HEAD
% Garantir que o ID de cada utente é único:
+utente(Id,A,B,C,D,E,F,G,H,I,J) :: (solucoes(Id, utente(Id,_,_,_,_,_,_,_,_,_,_,_), R),
                                     length(R, 1)).

% Garantir que o ID de cada centro é único:
+centro(Id,A,B,C,D) :: (solucoes(Id, centro(Id,_,_,_,_), R),
                                     length(R, 1)).

% Garantir que o ID de cada staff é único:
+staff(Id,A,B,C) :: (solucoes(Id, staff(Id,_,_,_), R),
                                     length(R, 1)).

% Garantir que não há vacinações repetidas:
+vacinacao(A,B,C,D,E) :: (solucoes(Id, vacinacao(A,B,C,D,E), R),
                                     length(R, 1)).

% Garantir que o ID de cada fase é único:
+fase(Id,A,B) :: (solucoes(Id, fase(Id,_,_), R),
                                     length(R, 1)).

% Garantir que não posso eliminar um elemento se tiver vacinacoes marcadas
=======
%Só pode haver 1 utente por id TODO: Mudar para solucoes quando for implementado nas auxiliares
+utente(Id,A,B,C,D,E,F,G,H,I,J) :: (findall(Id, utente(Id,_,_,_,_,_,_,_,_,_,_,_), R),
                                     length(R, 1)).

%Os utentes só podem ser do sexo masculino ou feminino
+utente(_,_,_,G,_,_,_,_,_,_,_) :: genderValido(G).

%Os utentes têm de ter um ID de centro existente
+utente(_,_,_,_,_,_,_,_,_,_,IdC) :: centro(IdC,_,_,_,_).

%Garantir que não posso eliminar um elemento se tiver vacinacoes marcadas
>>>>>>> main
-utente(Id,_,_,_,_,_,_,_,_,_,_) :: (findall(Id, vacinacao(_,Id,_,_,_), R),
                            \+length(R, 0)).

% Garantir que o género do utente é 'M' ou 'F'
+utente(_,_,_,G,_,_,_,_,_,_,_) :: generoValido(G).

-staff(Id,_,_,_,_) :: (findall(Id, vacinacao(Id,_,_,_,_), R),
                            \+length(R, 0)).


-centro(Id,_,_,_,_) :: (findall(sId,staff(sId,_,_,_,Id),R),
                            \+length(R, 0)).


%------------------
% REGISTRAR utentes, staff, centros de saude e vacinações
%------------------

% UTENTE: Idutente, Nº Segurança_Social, Nome, Genero, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde
novoUtente(Id,N,NISS,G,Dn,E,Tlf,M,P,Dc,IdCs) :- novoConhecimento(utente(Id,N,NISS,G,Dn,E,Tlf,M,P,Dc,IdCs)).

% STAFF: IdStaff, IdCentro, Nome, Email
novoStaff(Id,IdCs,N,E) :- novoConhecimento(staff(Id,IdCs,N,E)).

% CENTROS DE SAUDE: IdCentro, Nome, Morada, Telefone, Email
novoCentro(Id,IdCs,N,M,Tlf,E) :- novoConhecimento(centro(Id,IdCs,N,M,Tlf,E)).

% VACINAÇÕES: IdStaff, IdUtente, Data, Vacina, Toma
novaVacinacao(IdS,IdU,D,V,T) :- novoConhecimento(vacinacao(IdS,IdU,D,V,T)).

%------------------
% FUNCIONALIDADES
%------------------

% Identificar pessoas nao vacinadas que sao candidatas em vacinacao (para uma fase em especifico)

% Não tomaram nenhuma dose

% Utentes candidatos a vacinacao da fase 1 que ainda nao tomaram nenhuma vacina
candidatosVacinacaoT(1,R) :- % utentes que ainda nao tomaram nenhuma vacina
                        naoVacinados(S),
                        % utentes candidatos + de 80 anos
                        findall(X,(member(X,S),calcularIdade(X,C), C>=80), I),
                        % utentes candidatos que sao profissionais de saude
                        findall(X,(member(X,S),profissao1Fase(X)), Pr),
                        % utentes candidatos + de 50 anos e com doencas da fase 1
                        findall(X,(member(X,S),doencas1Fase(X),calcularIdade(X,C),C>=50), Do),
                        % juntar as listas
                        append(I,Pr,App), append(App,Do,App2),
                        % eliminar ids repetidos
                        repetidos(App2,R).

% Utentes candidatos a vacinacao da fase 2 que ainda nao tomaram nenhuma vacina
candidatosVacinacaoT(2,R) :- % utentes que ainda nao tomaram nenhuma vacina
                        naoVacinados(S),
                        % utentes candidatos com + de 65 anos
                        findall(X,(member(X,S),calcularIdade(X,C),C>=65), I), 
                        % utentes candidatos de 50 a 64 anos com doencas da fase 2
                        findall(X,(member(X,S),doencas2Fase(X),calcularIdade(X,C),C>=50,C=<64), Do),
                        % juntar as listas e elim repetidos
                        append(I,Do,App), repetidos(App,Rep),
                        % eliminar os que sao da fase 1
                        candidatosVacinacaoT(1,F1),
                        findall(X,(member(X,Rep),\+member(X,F1)), R).

% Utentes candidatos a vacinacao da fase 3 que ainda nao tomaram nenhuma vacina
candidatosVacinacaoT(3,R) :- % utentes que ainda nao tomaram nenhuma vacina
                        naoVacinados(S),
                        % utentes candidatos nao vacinados da f1 e f2
                        candidatosVacinacaoT(1,F1),
                        candidatosVacinacaoT(2,F2),
                        append(F1,F2,App), repetidos(App,Rep),
                        % identificar os restantes
                        findall(X,(member(X,S),\+member(X,Rep)), R).

% Input de fase indevido
candidatosVacinacaoT(A,R) :- \+ pertence(A,[1,2,3]) -> write('Fase invalida. As fases podem ser 1, 2 ou 3.'),
                          fail.

% Só tomaram a primeira dose

% Utentes candidatos a vacinacao da fase 1 que ainda so tomaram a primeira dose da vacina
candidatosVacinacaoP(1,R) :- % utentes que so tomaram a dose 1
                        vacinadosSoUmaDose(S),
                        % utentes candidatos + de 80 anos
                        findall(X,(member(X,S),calcularIdade(X,C), C>=80), I),
                        % utentes candidatos que sao profissionais de saude
                        findall(X,(member(X,S),profissao1Fase(X)), Pr),
                        % utentes candidatos + de 50 anos e com doencas da fase 1
                        findall(X,(member(X,S),doencas1Fase(X),calcularIdade(X,C),C>=50), Do),
                        % juntar as listas
                        append(I,Pr,App), append(App,Do,App2),
                        % eliminar os que sao da fase 1
                        repetidos(App2,R).

% Utentes candidatos a vacinacao da fase 2 que ainda so tomaram a primeira dose da vacina
candidatosVacinacaoP(2,R) :- % utentes que so tomaram a dose 1
                        vacinadosSoUmaDose(S),
                        % utentes candidatos com + de 65 anos
                        findall(X,(member(X,S),calcularIdade(X,C),C>=65), I),
                        % utentes candidatos de 50 a 64 anos com doencas da fase 2 
                        findall(X,(member(X,S),doencas2Fase(X),calcularIdade(X,C),C>=50,C=<64), Do),
                        % juntar as listas e elim repetidos
                        append(I,Do,App), repetidos(App,Rep),
                        % eliminar os que sao da fase 1
                        candidatosVacinacaoP(1,F1),
                        findall(X,(member(X,Rep),\+member(X,F1)), R).

% Utentes candidatos a vacinacao da fase 3 que ainda so tomaram a primeira dose da vacina
candidatosVacinacaoP(3,R) :- % utentes que so tomaram a dose 1
                        vacinadosSoUmaDose(S),
                        % ident utentes candidatos nao vacinados da f1 e f2
                        candidatosVacinacaoP(1,F1),
                        candidatosVacinacaoP(2,F2),
                        append(F1,F2,App), repetidos(App,Rep),
                        % identificar os restantes
                        findall(X,(member(X,S),\+member(X,Rep)), R).

% Input de fase indevido
candidatosVacinacaoP(A,R) :- \+ pertence(A,[1,2,3]) -> write('Fase invalida. As fases podem ser 1, 2 ou 3.'),
                        fail.

%---------------------------------------------

% Permitir a definição de fases de vacinação, definindo critérios de inclusão de utentes nas diferentes fases

profissao(IDU,G) :- utente(IDU,_,_,_,_,_,_,_,G,_,_).

pertenceAFase(IDU,R) :- profissao(IDU,Prof), 
                calcularIdade(IDU,Idade),
                (((doencas1Fase(IDU), Idade >= 50); Idade >= 80; Prof == 'Profissional de Saude') -> R is 1;
                ((doencas2Fase(IDU), Idade >= 50, Idade =< 64); Idade >= 65) -> R is 2;
                R is 3).

%---------------------------------------------

% Identificar pessoas vacinadas, não vacinadas e cuja segunda dose está em falta

naoVacinados(R) :- listaIdUtentes(X),
                   naoVacinadosAux(X,[],R).

naoVacinadosAux([],Acc,Acc).
naoVacinadosAux([H|T],Acc,R) :- (checkVacinado(H,Acc, 1); checkVacinado(H,Acc, 2)), naoVacinadosAux(T,Acc,R).
naoVacinadosAux([H|T],Acc,R) :- naoVacinadosAux(T,[H|Acc],R).


vacinadosSoUmaDose(R) :- % encontrar os ids de utentes candidatos
                        solucoes(IdU,utente(IdU,_,_,_,DNasc,_,_,_,P,D,_),V),
                        % encontrar o id dos que fizeram a toma 1
                        solucoes(IdU, vacinacao(_,IdU,_,_,1), T1),
                        % encontrar o id dos que fizeram a toma 2
                        solucoes(IdU, vacinacao(_,IdU,_,_,2), T2),
                        % ver os que pertencem a uma e nao ao outro
                        findall(X,(member(X,V),member(X,T1),\+member(X,T2)),R).


vacinadosDuasDoses(R) :- solucoes(UId,vacinacao(A,UId,B,C,1),L1),
                      solucoes(UId,vacinacao(A,UId,B,C,2),L2),
                      intersecao(L1,L2,R).


%---------------------------------------------

% Identificar pessoas vacinadas indevidamente
vacinacaoFaseErrada(R) :- listaIdUtentes(X),
                          vacinacaoFaseErradaAux(X,[],R).

vacinacaoFaseErradaAux([],Acc,Acc).
vacinacaoFaseErradaAux([H|T],Acc,R) :- (vacinacaoFaseErradaUtente(H,X),X = 1), vacinacaoFaseErradaAux(T,Acc,R).
vacinacaoFaseErradaAux([H|T],Acc,R) :- vacinacaoFaseErradaAux(T,[H|Acc],R).


%Ser vacinado numa fase que não lhe corresponde
vacinacaoFaseErradaUtente(UId,X) :- (checkFaseUtente(UId,R1),
                                     pertenceAFase(UId,R2)),
                                     (R1 \= R2 -> X = 0; X = 1). 


%Ser vacinado 

%Haver uma diferença de vacinas da toma 1 para a 2 (duas vacinas diferentes)
diferente(R):-
    solucoes(U_ID,vacinaDiferente(U_ID),R).

vacinaDiferente(U_ID):-
    vacinacao(_,U_ID,_,V1,1),
    vacinacao(_,U_ID,_,V2,2),
    V1 \= V2.

%Tomar mais do que duas doses
tomouMaisDe2Doses(R) :- listaIdUtentes(X),
                   		tomouMaisDe2DosesAux(X,[],R).

tomouMaisDe2DosesAux([],Acc,Acc).
tomouMaisDe2DosesAux([H|T],Acc,R) :- (quantasVacinas(H, N), N<3), tomouMaisDe2DosesAux(T,Acc,R).
tomouMaisDe2DosesAux([H|T],Acc,R) :- tomouMaisDe2DosesAux(T,[H|Acc],R).

%Ver utentes q estão num grupo de risco e não foram vacinados, ou seja, utente idu existe não mas existe vacinação(idu)
utentesRiscoSemVacinacao(R) :- candidatosVacinacaoT(1,L1), candidatosVacinacaoT(2,L2),
                               append(L1,L2,L3), repetidos(L3,R).

%Import dos dados
:- include('dados.pl').


