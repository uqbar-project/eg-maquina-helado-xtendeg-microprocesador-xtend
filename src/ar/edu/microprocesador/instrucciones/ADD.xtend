package ar.edu.microprocesador.instrucciones

import ar.edu.microprocesador.Microcontroller

class ADD extends Instruccion {

	override doExecute(Microcontroller micro) {
		var suma = micro.AAcumulator + micro.BAcumulator
		if (suma > Byte::MAX_VALUE) {
			micro.BAcumulator = Byte::MAX_VALUE
			micro.AAcumulator = (suma - Byte::MAX_VALUE) as byte
		} else {
			micro.BAcumulator = suma as byte
			micro.AAcumulator = 0 as byte
		}
	}
	
}