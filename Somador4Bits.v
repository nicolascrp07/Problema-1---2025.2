// Módulo que implementa um somador completo de 4 bits.
module Somador4Bits(
    output [3:0] S,      // Vetor de 4 bits para o resultado final da soma.
    output       Cout,   // Carry out final.
    output       C3,     // Carry intermediário da posição 2 para 3.
    
    input  [3:0] A,      // Vetor de 4 bits do primeiro operando.
    input  [3:0] B,      // Vetor de 4 bits do segundo operando.
    input        Cin     // Carry de entrada inicial.
);
    wire c1, c2, c3; // Fios para conectar o carry out de um estágio ao carry in do próximo.

    // Instanciação de 4 somadores de 1 bit para construir o somador de 4 bits.
    // Cada instância calcula a soma de um par de bits e propaga o carry.

    // P0: Soma o bit 0 (LSB) e gera o primeiro carry (c1).
    Somador1Bit P0 (
        .S(S[0]),
        .Cout(c1),
        .A(A[0]),
        .B(B[0]),
        .Cin(Cin)
    );

    // P1: Soma o bit 1, usando o carry c1 do estágio anterior. Gera o carry c2.
    Somador1Bit P1 (
        .S(S[1]),
        .Cout(c2),
        .A(A[1]),
        .B(B[1]),
        .Cin(c1)
    );

    // P2: Soma o bit 2, usando o carry c2 do estágio anterior. Gera o carry c3.
    Somador1Bit P2 (
        .S(S[2]),
        .Cout(c3),
        .A(A[2]),
        .B(B[2]),
        .Cin(c2)
    );

    // P3: Soma o bit 3 (MSB), usando o carry c3. Gera o Cout final do somador.
    Somador1Bit P3 (
        .S(S[3]),
        .Cout(Cout),
        .A(A[3]),
        .B(B[3]),
        .Cin(c3)
    );

    // A operação AND com '1' não altera o valor de c3.
    and AND_C3(C3, c3, 1'b1);

endmodule