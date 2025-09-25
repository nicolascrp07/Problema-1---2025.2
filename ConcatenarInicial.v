// Módulo que gera um valor constante de 8 bits igual a zero.
module ConcatenarInicial(
    output [7:0] Saida // O barramento de 8 bits que terá a saída constante '0'.
);
    and gnd0(Saida[0], 1'b0, 1'b0);
    and gnd1(Saida[1], 1'b0, 1'b0);
    and gnd2(Saida[2], 1'b0, 1'b0);
    and gnd3(Saida[3], 1'b0, 1'b0);
    and gnd4(Saida[4], 1'b0, 1'b0);
    and gnd5(Saida[5], 1'b0, 1'b0);
    and gnd6(Saida[6], 1'b0, 1'b0);
    and gnd7(Saida[7], 1'b0, 1'b0);
	 
endmodule