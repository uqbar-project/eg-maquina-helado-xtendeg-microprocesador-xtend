package ar.edu.microprocesador.instrucciones

import ar.edu.microprocesador.instrucciones.Instruccion
import java.util.List
import ar.edu.microprocesador.Microcontroller

class WHNZ extends InstruccionMultiple {
	
	new(List<Instruccion> instrucciones) {
		super(instrucciones)
	}

	override doExecute(Microcontroller micro) {
		while (this.condicionACumplir(micro)) {
			super.doExecute(micro)
		}
	}

}