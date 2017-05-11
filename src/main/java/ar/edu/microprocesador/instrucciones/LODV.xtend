package ar.edu.microprocesador.instrucciones

import ar.edu.microprocesador.instrucciones.Instruccion
import ar.edu.microprocesador.Microcontroller

class LODV extends Instruccion {

	byte value
	
	new(int value) {
		if (value > 255) {
			throw new IllegalArgumentException("No debe crear una instrucción LODV de un número mayor a 255")
		} else {
			this.value = value as byte
		}
	}

	override doExecute(Microcontroller micro) {
		micro.AAcumulator = value
	}
	
}