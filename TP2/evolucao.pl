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

evolucaoC(utente(Id,N,Nu,G,DN,email_desconhecido,T,M,P,DC,IdCentro), utente, conheImpInc, email) :-
    evolucao(utente(Id,N,Nu,G,DN,email_desconhecido,T,M,P,DC,IdCentro)),
    insercao((excecao(utente(Id,N,Nu,G,DN,E,T,M,P,DC,IdCentro)) :- utente(Id,N,Nu,G,DN,email_desconhecido,T,M,P,DC,IdCentro))).

% Utente com ID U13 do qual nao se sabe o email 
utente('U13','Adelia Amaral','41527730111','F','1944-09-26',email_desconhecido,910419566,'Rua Doutor Joao Afonso Almeida Azurem 4800-004 Guimaraes','Bioquimico',[],'C2').
excecao(utente(Id,N,Nu,G,DN,E,T,M,P,DC,IdCentro)) :- utente(Id,N,Nu,G,DN,email_desconhecido,T,M,P,DC,IdCentro).

% Utente com ID U4 do qual nao se sabe o telefone
utente('U4','Cinderela Nogueira','50775228700','F','1950-12-08','CinderelaNogueira@outlook.com',tlf_desconhecido,'Rua Paulo Vi 4700-004 Braga','Auxiliar de limpeza',[],'C2').
excecao(utente(Id,N,Nu,G,DN,E,T,M,P,DC,IdCentro)) :- utente(Id,N,Nu,G,DN,E,tlf_desconhecido,M,P,DC,IdCentro).

% Utente com ID U10 do qual nao se sabe a morada
utente('U10','Jansenio Figueiredo','02069412938','M','1983-02-02','JansenioFigueiredo218@outlook.com',914112112,morada_desconhecida,'Comissario de bordo',[],'C2').
excecao(utente(Id,N,Nu,G,DN,E,T,M,P,DC,IdCentro)) :- utente(Id,N,Nu,G,DN,E,T,morada_desconhecida,P,DC,IdCentro).



% Evolucao do Conhecimento Imperfeito Impreciso

% Evolucao do Conhecimento Imperfeito Interdito
