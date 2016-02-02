package ar.edu.microprocesadorCreacionales.instrucciones

import ar.edu.microprocesadorCreacionales.instrucciones.Instruccion
import ar.edu.microprocesadorCreacionales.Microcontroller

class NOP extends Instruccion {

	override doExecute(Microcontroller micro) {
		// No operation no hace nada por default
	}
	
}