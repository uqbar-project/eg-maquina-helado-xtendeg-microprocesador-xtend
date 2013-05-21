package ar.edu.microprocesador.instrucciones

import ar.edu.microprocesador.instrucciones.Instruccion
import ar.edu.microprocesador.Microcontroller

class NOP extends Instruccion {

	override doExecute(Microcontroller micro) {
		// No operation no hace nada por default
	}
	
}