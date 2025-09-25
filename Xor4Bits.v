// Módulo que realiza a operação XOR entre dois vetores de 4 bits.
module Xor4Bits (
    output [3:0] S, // O vetor de 4 bits resultante.
    input [3:0] A,
    input [3:0] B
);

    // A implementação usa 4 instâncias do módulo Xor1Bit, uma para cada par de bits.
    // S[0] = A[0] XOR B[0]
    Xor1Bit porta_xor_0 (
        .S(S[0]),
        .A(A[0]),
        .B(B[0])
    );

    // S[1] = A[1] XOR B[1]
    Xor1Bit porta_xor_1 (
        .S(S[1]),
        .A(A[1]),
        .B(B[1])
    );

    // S[2] = A[2] XOR B[2]
    Xor1Bit porta_xor_2 (
        .S(S[2]),
        .A(A[2]),
        .B(B[2])
    );

    // S[3] = A[3] XOR B[3]
    Xor1Bit porta_xor_3 (
        .S(S[3]),
        .A(A[3]),
        .B(B[3])
    );

endmodule