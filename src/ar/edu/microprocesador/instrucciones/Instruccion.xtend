package ar.edu.microprocesador.instrucciones

import ar.edu.microprocesador.Microcontroller

abstract class Instruccion {
	
	Microcontroller microBefore

	def void execute(Microcontroller micro) {
		microBefore = micro.clone as Microcontroller
		this.doExecute(micro)
		micro.advancePC
	}

	def void doExecute(Microcontroller micro)
	
	def void undo(Microcontroller micro) {
		micro.copyFrom(microBefore)
	}

	def setearAcumuladores(Microcontroller micro, int result) {
		if (result > Byte.MAX_VALUE) {
			micro.AAcumulator = Byte.MAX_VALUE
			micro.BAcumulator = (result - Byte.MAX_VALUE) as byte
		} else {
			micro.AAcumulator = result as byte
			micro.BAcumulator = 0 as byte
		}
	}	
}