// Módulo responsável por gerar as flags.
module FlagsULA(
    output Z,       // Flag Zero: Ativa (1) se o resultado S for 0.
    output OV,      // Flag Overflow: Ativa (1) se ocorrer um estouro aritmético ou de display (>99).
    output COUT,    // Flag Carry Out: Ativa (1) para o carry/borrow.
    output ERR,     // Flag de Erro: Ativa (1) em caso de divisão por zero.

    input  [7:0] S,         // Resultado de 8 bits da ULA.
    input  soma_cout,   // Carry out do somador.
    input  sub_bout,    // Borrow out do subtrator.
    input  soma_c3,     // Carry da posição 3 para 4 na soma (para OV).
    input  soma_c4,     // Carry out final da soma (para OV).
    input  sub_c3,      // Borrow da posição 3 para 4 na subtração (para OV).
    input  sub_c4,      // Borrow out final da subtração (para OV).
    input  [2:0] Sel,       // Seletor da operação da ULA.
    input  [3:0] B          // Operando B, usado para checar divisão por zero.
);

    // Flag Z (Zero): A flag Z é 1 se, e somente se, todos os bits do resultado S forem 0.
    wire soma_S;
    or OR_Soma_S(soma_S, S[0], S[1], S[2], S[3], S[4], S[5], S[6], S[7]);
    not NOT_Z(Z, soma_S); // Inverte o resultado: Z é 1 apenas se a soma de todos os bits for 0.

    // Flag COUT: Ativada apenas para operações aritméticas de soma e subtração.
    wire vai_um_sel;
    MUXDP1 MUX_VaiUm(vai_um_sel, soma_cout, sub_bout, Sel[0]); // Seleciona o carry da soma ou o borrow da subtração.
    wire nSel1;
    not NOT_Sel1(nSel1, Sel[1]);
    and AND_Cout(COUT, vai_um_sel, nSel1); // Habilita a flag apenas se Sel[1] for 0.

    // Flag OV: Combina duas condições: estouro aritmético e estouro de display.
    wire ov_soma, ov_sub;
    wire ov_arit_sel, ov_aritmetico;
    wire ov_display;
    wire cond_S_baixa, cond_S_alta;
    
    // Estouro Aritmético: Ocorre se os carries de entrada e saída do bit mais significativo forem diferentes.
    xor XOR_OV_Soma(ov_soma, soma_c3, soma_c4);
    xor XOR_OV_Sub(ov_sub, sub_c3, sub_c4);
    MUXDP1 MUX_OV_Arit(ov_arit_sel, ov_soma, ov_sub, Sel[0]); 
    and AND_OV_Arit(ov_aritmetico, ov_arit_sel, nSel1); // Habilita a flag apenas para operações aritméticas.
    
    // Estouro de Display: Detecta se o resultado S excede o valor 99, que é o limite para 2 displays BCD.
    or OR_Cond_S_Baixa(cond_S_baixa, S[4], S[3], S[2]);
    and AND_Cond_S_Alta(cond_S_alta, S[6], S[5], cond_S_baixa);
    or OR_OV_Display(ov_display, S[7], cond_S_alta);
    
    // A flag OV geral é ativada se qualquer uma das condições de estouro for verdadeira.
    or OR_OV_Final(OV, ov_aritmetico, ov_display);
    
    // Flag ERRO: Ativada se a operação for divisão e o divisor B for zero.
    wire soma_B, B_eh_zero;
    wire sel_eh_div;
    
    // Verifica se o operando B é igual a zero.
    or OR_Soma_B(soma_B, B[0], B[1], B[2], B[3]);
    not NOT_B_eh_zero(B_eh_zero, soma_B); // B_eh_zero é 1 se todos os bits de B forem 0.
    
    // Decodifica o sinal de seleção para identificar a operação de divisão (Sel = 011).
    wire nSel2;
    not NOT_Sel2(nSel2, Sel[2]);
    and AND_Sel_eh_div(sel_eh_div, nSel2, Sel[1], Sel[0]); 
    // A flag ERR é ativada se ambas as condições forem verdadeiras.
    and AND_ERR_Final(ERR, B_eh_zero, sel_eh_div);

endmodule