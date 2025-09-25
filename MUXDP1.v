// Módulo que implementa um multiplexador (MUX) de 2 para 1.
module MUXDP1( S, A, B, Sel);
    input A, B;   // As 2 linhas de dados de entrada.
    input Sel;    // A linha de seleção.

    output S;      // A saída de 1 bit com o dado selecionado.

    wire T1, T2, notS; // Fios para os dados e a seleção invertida.

    // Inverte o sinal de seleção.
	 not NotS(notS, Sel);
	 
    // Se Sel = 0, o caminho de A (T1) é ativado.
    and And0(T1, notS, A);
    // Se Sel = 1, o caminho de B (T2) é ativado.
    and And1(T2, Sel, B);
    
    // A porta OR combina os dois caminhos.
    or Or0(S, T1, T2);
endmodule