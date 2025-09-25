// Módulo que realiza a operação AND entre dois vetores de 4 bits.
module And4Bits (
    output [3:0] S, // O vetor de 4 bits resultante.
    input [3:0] A,
    input [3:0] B
);

    // A implementação usa 4 instâncias do módulo And1Bit, uma para cada par de bits.
    // S[0] = A[0] AND B[0]
    And1Bit porta_and_0 (
        .S(S[0]),
        .A(A[0]),
        .B(B[0])
    );

    // S[1] = A[1] AND B[1]
    And1Bit porta_and_1 (
        .S(S[1]),
        .A(A[1]),
        .B(B[1])
    );

    // S[2] = A[2] AND B[2]
    And1Bit porta_and_2 (
        .S(S[2]),
        .A(A[2]),
        .B(B[2])
    );

    // S[3] = A[3] AND B[3]
    And1Bit porta_and_3 (
        .S(S[3]),
        .A(A[3]),
        .B(B[3])
    );

endmodule