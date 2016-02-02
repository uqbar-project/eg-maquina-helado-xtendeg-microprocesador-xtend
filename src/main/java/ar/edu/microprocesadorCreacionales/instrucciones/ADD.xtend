package ar.edu.microprocesadorCreacionales.instrucciones

import ar.edu.microprocesadorCreacionales.Microcontroller

class ADD extends Instruccion {

	override doExecute(Microcontroller micro) {
		var suma = micro.AAcumulator + micro.BAcumulator
		this.actualizarAcumuladores(micro, suma)
	}
	
}