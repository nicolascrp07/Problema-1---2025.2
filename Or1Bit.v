// Módulo que implementa uma porta lógica OR de 1 bit.
module Or1Bit (
    output S,    // O resultado da operação A OR B.
    input A,
    input B
);

    // Instancia a porta OR.
    or Or0 (S, A, B);

endmodule