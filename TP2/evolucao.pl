% ---------------------------------
% Evolução de Conhecimento
% ---------------------------------

% ----- Conhecimento Perfeito -----

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

% STAFF: IdStaff, IdCentro, Nome, Email
novoStaff(Id,NSS,IdCs,N,E) :- evolucaoC(staff(Id,NSS,IdCs,N,E)).

% CENTROS DE SAUDE: IdCentro, Nome, Morada, Telefone, Email
novoCentro(Id,N,M,Tlf,E) :- evolucaoC(centro(Id,N,M,Tlf,E)).

% VACINAÇÕES: IdStaff, IdUtente, Data, Vacina, Toma
novaVacinacao(IdS,IdU,D,V,T) :- evolucaoC(vacinacao(IdS,IdU,D,V,T)).






% Conhecimento Perfeito Negativo

evolucaoC(T,neg) :- solucoes(I, +(-T)::I, L),
                insercao(-T),
                testaPredicados(L).

% ----- Conhecimento Imperfeito -----

% Conhecimento Imperfeito Incerto