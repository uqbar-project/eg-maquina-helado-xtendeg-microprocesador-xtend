package ar.edu.microprocesador.instrucciones

import ar.edu.microprocesador.instrucciones.Instruccion
import ar.edu.microprocesador.Microcontroller

class DIV extends Instruccion {

	override doExecute(Microcontroller micro) {
		var result = micro.getAAcumulator / micro.getBAcumulator
		if (result > Byte.MAX_VALUE) {
			micro.BAcumulator = Byte.MAX_VALUE
			micro.AAcumulator = (result - Byte.MAX_VALUE) as byte
		} else {
			micro.BAcumulator = result as byte
			micro.AAcumulator = 0 as byte
		}
	}
	
}