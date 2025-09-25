// Módulo que implementa uma porta lógica AND de 1 bit.
module And1Bit (S, A, B);
	input A, B; // Os dois bits de entrada.
	output S;    // O resultado da operação A AND B.
	
	// Instancia a porta AND.
	and And0 (S, A, B);
	
endmodule