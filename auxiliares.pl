% Auxiliares

% Insere conhecimento na base de conhecimento
novoConhecimento(T) :- solucoes(I, +T::I, Linv),
                        insercao(T),
                        teste(Linv).

/* % Verificar se o gérnero é válido
generoValido('M').
generoValido('F').

% Verificar se a data é válida : Data -> {V,F}
data(Dia,Mes,Ano) :- anoValido(Ano), mesValido(Mes), diaValido(Dia,Mes).

% Verificar se o ano é válido : Ano -> {V,F}
anoValido(Ano) :- natural(Ano), Ano > 1890 , Ano < 2020.

%  : Mes -> {V,F}
mesValido(Mes) :- natural(Mes), Mes < 13.

% Verificar se o dia é válido: Dia, Mes, Ano -> {V,F}
diaValido(Dia,Mes) :- pertence(Mes,[1,3,5,7,8,10,12]),
                    natural(Dia),
                    Dia < 32.
diaValido(Dia,Mes) :- pertence(Mes,[4,6,9,11]),
                        natural(Dia),
                        Dia < 31.

diaValido(Dia,2) :- natural(Dia), Dia < 29. % não estamos a albergar anos bissextos...*/

% Verifica se a segunda data e anterior a primeira
comparaDatas(datime(AH,MH,DH,,,_),data(AP,MP,DP)) :-
    AP < AH;
    (AP =:= AH, (MP < MH;
                (MP =:= MH, DP < DH))).

% Verifica se uma data e valida
dataValida(data(A,M,D)) :- (pertence(M,[1,3,5,7,8,10,12]), D >= 1, D =< 31);
                            (pertence(M,[4,6,9,11]), D >= 1, D =< 30);
                            (M =:= 2, (mod(A,4) =:= 0, D >= 1, D =< 29);
                            (D >= 1, D =< 28)).

% Verifica se um contrato ainda esta em vigor
prazoExpirado(data(A,M,D), P) :- calculaPrazo(A,M,D,P,Prazo),
                                datime(Hoje), !,
                                comparaDatas(Hoje,Prazo).

% Calcular idade