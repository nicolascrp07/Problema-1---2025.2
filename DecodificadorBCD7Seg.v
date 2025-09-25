// Módulo que decodifica uma entrada BCD de 4 bits para acionar um display de 7 segmentos.
module DecodificadorBCD7Seg (
    output seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g, // Sinais para cada segmento do display.

    input  [3:0] entrada_bcd // O valor BCD de 4 bits a ser decodificado.
);
    // Gera as versões invertidas dos sinais de entrada.
    wire n_in3, n_in2, n_in1, n_in0;
    not NOTA(n_in3, entrada_bcd[3]);
    not NOTB(n_in2, entrada_bcd[2]);
    not NOTC(n_in1, entrada_bcd[1]);
    not NOTD(n_in0, entrada_bcd[0]);

    // Cada segmento é controlado por um circuito que implementa sua função booleana.
    
    // Lógica para o segmento 'a'.
    // Expressão: seg_a = A'B'C'D + BC'D'
    wire a_t1, a_t2;
    and AND_A1(a_t1, n_in3, n_in2, n_in1, entrada_bcd[0]);
    and AND_A2(a_t2, entrada_bcd[2], n_in1, n_in0);
    or  OR_A(seg_a, a_t1, a_t2);

    // Lógica para o segmento 'b'.
    // Expressão: seg_b = BC'D + BCD'
    wire b_t1, b_t2;
    and AND_B1(b_t1, entrada_bcd[2], n_in1, entrada_bcd[0]);
    and AND_B2(b_t2, entrada_bcd[2], entrada_bcd[1], n_in0);
    or  OR_B(seg_b, b_t1, b_t2);

    // Lógica para o segmento 'c'.
    // Expressão: seg_c = B'CD'
    and AND_C(seg_c, n_in2, entrada_bcd[1], n_in0);

    // Lógica para o segmento 'd'.
    // Expressão: seg_d = B'C'D + BC'D' + BCD
    wire d_t1, d_t2, d_t3;
    and AND_D1(d_t1, n_in2, n_in1, entrada_bcd[0]);
    and AND_D2(d_t2, entrada_bcd[2], n_in1, n_in0);
    and AND_D3(d_t3, entrada_bcd[2], entrada_bcd[1], entrada_bcd[0]);
    or  OR_D(seg_d, d_t1, d_t2, d_t3);

    // Lógica para o segmento 'e'.
    // Expressão: seg_e = BC' + D
    wire e_t1;
    and AND_E1(e_t1, entrada_bcd[2], n_in1);
    or  OR_E(seg_e, e_t1, entrada_bcd[0]);
    
    // Lógica para o segmento 'f'.
    // Expressão: seg_f = A'B'D + B'C + CD
    wire f_t1, f_t2, f_t3;
    and AND_F1(f_t1, n_in3, n_in2, entrada_bcd[0]);
    and AND_F2(f_t2, n_in2, entrada_bcd[1]);
    and AND_F3(f_t3, entrada_bcd[1], entrada_bcd[0]);
    or  OR_F(seg_f, f_t1, f_t2, f_t3);

    // Lógica para o segmento 'g'.
    // Expressão: seg_g = A'B'C' + BCD
    wire g_t1, g_t2;
    and AND_G1(g_t1, n_in3, n_in2, n_in1);
    and AND_G2(g_t2, entrada_bcd[2], entrada_bcd[1], entrada_bcd[0]);
    or  OR_G(seg_g, g_t1, g_t2);

endmodule