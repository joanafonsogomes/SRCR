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

% ------- Carregar predicados -------

:- include('conhecimento.pl').
:- include('evolucao.pl').
:- include('involucao.pl').
:- include('auxiliares.pl').
:- include('invariantes.pl').

% -- PMF para Utente, Staff e Fase --

-utente(Id, NSS, N, G, DN, E, T, M, P, DC, IdCentro) :-
    nao(utente(Id, NSS, N, G, DN, E, T, M, P, DC, IdCentro)),
    nao(excecao(utente(Id, NSS, N, G, DN, E, T, M, P, DC, IdCentro))).
    
-staff(Id, IdCentro, N, E) :-
    nao(staff(Id, IdCentro, N, E)),
    nao(excecao(staff(Id, IdCentro, N, E))).
    
-fase(Id, DI, DF) :-
    nao(fase(Id, DI, DF)),
    nao(excecao(fase(Id, DI, DF))).

% ----- Sistema de Inferência ------

si(Q, verdadeiro) :- Q.
si(Q, falso) :- -Q.
si(Q, desconhecido) :- nao(Q),
                       nao(-Q).