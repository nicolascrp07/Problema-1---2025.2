// Módulo que implementa a lógica Soma 3 se for maior ou igual a 5.
module SomaMais3_Condicional(
    output [3:0] Saida,    // O resultado final.

    input  [3:0] Entrada   // O valor de 4 bits a ser avaliado.
);
    wire maior_igual_5;    // Flag que se torna '1' se a Entrada for >= 5.
    wire [3:0] soma_com_3; // Armazena o resultado da soma Entrada + 3.
    wire vai_um;           // Carry out do somador.

    // Compara a entrada com o valor 5.
    ComparadorMaiorIgual5 comp(maior_igual_5, Entrada);

    // Em paralelo, calcula a soma da entrada com o valor 3 em binário.
    Somador4Bits som(.S(soma_com_3), .Cout(vai_um), .A(Entrada), .B(4'b0011), .Cin(1'b0));

    // Se 'maior_igual_5' for 1, a saída é o resultado da soma (Entrada + 3).
    // Se 'maior_igual_5' for 0, a saída é a própria Entrada, sem alteração.
    MUXDP14B mux(.S(Saida), .A(Entrada), .B(soma_com_3), .Sel(maior_igual_5));
    
endmodule