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
	
}