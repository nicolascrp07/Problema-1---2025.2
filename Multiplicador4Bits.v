// Módulo que implementa um multiplicador de 4x4 bits.
module Multiplicador4Bits(
    output [7:0] Produto, // O resultado final da multiplicação, que pode ter até 8 bits.
    
    input  [3:0] A,       // Operando multiplicando de 4 bits.
    input  [3:0] B        // Operando multiplicador de 4 bits.
);

    // Produtos Parciais: Cada pp é o resultado de A * um bit de B.
    wire [3:0] pp0, pp1, pp2, pp3;

    // Fios para os resultados de soma e carry do primeiro estágio de somadores.
    wire [2:0] soma_E1;
    wire [3:0] carry_E1; 

    // Fios para os resultados de soma e carry do segundo estágio de somadores.
    wire [2:0] soma_E2;
    wire [3:0] carry_E2; 

    // Fios para os carries do último estágio de somadores.
    wire [2:0] carry_E3; 


    // Cada módulo ProdutoParcial multiplica a entrada A por um bit da entrada B.
    ProdutoParcial Gerador_PP0 (.Out(pp0), .A(A), .B_i(B[0])); // pp0 = A * B[0]
    ProdutoParcial Gerador_PP1 (.Out(pp1), .A(A), .B_i(B[1])); // pp1 = A * B[1]
    ProdutoParcial Gerador_PP2 (.Out(pp2), .A(A), .B_i(B[2])); // pp2 = A * B[2]
    ProdutoParcial Gerador_PP3 (.Out(pp3), .A(A), .B_i(B[3])); // pp3 = A * B[3]

    // Os produtos parciais são somados em cascata.

    // A coluna do bit 0 é apenas o Bit Menos Significante do primeiro produto parcial.
    MeioSomador MS00(Produto[0], ,pp0[0], 1'b0); 

    // Primeira linha de soma: soma pp0 e pp1 (deslocado).
    MeioSomador MS_E1_C0(Produto[1], carry_E1[0], pp0[1], pp1[0]);
    Somador1Bit SC_E1_C1(soma_E1[0], carry_E1[1], pp0[2], pp1[1], carry_E1[0]);
    Somador1Bit SC_E1_C2(soma_E1[1], carry_E1[2], pp0[3], pp1[2], carry_E1[1]);
    MeioSomador MS_E1_C3(soma_E1[2], carry_E1[3], pp1[3], carry_E1[2]);

    // Segunda linha de soma: soma o resultado anterior (soma_E1) com pp2 (deslocado).
    MeioSomador MS_E2_C0(Produto[2], carry_E2[0], soma_E1[0], pp2[0]);
    Somador1Bit SC_E2_C1(soma_E2[0], carry_E2[1], soma_E1[1], pp2[1], carry_E2[0]);
    Somador1Bit SC_E2_C2(soma_E2[1], carry_E2[2], soma_E1[2], pp2[2], carry_E2[1]);
    Somador1Bit SC_E2_C3(soma_E2[2], carry_E2[3], carry_E1[3], pp2[3], carry_E2[2]);

    // Terceira linha de soma: soma o resultado anterior (soma_E2) com pp3 (deslocado).
    // As saídas desta linha são os bits finais do produto.
    MeioSomador MS_E3_C0(Produto[3], carry_E3[0], soma_E2[0], pp3[0]);
    Somador1Bit SC_E3_C1(Produto[4], carry_E3[1], soma_E2[1], pp3[1], carry_E3[0]);
    Somador1Bit SC_E3_C2(Produto[5], carry_E3[2], soma_E2[2], pp3[2], carry_E3[1]);
    // O último somador gera os dois bits mais significativos do produto.
    Somador1Bit SC_E3_C3(Produto[6], Produto[7], carry_E2[3], pp3[3], carry_E3[2]);

endmodule