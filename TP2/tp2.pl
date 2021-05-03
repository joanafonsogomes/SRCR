% -----------------------------------
% SRCR TP2
% -----------------------------------


% ------ Declarações Iniciais -------

:- set_prolog_flag(discontiguous_warnings,off).
:- set_prolog_flag(single_var_warnings,off).
:- set_prolog_flag(unknown,fail).

:- op(900,xfy,'::').
:- op(1100,xfy,'??').

:- dynamic '-'/1.
:- dynamic utente/11.
:- dynamic staff/5.
:- dynamic centro/5.
:- dynamic vacinacao/5.
:- dynamic fase/3.

:- dynamic excecao/1.
:- dynamic nulointerdito/1.

:- discontiguous '-'/1.
:- discontiguous utente/11.
:- discontiguous staff/5.
:- discontiguous centro/5.
:- discontiguous vacinacao/5.
:- discontiguous fase/3.

:- discontiguous excecao/1.
:- discontiguous nulointerdito/1.
:- discontiguous (::)/2.
:- discontiguous evolucaoC/2.
:- discontiguous evolucaoC/4.

% ------- Carregar predicados -------

:- include('conhecimento.pl').
:- include('evolucao.pl').
:- include('involucao.pl').
:- include('auxiliares.pl').
:- include('invariantes.pl').


% -- PMF para Utente, Staff, Vacinação e Fase --

-utente(Id, NSS, N, G, DN, E, T, M, P, DC, IdCentro) :-
    nao(utente(Id, NSS, N, G, DN, E, T, M, P, DC, IdCentro)),
    nao(excecao(utente(Id, NSS, N, G, DN, E, T, M, P, DC, IdCentro))).
    
-staff(Id, IdCentro, N, E) :-
    nao(staff(Id, IdCentro, N, E)),
    nao(excecao(staff(Id, IdCentro, N, E))).

-vacinacao(IdStaff, IdUtente, D, V, T) :-
    nao(vacinacao(IdStaff, IdUtente, D, V, T)),
    nao(excecao(vacinacao(IdStaff, IdUtente, D, V, T))).
    
-fase(Id, DI, DF) :-
    nao(fase(Id, DI, DF)),
    nao(excecao(fase(Id, DI, DF))).

% ----- Sistema de Inferência ------

% Extensao do meta-predicado si
% que responde a uma única questão
si(Q, verdadeiro) :- Q.
si(Q, falso) :- -Q.
si(Q, desconhecido) :- nao(Q),
                       nao(-Q).

% extensão do meta predicado siLista que dada uma lista de questões
% responde às várias colocando as respostas numa lista
siLista([], []).
siLista([Q|Qs], R) :- si(Q, X),
                      siLista(Qs, Y),
                      R = [X|Y].

% % Extensao do predicado conjuncao 
conjuncao(verdadeiro, verdadeiro, verdadeiro).
conjuncao(falso, _, falso).
conjuncao(_, falso, falso).
conjuncao(verdadeiro, desconhecido, desconhecido).
conjuncao(desconhecido, verdadeiro, desconhecido).
conjuncao(desconhecido, desconhecido, desconhecido).

% Extensao do predicado siConjuncao que dado uma lista de questões
% obtém como resposta a conjunção das várias respostas das questões.  
siConjuncao([],verdadeiro).
siConjuncao([Q|Qs], R) :- si(Q, R1), 
                          siConjuncao(Qs,R2),
                          conjuncao(R1,R2,R).

% Extensao do predicado disjuncao 
disjuncao(verdadeiro, _, verdadeiro).
disjuncao(_, verdadeiro, verdadeiro).
disjuncao(falso, falso, falso).
disjuncao(falso, desconhecido, desconhecido).
disjuncao(desconhecido, falso, desconhecido).
disjuncao(desconhecido, desconhecido, desconhecido).

% Extensao do predicado siDisjuncao que dado uma lista de questões
% obtém como resposta a disjunção das várias respostas das questões.  
siDisjuncao([],verdadeiro).
siDisjuncao([Q|Qs], R) :- si(Q, R1), 
                          siDisjuncao(Qs,R2),
                          disjuncao(R1,R2,R).