% ---------------------------------
% Evolucao de Conhecimento
% ---------------------------------

% ----- Evolucao Conhecimento Perfeito -----

evolucaoC(T) :- solucoes(I, +T::I, L),
                insercao(T),
                testaPredicados(L).

solucoes(T,Q,S) :- findall(T,Q,S).

insercao(Q) :- assert(Q).
insercao(Q) :- retract(Q), !, fail.

testaPredicados([]).
testaPredicados([I|L]) :- I, testaPredicados(L).

% Conhecimento Perfeito Positivo

% UTENTE: Idutente, Nº Segurança_Social, Nome, Genero, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde
novoUtente(Id,N,NISS,G,Dn,E,Tlf,M,P,Dc,IdCs) :- evolucaoC(utente(Id,N,NISS,G,Dn,E,Tlf,M,P,Dc,IdCs)).

% STAFF: IdStaff, Nome, NSS, Email, IdCentroSaude
novoStaff(Id,N,NSS,E,Cs) :- evolucaoC(staff(Id,N,NSS,E,Csx)).

% CENTROS DE SAUDE: IdCentro, Nome, Morada, Telefone, Email
novoCentro(Id,N,M,Tlf,E) :- evolucaoC(centro(Id,N,M,Tlf,E)).

% VACINAÇÕES: IdStaff, IdUtente, Data, Vacina, Toma
novaVacinacao(IdS,IdU,D,V,T) :- evolucaoC(vacinacao(IdS,IdU,D,V,T)).


% Conhecimento Perfeito Negativo

evolucaoC(T,conheNeg) :- solucoes(I, +(-T)::I, L),
                insercao(-T),
                testaPredicados(L).


% ----- Evolucao do Conhecimento Imperfeito -----

% Evolucao do Conhecimento Imperfeito Incerto

% UTENTE

% Inserir Conhecimento Perfeito Incerto para utente com email desconhecido
evolucaoC(utente(Id,N,Nu,G,DN,email_desconhecido,T,M,P,DC,IdCentro), utente, conheImpInc, email) :-
    evolucaoC(utente(Id,N,Nu,G,DN,email_desconhecido,T,M,P,DC,IdCentro)),
    insercao((excecao(utente(Id,N,Nu,G,DN,E,T,M,P,DC,IdCentro)) :- utente(Id,N,Nu,G,DN,email_desconhecido,T,M,P,DC,IdCentro))).

% Inserir Conhecimento Perfeito Incerto para utente com telefone desconhecido
evolucaoC(utente(Id,N,Nu,G,DN,E,tlf_desconhecido,M,P,DC,IdCentro), utente, conheImpInc, tlf) :-
    evolucaoC(utente(Id,N,Nu,G,DN,E,tlf_desconhecido,M,P,DC,IdCentro)),
    insercao((excecao(utente(Id,N,Nu,G,DN,E,T,M,P,DC,IdCentro)) :- utente(Id,N,Nu,G,DN,E,tlf_desconhecido,M,P,DC,IdCentro))).

% Inserir Conhecimento Perfeito Incerto para utente com morada desconhecida
evolucaoC(utente(Id,N,Nu,G,DN,E,T,morada_desconhecida,P,DC,IdCentro), utente, conheImpInc, morada) :-
    evolucaoC(utente(Id,N,Nu,G,DN,E,T,morada_desconhecida,P,DC,IdCentro)),
    insercao((excecao(utente(Id,N,Nu,G,DN,E,T,M,P,DC,IdCentro)) :- utente(Id,N,Nu,G,DN,E,T,morada_desconhecida,P,DC,IdCentro))).

% STAFF

% Inserir Conhecimento Perfeito Incerto para membro do staff com email desconhecido
evolucaoC(staff(Id,IdC,N,email_desconhecido), staff, conheImpInc, email) :-
    evolucaoC(staff(Id,IdC,N,email_desconhecido)),
    insercao((excecao(staff(Id,IdC,N,E)) :- staff(Id,IdC,N,email_desconhecido))).




% Evolucao do Conhecimento Imperfeito Impreciso

% Evolucao do Conhecimento Imperfeito Interdito
