// Módulo que gera um Produto Parcial.
// Ele multiplica um vetor de 4 bits (A) por um único bit (B_i).
module ProdutoParcial(output [3:0] Out, input [3:0] A, input B_i);
    // Se o bit B_i for 1, a saída 'Out' será igual a A.
    // Se o bit B_i for 0, a saída 'Out' será 0.
    and And0(Out[0], A[0], B_i);
    and And1(Out[1], A[1], B_i);
    and And2(Out[2], A[2], B_i);
    and And3(Out[3], A[3], B_i);
endmodule