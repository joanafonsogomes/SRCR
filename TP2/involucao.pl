% ---------------------------------
% Involução de Conhecimento
% ---------------------------------


% ----- Involucao Conhecimento Perfeito -----

% Remover conhecimento
involucaoC(T) :- solucoes(I, -T::I, L),
                remocao(T),
                testaPredicados(L).

% ----------------------------------------------

% Involucao do Conhecimento Perfeito Positivo

% ( involucaoC )

% ----------------------------------------------

% Involucao do Conhecimento Perfeito Negativo

involucaoC(T,conheNeg) :- solucoes(I, -(-T)::I, L),
                        remocao(-T),
                        testaPredicados(L).

% ----- Involucao do Conhecimento Imperfeito -----

% Involucao do Conhecimento Imperfeito Incerto

% UTENTE

% Remover Conhecimento Perfeito Incerto para utente com email desconhecido
involucaoC(utente(Id,N,Nu,G,DN,email_desconhecido,T,M,P,DC,IdCentro), utente, conheImpInc, email) :- involucaoC(utente(Id,N,Nu,G,DN,email_desconhecido,T,M,P,DC,IdCentro)),
                                                                                                    remocao((excecao(utente(Id,N,Nu,G,DN,_,T,M,P,DC,IdCentro)) :- 
                                                                                                        utente(Id,N,Nu,G,DN,email_desconhecido,T,M,P,DC,IdCentro))).

% Remover Conhecimento Perfeito Incerto para utente com telefone desconhecido
involucaoC(utente(Id,N,Nu,G,DN,E,tlf_desconhecido,M,P,DC,IdCentro), utente, conheImpInc, tlf) :- involucaoC(utente(Id,N,Nu,G,DN,E,tlf_desconhecido,M,P,DC,IdCentro)),
                                                                                                remocao((excecao(utente(Id,N,Nu,G,DN,E,_,M,P,DC,IdCentro)) :- 
                                                                                                    utente(Id,N,Nu,G,DN,E,tlf_desconhecido,M,P,DC,IdCentro))).

% Remover Conhecimento Perfeito Incerto para utente com morada desconhecida
involucaoC(utente(Id,N,Nu,G,DN,E,T,morada_desconhecida,P,DC,IdCentro), utente, conheImpInc, morada) :- involucaoC(utente(Id,N,Nu,G,DN,E,T,morada_desconhecida,P,DC,IdCentro)),
                                                                                        remocao((excecao(utente(Id,N,Nu,G,DN,E,T,_,P,DC,IdCentro)) :- 
                                                                                            utente(Id,N,Nu,G,DN,E,T,morada_desconhecida,P,DC,IdCentro))).

% STAFF

% Remover Conhecimento Perfeito Incerto para membro do staff com email desconhecido
involucaoC(staff(Id,IdC,N,email_desconhecido), staff, conheImpInc, email) :- involucaoC(staff(Id,IdC,N,email_desconhecido)),
                                                                        remocao((excecao(staff(Id,IdC,N,_)) :- staff(Id,IdC,N,email_desconhecido))).

% ----------------------------------------------

% Involucao do Conhecimento Imperfeito Impreciso

% Remover Conhecimento Imperfeito Impreciso

involucaoC(T, conheImpImp) :- solucoes(I, -(excecao(T))::I, Lint),
                            remocao(excecao(T)),
                            testaPredicados(Lint).

% ----------------------------------------------

% Evolucao do Conhecimento Imperfeito Interdito

% UTENTE

% Retirar Conhecimento Imperfeito Interdito para utente com email impossivel de saber
involucaoC(utente(Id,N,Nu,G,DN,email_impossivel,T,M,P,DC,IdCentro), utente, conheImpInt, email) :-
    involucaoC(utente(Id,N,Nu,G,DN,email_impossivel,T,M,P,DC,IdCentro)),
    remocao((excecao(utente(Id,N,Nu,G,DN,_,T,M,P,DC,IdCentro)) :-
                utente(Id,N,Nu,G,DN,email_impossivel,T,M,P,DC,IdCentro))),
    remocao((nulointerdito(email_impossivel))).

% Retirar Conhecimento Imperfeito Interdito para membro do staff com email impossivel de saber
involucaoC(staff(Id,IdC,N,email_impossivel), staff, conheImpInt, email) :-
    involucaoC(staff(Id,IdC,N,email_impossivel)),
    remocao((excecaoC(staff((Id,IdC,N,_))) :-
                staff(Id,IdC,N,email_impossivel))),
    remocao((nulointerdito(email_impossivel))).
