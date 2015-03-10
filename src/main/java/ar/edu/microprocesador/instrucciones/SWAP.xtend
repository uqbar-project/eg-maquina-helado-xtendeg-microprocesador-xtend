package ar.edu.microprocesador.instrucciones

import ar.edu.microprocesador.instrucciones.Instruccion
import ar.edu.microprocesador.Microcontroller

class SWAP extends Instruccion {

	override doExecute(Microcontroller micro) {
		val byte swapValue = micro.getBAcumulator
		micro.BAcumulator = micro.getAAcumulator
		micro.AAcumulator = swapValue
	}
	
}