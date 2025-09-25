// Módulo que implementa uma porta lógica XOR (OU Exclusivo) de 1 bit.
module Xor1Bit (
    output S,    // O resultado da operação A XOR B.
    input A,
    input B
);

    // Instancia a porta XOR.
    xor Xor0 (S, A, B);

endmodule