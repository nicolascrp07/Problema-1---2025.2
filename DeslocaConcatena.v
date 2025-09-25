// Módulo que realiza a operação de deslocar e concatenar.
// Ele executa um deslocamento lógico de 1 bit para a esquerda em um barramento de 8 bits.
module DeslocaConcatena(
    output [7:0] Saida,    // O barramento de 8 bits resultante.

    input  [7:0] Ajustado, // O valor de 8 bits a ser deslocado.
    input        NovoBit   // O novo bit que será inserido na posição do Bit[0].
);

    // Saida[7] recebe o antigo bit Ajustado[6]. O bit Ajustado[7] é descartado.
    or o0(Saida[7], Ajustado[6], 1'b0);
    // Saida[6] recebe o antigo bit Ajustado[5].
    or o1(Saida[6], Ajustado[5], 1'b0);
    // Saida[5] recebe o antigo bit Ajustado[4].
    or o2(Saida[5], Ajustado[4], 1'b0);
    // Saida[4] recebe o antigo bit Ajustado[3].
    or o3(Saida[4], Ajustado[3], 1'b0);
    // Saida[3] recebe o antigo bit Ajustado[2].
    or o4(Saida[3], Ajustado[2], 1'b0);
    // Saida[2] recebe o antigo bit Ajustado[1].
    or o5(Saida[2], Ajustado[1], 1'b0);
    // Saida[1] recebe o antigo bit Ajustado[0].
    or o6(Saida[1], Ajustado[0], 1'b0);
    // Saida[0] recebe o valor do NovoBit de entrada.
    or o7(Saida[0], NovoBit, 1'b0);
    
endmodule