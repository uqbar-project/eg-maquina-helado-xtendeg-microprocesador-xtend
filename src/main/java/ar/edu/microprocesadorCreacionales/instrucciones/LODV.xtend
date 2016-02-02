package ar.edu.microprocesadorCreacionales.instrucciones

import ar.edu.microprocesadorCreacionales.Microcontroller
import ar.edu.microprocesadorCreacionales.creationals.ProgramIterator

class LODV extends Instruccion {

	int value
	
	override prepare(ProgramIterator programIt) {
		value = programIt.nextValue
	}

	override doExecute(Microcontroller micro) {
		micro.AAcumulator = value as byte
	}
	
}