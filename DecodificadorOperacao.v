// Módulo que decodifica o código da operação da ULA para exibir o símbolo correspondente.
module DecodificadorOperacao (
    input  SW9,      // Bit 2 do seletor de operação.
    input  KEY0,     // Bit 0 do seletor de operação.
    input  KEY1,     // Bit 1 do seletor de operação.

    output [6:0] HEX // Barramento de 7 bits para acionar o display.
);
    // Gera as versões invertidas dos sinais de entrada.
    wire nSW9, nKEY0, nKEY1;
    not inv_sw9(nSW9, SW9);
    not inv_key0(nKEY0, KEY0);
    not inv_key1(nKEY1, KEY1);


    // Cada segmento do display é controlado por um circuito lógico independente
    // que implementa uma função booleana baseada nos bits de seleção.

    // Lógica para o segmento 'a' (HEX[0]).
    // Expressão: C
    or seg_a(HEX[0], KEY0, 1'b0);

    // Lógica para o segmento 'b' (HEX[1]).
    // Expressão: A'B' + AB + B'C
    wire b_t1, b_t2, b_t3;
    and b_term1(b_t1, nSW9, nKEY1);
    and b_term2(b_t2, SW9, KEY1);
    and b_term3(b_t3, nKEY1, KEY0);
    or  seg_b(HEX[1], b_t1, b_t2, b_t3);

    // Lógica para o segmento 'c' (HEX[2]).
    // Expressão: A'B'C + A'BC' + ABC
    wire c_t1, c_t2, c_t3;
    and c_term1(c_t1, nSW9, nKEY1, KEY0);
    and c_term2(c_t2, nSW9, KEY1, nKEY0);
    and c_term3(c_t3, SW9, KEY1, KEY0);
    or  seg_c(HEX[2], c_t1, c_t2, c_t3);

    // Lógica para o segmento 'd' (HEX[3]).
    // Expressão: A'B'C + A'BC' + AB'C' + ABC
    wire d_t1, d_t2, d_t3, d_t4;
    and d_term1(d_t1, nSW9, nKEY1, KEY0);
    and d_term2(d_t2, nSW9, KEY1, nKEY0);
    and d_term3(d_t3, SW9, nKEY1, nKEY0);
    and d_term4(d_t4, SW9, KEY1, KEY0);
    or  seg_d(HEX[3], d_t1, d_t2, d_t3, d_t4);

    // Lógica para o segmento 'e' (HEX[4]).
    // Expressão: A'B' + ABC
    wire e_t1, e_t2;
    and e_term1(e_t1, nSW9, nKEY1);
    and e_term2(e_t2, SW9, KEY1, KEY0);
    or  seg_e(HEX[4], e_t1, e_t2);

    // Lógica para o segmento 'f' (HEX[5]).
    // Expressão: AB + C
    wire f_t1;
    and f_term1(f_t1, SW9, KEY1);
    or  seg_f(HEX[5], KEY0, f_t1);
    
    // Lógica para o segmento 'g' (HEX[6]).
    // Expressão: ABC
    and seg_g(HEX[6], SW9, KEY1, KEY0);

endmodule