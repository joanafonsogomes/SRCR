% ---------------------------------
% Evolução de Conhecimento
% ---------------------------------

evolucaoC(T) :- solucoes(I, +T::I, L),
                insercao(T),
                testaPredicados(L)

solucoes(T,Q,S) :- findall(T,Q,S).

insercao(Q) :- assert(Q).
insercao(Q) :- retract(Q), !, fail.

testaPredicados([]).
testaPredicados([I|L]) :- I, testaPredicados(L).

% ----- Conhecimento Perfeito -----

% Conhecimento Perfeito Positivo