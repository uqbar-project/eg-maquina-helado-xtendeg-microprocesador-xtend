package ar.edu.microprocesador.instrucciones

import ar.edu.microprocesador.instrucciones.Instruccion
import java.util.List
import ar.edu.microprocesador.Microcontroller

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