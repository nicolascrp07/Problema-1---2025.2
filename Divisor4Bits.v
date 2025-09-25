// Módulo que implementa um divisor de 4 bits.
module Divisor4Bits(
    output [3:0] Quociente,
    output [3:0] Resto,

    input  [3:0] A,  // Dividendo de 4 bits.
    input  [3:0] B   // Divisor de 4 bits.
);

    wire [3:0] calc_quociente; // Armazena o quociente calculado.
    wire [3:0] calc_resto;     // Armazena o resto calculado.

    wire B_is_zero; // Flag que é '1' se o divisor B for igual a zero.
    nor nor_B_is_zero(B_is_zero, B[3], B[2], B[1], B[0]); // A saída é 1 somente se todos os bits de B forem 0.
    

    // Fios para os resultados de cada estágio iterativo.
    wire [3:0] sub_out_1, sub_out_2, sub_out_3, sub_out_4;
    wire bout_1, bout_2, bout_3, bout_4;
    wire [3:0] resto_1, resto_2, resto_3;

    // Tenta subtrair B do bit mais significativo de A.
    Subtrator4Bits sub1(.D(sub_out_1), .Bout(bout_1), .A({3'b0, A[3]}), .B(B), .Bin(1'b0));
    // O bit do quociente é o inverso do borrow. Se houve borrow (bout=1), a subtração falhou (Q[3]=0).
    not inv_q3(calc_quociente[3], bout_1);
    // O MUX restaura o valor original se a subtração falhou, ou mantém o resultado se teve sucesso.
    MUXDP14B mux1(.S(resto_1), .A({3'b0, A[3]}), .B(sub_out_1), .Sel(calc_quociente[3]));
    
    // Tenta subtrair B do resto anterior deslocado com o próximo bit de A.
    Subtrator4Bits sub2(.D(sub_out_2), .Bout(bout_2), .A({resto_1[2:0], A[2]}), .B(B), .Bin(1'b0));
    not inv_q2(calc_quociente[2], bout_2);
    MUXDP14B mux2(.S(resto_2), .A({resto_1[2:0], A[2]}), .B(sub_out_2), .Sel(calc_quociente[2]));

    // Calcula o bit 1 do quociente
    Subtrator4Bits sub3(.D(sub_out_3), .Bout(bout_3), .A({resto_2[2:0], A[1]}), .B(B), .Bin(1'b0));
    not inv_q1(calc_quociente[1], bout_3);
    MUXDP14B mux3(.S(resto_3), .A({resto_2[2:0], A[1]}), .B(sub_out_3), .Sel(calc_quociente[1]));

    // Calcula o bit 0 do quociente e o resto final 
    Subtrator4Bits sub4(.D(sub_out_4), .Bout(bout_4), .A({resto_3[2:0], A[0]}), .B(B), .Bin(1'b0));
    not inv_q0(calc_quociente[0], bout_4);
    // A saída do último MUX é o resto final da divisão.
    MUXDP14B mux4(.S(calc_resto), .A({resto_3[2:0], A[0]}), .B(sub_out_4), .Sel(calc_quociente[0]));


    // Se B for zero, a saída do quociente é forçada para 0. Senão, usa o valor calculado.
    MUXDP14B final_mux_quociente(
        .S(Quociente), 
        .A(calc_quociente), 
        .B(4'b0000),         
        .Sel(B_is_zero)
    );

    // Se B for zero, a saída do resto também é forçada para 0.
    MUXDP14B final_mux_resto(
        .S(Resto), 
        .A(calc_resto),     
        .B(4'b0000),         
        .Sel(B_is_zero)
    );

endmodule