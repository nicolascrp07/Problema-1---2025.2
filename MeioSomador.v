// Módulo que implementa um meio-somador.
// Ele soma dois bits de entrada (A e B) e produz um bit de Soma (S) e um de Carry (Cout).
module MeioSomador(output S, output Cout, input A, input B);
    // A porta XOR calcula o bit de Soma. S é '1' se A e B forem diferentes.
    xor Xor0(S, A, B);
    // A porta AND calcula o bit de Carry. Cout é '1' apenas se A e B forem '1'.
    and And0(Cout, A, B);
endmodule