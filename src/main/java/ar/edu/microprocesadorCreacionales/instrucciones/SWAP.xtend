package ar.edu.microprocesadorCreacionales.instrucciones

import ar.edu.microprocesadorCreacionales.instrucciones.Instruccion
import ar.edu.microprocesadorCreacionales.Microcontroller

class SWAP extends Instruccion {

	override doExecute(Microcontroller micro) {
		val byte swapValue = micro.BAcumulator
		micro.BAcumulator = micro.AAcumulator
		micro.AAcumulator = swapValue
	}
	
}