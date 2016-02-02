package ar.edu.microprocesadorCreacionales.instrucciones

import ar.edu.microprocesadorCreacionales.instrucciones.Instruccion
import java.util.List
import ar.edu.microprocesadorCreacionales.Microcontroller

class WHNZ extends InstruccionMultiple {
	
	new(List<Instruccion> instrucciones) {
		super(instrucciones)
	}

	override doExecute(Microcontroller micro) {
		while (micro.getAAcumulator() != 0) {
			super.doExecute(micro)
		}
	}

}