% Auxiliares

% Insere conhecimento na base de conhecimento
novoConhecimento(T) :- solucoes(I, +T::I, Linv),
                        insercao(T),
                        teste(Linv).

% Ver se o gérnero é válido
generoValido('M').
generoValido('F').

% Calcular idade