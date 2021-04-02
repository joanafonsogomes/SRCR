% ---------------------------------
% SRCR TP1
% ---------------------------------

% -- INCLUDES --
:- include('auxiliares.pl').
:- include('baseconhecimento.pl').

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- op(900,xfy,'::').
:- dynamic utente/9.
:- dynamic staff/4.
:- dynamic centro/6.
:- dynamic vacinacao/5.

% -- UTENTES --
% Valido para a 1F?


% Valido para a 2F?


%------------------
% REGISTRAR utentes, staff, centros de saude e vacinações
%------------------

% UTENTE: Idutente, Nº Segurança_Social, Nome, Genero, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde
novoUtente(Id,NISS,N,G,Dn,E,Tlf,M,P,Dc,IdCs) :- novoConhecimento(utente(Id,NISS,Nome,G,Dn,E,Tlf,M,P,Dc,Cs)).

% STAFF: IdStaff, IdCentro, Nome, Email
novoStaff(Id,IdCs,N,E) :- novoConhecimento(staff(Id,IdCs,N,E)).

% CENTROS DE SAUDE: IdCentro, Nome, Morada, Telefone, Email
novoCentro(Id,IdCs,N,M,Tlf,E) :- novoConhecimento(centro(Id,IdCs,N,M,Tlf,E)).

% VACINAÇÕES: IdStaff, IdUtente, Data, Vacina, Toma
novaVacinacao(IdS,IdU,D,V,T) :- novoConhecimento(vacinacao(IdS,IdU,D,V,T)).
