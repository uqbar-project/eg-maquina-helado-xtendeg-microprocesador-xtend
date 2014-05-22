package ar.edu.microprocesador.instrucciones

import ar.edu.microprocesador.Microcontroller
import java.util.List

class IFNZ extends InstruccionMultiple {
	
	new(List<Instruccion> instrucciones) {
		super(instrucciones)
	}
	
	override doExecute(Microcontroller micro) {
		if (micro.AAcumulator != 0) {
			super.doExecute(micro)
		}
	}
	
}