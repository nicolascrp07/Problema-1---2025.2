// Módulo que implementa a Unidade Lógica e Aritmética (ULA) de 4 bits.
// Este é o componente central que executa um conjunto de operações lógicas e aritméticas.
// Ele instancia todos os módulos funcionais (soma, sub, mult, etc.), calcula todos os
// resultados em paralelo e usa um multiplexador para selecionar o resultado final
// com base no sinal de controle 'Sel'.
module ULA (
    // --- Saídas ---
    output [7:0] S,           // Barramento de 8 bits com o resultado da operação selecionada.
    output Z, OV, COUT, ERR,  // Flags de status: Zero, Overflow, Carry Out e Erro.
    
    // --- Entradas ---
    input  [3:0] A, B,        // Operandos de 4 bits.
    input        Cin,         // Carry de entrada para a soma.
    input        Bin,         // Borrow de entrada para a subtração.
    input  [2:0] Sel          // Seletor de 3 bits que define a operação a ser executada.
);

    wire [3:0] soma;          // Resultado da soma.
    wire soma_cout, soma_c3;  // Carries da soma para o cálculo das flags.

    wire [3:0] sub;           // Resultado da subtração.
    wire sub_bout, sub_c3;    // Borrows da subtração para o cálculo das flags.

    wire [7:0] mult;          // Resultado de 8 bits da multiplicação.

    wire [3:0] div_q;         // Quociente de 4 bits da divisão.
    wire [3:0] div_r;         // Resto de 4 bits da divisão.

    wire [3:0] and4, or4, xor4;// Resultados das operações lógicas.

    // Barramentos de 8 bits para padronizar as saídas para o MUX final.
    wire [7:0] soma_ext, sub_ext, and_ext, or_ext, xor_ext, div_ext;

    
    // Todas as operações são calculadas simultaneamente, independentemente do seletor.
    Somador4Bits U_SOMADOR (
        .S(soma), .Cout(soma_cout), .C3(soma_c3), 
        .A(A), .B(B), .Cin(Cin)
    );

    Subtrator4Bits U_SUBTRATOR (
        .D(sub), .Bout(sub_bout), .C3(sub_c3), 
        .A(A), .B(B), .Bin(Bin)
    );

    Multiplicador4Bits U_MULT (
        .Produto(mult), .A(A), .B(B)
    );

    Divisor4Bits U_DIV (
        .Quociente(div_q), .Resto(div_r), .A(A), .B(B)
    );

    And4Bits U_AND (.S(and4), .A(A), .B(B));
    Or4Bits  U_OR  (.S(or4),  .A(A), .B(B));
    Xor4Bits U_XOR (.S(xor4), .A(A), .B(B));

    // As portas AND são usadas como buffers para formatar os resultados de 4 bits
    // em um barramento de 8 bits compatível com o MUX.

    // Formata o resultado da soma: {3'b0, soma_cout, soma[3:0]}
    and (soma_ext[0], soma[0], 1'b1);
    and (soma_ext[1], soma[1], 1'b1);
    and (soma_ext[2], soma[2], 1'b1);
    and (soma_ext[3], soma[3], 1'b1);
    and (soma_ext[4], soma_cout, 1'b1);
    and (soma_ext[5], 1'b0, 1'b0); // Zera os bits superiores não utilizados.
    and (soma_ext[6], 1'b0, 1'b0);
    and (soma_ext[7], 1'b0, 1'b0);

    // Formata o resultado da subtração: {3'b0, sub_bout, sub[3:0]}
    and (sub_ext[0], sub[0], 1'b1);
    and (sub_ext[1], sub[1], 1'b1);
    and (sub_ext[2], sub[2], 1'b1);
    and (sub_ext[3], sub[3], 1'b1);
    and (sub_ext[4], sub_bout, 1'b1);
    and (sub_ext[5], 1'b0, 1'b0);
    and (sub_ext[6], 1'b0, 1'b0);
    and (sub_ext[7], 1'b0, 1'b0);

    // Formata o resultado da divisão: {4'b0, div_q[3:0]}
    and (div_ext[0], div_q[0], 1'b1);
	 and (div_ext[1], div_q[1], 1'b1);
	 and (div_ext[2], div_q[2], 1'b1);
	 and (div_ext[3], div_q[3], 1'b1);
	 and (div_ext[4], 1'b0, 1'b0);
	 and (div_ext[5], 1'b0, 1'b0);
	 and (div_ext[6], 1'b0, 1'b0);
	 and (div_ext[7], 1'b0, 1'b0);
	
    // Formata o resultado do AND: {4'b0, and4[3:0]}
    and (and_ext[0], and4[0], 1'b1);
    and (and_ext[1], and4[1], 1'b1);
    and (and_ext[2], and4[2], 1'b1);
    and (and_ext[3], and4[3], 1'b1);
    and (and_ext[4], 1'b0, 1'b0);
    and (and_ext[5], 1'b0, 1'b0);
    and (and_ext[6], 1'b0, 1'b0);
    and (and_ext[7], 1'b0, 1'b0);

    // Formata o resultado do OR: {4'b0, or4[3:0]}
    and (or_ext[0], or4[0], 1'b1);
    and (or_ext[1], or4[1], 1'b1);
    and (or_ext[2], or4[2], 1'b1);
    and (or_ext[3], or4[3], 1'b1);
    and (or_ext[4], 1'b0, 1'b0);
    and (or_ext[5], 1'b0, 1'b0);
    and (or_ext[6], 1'b0, 1'b0);
    and (or_ext[7], 1'b0, 1'b0);

    // Formata o resultado do XOR: {4'b0, xor4[3:0]}
    and (xor_ext[0], xor4[0], 1'b1);
    and (xor_ext[1], xor4[1], 1'b1);
    and (xor_ext[2], xor4[2], 1'b1);
    and (xor_ext[3], xor4[3], 1'b1);
    and (xor_ext[4], 1'b0, 1'b0);
    and (xor_ext[5], 1'b0, 1'b0);
    and (xor_ext[6], 1'b0, 1'b0);
    and (xor_ext[7], 1'b0, 1'b0);

    // O MUX de 8 bits seleciona qual dos resultados calculados será a saída final S.
    Multiplexador8Bits U_MUX (
        .S(S),
        .D0(soma_ext),     // Sel = 000 -> Soma
        .D1(sub_ext),      // Sel = 001 -> Subtração
        .D2(mult),         // Sel = 010 -> Multiplicação 
        .D3(div_ext),      // Sel = 011 -> Divisão
        .D4(and_ext),      // Sel = 100 -> AND
        .D5(or_ext),       // Sel = 101 -> OR
        .D6(xor_ext),      // Sel = 110 -> XOR
        .D7(8'b00000000),  // Sel = 111 -> Operação não utilizada
        .Sel(Sel)
    );

    // O módulo de flags analisa a saída final 'S' e os carries/borrows intermediários
    // para gerar os sinais de status Z, OV, COUT e ERR.
    FlagsULA U_FLAGS (
        .Z(Z), .OV(OV), .COUT(COUT), .ERR(ERR),
        .S(S),
        .soma_cout(soma_cout), .sub_bout(sub_bout),
        .soma_c3(soma_c3), .soma_c4(soma_cout), 
        .sub_c3(sub_c3), .sub_c4(sub_bout), 
        .Sel(Sel), .B(B)
    );

endmodule