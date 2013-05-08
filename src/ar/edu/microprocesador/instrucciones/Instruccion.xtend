package ar.edu.microprocesador.instrucciones

import ar.edu.microprocesador.Microcontroller

abstract class Instruccion {
	
	Microcontroller microBefore

	def void execute(Microcontroller micro) {
		microBefore = micro.clone as Microcontroller
		micro.advancePC
		this.doExecute(micro)
	}

	def void doExecute(Microcontroller micro)
	
	def void undo(Microcontroller micro) {
		micro.copyFrom(microBefore)
	}
	
}