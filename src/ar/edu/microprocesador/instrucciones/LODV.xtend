package ar.edu.microprocesador.instrucciones

import ar.edu.microprocesador.Microcontroller
import ar.edu.microprocesador.creationals.ProgramIterator

class LODV extends Instruccion {

	int value
	
	override prepare(ProgramIterator programIt) {
		value = programIt.nextValue
	}

	override doExecute(Microcontroller micro) {
		micro.AAcumulator = value as byte
	}
	
}