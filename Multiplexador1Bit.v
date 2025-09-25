// Módulo que implementa um multiplexador (MUX) de 8 para 1.
module Multiplexador1Bit( S, A, B, C, D, E, F, G, H, Sel0, Sel1, Sel2);
    input A, B, C, D, E, F, G, H;  // As 8 linhas de dados de entrada.
    input Sel0, Sel1, Sel2;         // As 3 linhas de seleção.

    output S;                       // A saída de 1 bit.

    wire T1, T2, T3, T4, T5, T6, T7, T8; // Fios para os resultados dos 8 caminhos de dados.
    wire notS0, notS1, notS2;           // Fios para os sinais de seleção invertidos.

    // Inverte os sinais de seleção.
	 not Not0(notS0, Sel0);
	 not Not1(notS1, Sel1);
	 not Not2(notS2, Sel2);
	 
    // A lógica de seleção é implementada com portas AND. Cada porta corresponde a uma entrada.
    // 000 -> A
    and And0(T1, notS2, notS1, notS0, A);
    // 001 -> B
    and And1(T2, notS2, notS1, Sel0, B);
    // 010 -> C
	 and And2(T3, notS2, Sel1, notS0, C);
    // 011 -> D
	 and And3(T4, notS2, Sel1, Sel0, D);
    // 100 -> E
	 and And4(T5, Sel2, notS1, notS0, E);
    // 101 -> F
	 and And5(T6, Sel2, notS1, Sel0, F);
    // 110 -> G
	 and And6(T7, Sel2, Sel1, notS0, G);
    // 111 -> H
	 and And7(T8, Sel2, Sel1, Sel0, H);
	 
    // A porta OR combina os resultados.
    or Or0(S, T1, T2, T3, T4, T5, T6, T7, T8);
endmodule