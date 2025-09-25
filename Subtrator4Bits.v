// Módulo que implementa um subtrator completo de 4 bits.
module Subtrator4Bits(
    output [3:0] D,      // Vetor de 4 bits para o resultado final da subtração.
    output       Bout,   // Borrow out final.
    output       C3,     // Borrow intermediário.
    
    input  [3:0] A,      // Vetor de 4 bits do minuendo.
    input  [3:0] B,      // Vetor de 4 bits do subtraendo.
    input        Bin     // Borrow de entrada.
);

    wire b1, b2, b3; // Fios para conectar o borrow out de um estágio ao borrow in do próximo.

    // Instanciação de 4 subtratores de 1 bit para construir o subtrator de 4 bits.
    // Cada instância calcula a diferença de um par de bits e propaga o empréstimo.

    // P0: Subtrai o bit 0 (LSB) e gera o primeiro borrow (b1).
    Subtrator1Bit P0 (
        .D(D[0]),
        .Bout(b1),
        .A(A[0]),
        .B(B[0]),
        .Bin(Bin)
    );

    // P1: Subtrai o bit 1, usando o borrow b1 do estágio anterior. Gera o borrow b2.
    Subtrator1Bit P1 (
        .D(D[1]),
        .Bout(b2),
        .A(A[1]),
        .B(B[1]),
        .Bin(b1)
    );

    // P2: Subtrai o bit 2, usando o borrow b2 do estágio anterior. Gera o borrow b3.
    Subtrator1Bit P2 (
        .D(D[2]),
        .Bout(b3),
        .A(A[2]),
        .B(B[2]),
        .Bin(b2)
    );

    // P3: Subtrai o bit 3 (MSB), usando o borrow b3. Gera o Bout final do subtrator.
    Subtrator1Bit P3 (
        .D(D[3]),
        .Bout(Bout),
        .A(A[3]),
        .B(B[3]),
        .Bin(b3)
    );

    // A operação AND com '1' simplesmente repassa o valor de b3.
    and AND_C3(C3, b3, 1'b1);

endmodule