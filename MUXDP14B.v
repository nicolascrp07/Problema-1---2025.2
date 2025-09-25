// Módulo que implementa um multiplexador (MUX) de 2 para 1 para barramentos de 4 bits.
module MUXDP14B(
    output [3:0] S,    // Barramento de 4 bits de saída com o dado selecionado.

    input [3:0] A,     // Barramento de 4 bits do primeiro termo.
    input [3:0] B,     // Barramento de 4 bits do segundo termo.
    input Sel          // Bit de seleção que determina a escolha.
);
    // A implementação usa 4 instâncias do MUX de 1 bit (MUXDP1).
    // Cada instância é responsável por selecionar um bit correspondente dos barramentos.

    // Seleciona entre A[0] e B[0] para a saída S[0].
    MUXDP1 mux_bit0 (.S(S[0]), .A(A[0]), .B(B[0]), .Sel(Sel));
    // Seleciona entre A[1] e B[1] para a saída S[1].
    MUXDP1 mux_bit1 (.S(S[1]), .A(A[1]), .B(B[1]), .Sel(Sel));
    // Seleciona entre A[2] e B[2] para a saída S[2].
    MUXDP1 mux_bit2 (.S(S[2]), .A(A[2]), .B(B[2]), .Sel(Sel));
    // Seleciona entre A[3] e B[3] para a saída S[3].
    MUXDP1 mux_bit3 (.S(S[3]), .A(A[3]), .B(B[3]), .Sel(Sel));
	 
endmodule