package ar.edu.microprocesadorCreacionales.instrucciones

import ar.edu.microprocesadorCreacionales.instrucciones.Instruccion
import ar.edu.microprocesadorCreacionales.Microcontroller

class SUB extends Instruccion {
	
	override doExecute(Microcontroller micro) {
		var result = micro.AAcumulator - micro.BAcumulator
		this.actualizarAcumuladores(micro, result)
	}
	
}