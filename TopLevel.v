// Módulo Top-Level: Ponto de entrada principal do projeto para a placa.
// Este módulo conecta a ULA a componentes físicos externos como as chaves (SW),
// os botões (KEYS) e os displays de 7 segmentos (HEX). Ele gerencia o fluxo de dados
// desde a entrada do usuário até a exibição dos resultados.
module TopLevel (
    input  [9:0] SW,      // Barramento de 10 chaves para entrada de dados.
    input        KEY0,    // Botão 0.
    input        KEY1,    // Botão 1.

    output [6:0] HEX0,    // Display de 7 segmentos para a unidade do resultado.
    output [6:0] HEX1,    // Display de 7 segmentos para a dezena do resultado.
    output [6:0] HEX5,    // Display de 7 segmentos para mostrar a operação selecionada.
	 output        FLAG_Z,    // Saída para LED da flag Zero.
    output        FLAG_OV,   // Saída para LED da flag Overflow.
    output        FLAG_COUT, // Saída para LED da flag Carry Out.
    output        FLAG_ERR   // Saída para LED da flag de Erro.
);

    // Fio interno para o resultado de 8 bits da ULA.
    wire [7:0] resultado_ula;

    // Instância Principal da ULA
    ULA minha_ula (
        // Saídas da ULA
        .S   (resultado_ula), // O resultado do cálculo é armazenado internamente.
        .Z   (FLAG_Z),      // As flags são conectadas diretamente às saídas do TopLevel.
        .OV  (FLAG_OV),
        .COUT(FLAG_COUT),
        .ERR (FLAG_ERR),
        
        // Entradas da ULA mapeadas para as chaves e botões
        .A   (SW[3:0]),      // Operando A.
        .B   (SW[7:4]),      // Operando B.
        .Cin (SW[8]),        // A chave 8 é o Carry In de entrada.
        .Bin (1'b0),         // O Borrow de entrada é fixo em 0.
        .Sel ({SW[9], KEY1, KEY0}) // O seletor de operação é formado pela chave 9 e os dois botões.
    );

    // Fios para armazenar o resultado da ULA convertido para o formato BCD.
    wire [3:0] digito_dezenas;
    wire [3:0] digito_unidades;

    // Converte o resultado binário de 8 bits da ULA em dois dígitos BCD (dezenas e unidades).
    BinarioParaBCD_Estrutural meu_conversor_bcd (
        .binario(resultado_ula),
        .bcd_dezenas(digito_dezenas),
        .bcd_unidades(digito_unidades)
    );

    // Decodifica o dígito BCD das unidades para acionar o display HEX0.
    DecodificadorBCD7Seg dec_unidades (
        .entrada_bcd(digito_unidades),
        .seg_a(HEX0[0]), .seg_b(HEX0[1]), .seg_c(HEX0[2]),
        .seg_d(HEX0[3]), .seg_e(HEX0[4]), .seg_f(HEX0[5]), .seg_g(HEX0[6])
    );

    // Decodifica o dígito BCD das dezenas para acionar o display HEX1.
    DecodificadorBCD7Seg dec_dezenas (
        .entrada_bcd(digito_dezenas),
        .seg_a(HEX1[0]), .seg_b(HEX1[1]), .seg_c(HEX1[2]),
        .seg_d(HEX1[3]), .seg_e(HEX1[4]), .seg_f(HEX1[5]), .seg_g(HEX1[6])
    );
	 
	 // Decodifica os sinais de seleção da ULA para mostrar um símbolo da operação no display HEX5.
	 DecodificadorOperacao operacao (
        .SW9(SW[9]),
        .KEY0(KEY0),
        .KEY1(KEY1),
        .HEX(HEX5)
    );

endmodule