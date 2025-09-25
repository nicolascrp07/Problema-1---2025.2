// Módulo que realiza a operação OR entre dois vetores de 4 bits.
module Or4Bits (
    output [3:0] S, // O vetor de resultante.
    input [3:0] A,
    input [3:0] B
);

    // A implementação usa 4 instâncias do módulo Or1Bit, uma para cada par de bits.
    // S[0] = A[0] OR B[0]
    Or1Bit porta_or_0 (
        .S(S[0]),
        .A(A[0]),
        .B(B[0])
    );

    // S[1] = A[1] OR B[1]
    Or1Bit porta_or_1 (
        .S(S[1]),
        .A(A[1]),
        .B(B[1])
    );

    // S[2] = A[2] OR B[2]
    Or1Bit porta_or_2 (
        .S(S[2]),
        .A(A[2]),
        .B(B[2])
    );

    // S[3] = A[3] OR B[3]
    Or1Bit porta_or_3 (
        .S(S[3]),
        .A(A[3]),
        .B(B[3])
    );

endmodule