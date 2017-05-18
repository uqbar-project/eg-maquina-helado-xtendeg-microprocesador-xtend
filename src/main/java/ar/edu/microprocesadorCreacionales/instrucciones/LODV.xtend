package ar.edu.microprocesadorCreacionales.instrucciones

import ar.edu.microprocesadorCreacionales.Microcontroller

class LODV extends Instruccion {

	int value
	
	new(int value) {
		this.value = value
	}

	override doExecute(Microcontroller micro) {
		micro.AAcumulator = value as byte
	}
	
}