% ---------------------------------
% Evolucao de Conhecimento
% ---------------------------------

% ----- Evolucao Conhecimento Perfeito -----

% Inserir conhecimento
evolucaoC(T) :- solucoes(I, +T::I, L),
                insercao(T),
                testaPredicados(L).

% ----------------------------------------------

% Conhecimento Perfeito Positivo

% (usar o evolucaoC)

% ----------------------------------------------

% Conhecimento Perfeito Negativo

% Inserir Conhecimento Perfeito Negativo
evolucaoC(T,conheNeg) :- solucoes(I, +(-T)::I, L),
                        insercao(-T),
                        testaPredicados(L).


% ----- Evolucao do Conhecimento Imperfeito -----

% Evolucao do Conhecimento Imperfeito Incerto

% UTENTE

% Inserir Conhecimento Perfeito Incerto para utente com email desconhecido
evolucaoC(utente(Id,N,Nu,G,DN,email_desconhecido,T,M,P,DC,IdCentro), utente, conheImpInc, email) :- evolucaoC(utente(Id,N,Nu,G,DN,email_desconhecido,T,M,P,DC,IdCentro)),
                                                                                                    insercao((excecao(utente(Id,N,Nu,G,DN,_,T,M,P,DC,IdCentro)) :- 
                                                                                                        utente(Id,N,Nu,G,DN,email_desconhecido,T,M,P,DC,IdCentro))).

% Inserir Conhecimento Perfeito Incerto para utente com telefone desconhecido
evolucaoC(utente(Id,N,Nu,G,DN,E,tlf_desconhecido,M,P,DC,IdCentro), utente, conheImpInc, tlf) :- evolucaoC(utente(Id,N,Nu,G,DN,E,tlf_desconhecido,M,P,DC,IdCentro)),
                                                                                                insercao((excecao(utente(Id,N,Nu,G,DN,E,_,M,P,DC,IdCentro)) :- 
                                                                                                    utente(Id,N,Nu,G,DN,E,tlf_desconhecido,M,P,DC,IdCentro))).

% Inserir Conhecimento Perfeito Incerto para utente com morada desconhecida
evolucaoC(utente(Id,N,Nu,G,DN,E,T,morada_desconhecida,P,DC,IdCentro), utente, conheImpInc, morada) :- evolucaoC(utente(Id,N,Nu,G,DN,E,T,morada_desconhecida,P,DC,IdCentro)),
                                                                                        insercao((excecao(utente(Id,N,Nu,G,DN,E,T,_,P,DC,IdCentro)) :- 
                                                                                            utente(Id,N,Nu,G,DN,E,T,morada_desconhecida,P,DC,IdCentro))).

% STAFF

% Inserir Conhecimento Perfeito Incerto para membro do staff com email desconhecido
evolucaoC(staff(Id,IdC,N,email_desconhecido), staff, conheImpInc, email) :- evolucaoC(staff(Id,IdC,N,email_desconhecido)),
                                                                        insercao((excecao(staff(Id,IdC,N,_)) :- 
                                                                            staff(Id,IdC,N,email_desconhecido))).

% ----------------------------------------------

% Evolucao do Conhecimento Imperfeito Impreciso

% Inserir Conhecimento Imperfeito Impreciso 

evolucaoC(T, conheImpImp) :- solucoes(I, +(excecao(T))::I, Lint),
                            insercao(excecao(T)),
                            testaPredicados(Lint).

% ----------------------------------------------

% Evolucao do Conhecimento Imperfeito Interdito

% UTENTE

% Inserir Conhecimento Imperfeito Interdito para utente com email impossivel de saber
evolucaoC(utente(Id,N,Nu,G,DN,email_impossivel,T,M,P,DC,IdCentro), utente, conheImpInt, email) :-
    evolucao(utente(Id,N,Nu,G,DN,email_impossivel,T,M,P,DC,IdCentro)),
    insercao((excecao(utente(Id,N,Nu,G,DN,_,T,M,P,DC,IdCentro)) :-
                utente(Id,N,Nu,G,DN,email_impossivel,T,M,P,DC,IdCentro))),
    insercao((nulointerdito(email_impossivel))).

% STAFF

% Inserir Conhecimento Imperfeito Interdito para membro do staff com email impossivel de saber
evolucaoC(staff(Id,IdC,N,email_impossivel), staff, conheImpInt, email) :-
    evolucaoC(staff(Id,IdC,N,email_impossivel)),
    insercao((excecaoC(staff((Id,IdC,N,_))) :-
                staff(Id,IdC,N,email_impossivel))),
    insercao((nulointerdito(email_impossivel))).
