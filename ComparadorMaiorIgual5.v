// Módulo que compara um número de 4 bits para verificar se ele é maior ou igual a 5.
module ComparadorMaiorIgual5 (
    output resultado,  // Saída de 1 bit. É '1' se a entrada for >= 5, e '0' caso contrário.

    input  [3:0] entrada // O valor de 4 bits a ser comparado.
);
    wire termo1, termo2; // Fios para os termos parciais.

    // A lógica implementa a expressão booleana simplificada para a condição "maior ou igual a 5".
    // Calcula o termo (C+D), ou (entrada[1] OR entrada[0]).
    or  o1(termo1, entrada[1], entrada[0]);   
    // Calcula o termo B(C+D), ou (entrada[2] AND termo1).
    and a1(termo2, entrada[2], termo1);       
    // Calcula a expressão final A + B(C+D), ou (entrada[3] OR termo2).
    or  o_final(resultado, entrada[3], termo2); 
endmodule