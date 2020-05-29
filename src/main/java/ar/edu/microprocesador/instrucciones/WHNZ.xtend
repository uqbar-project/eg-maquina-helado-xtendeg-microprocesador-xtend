package ar.edu.microprocesador.instrucciones

import ar.edu.microprocesador.instrucciones.Instruccion
import java.util.List
import ar.edu.microprocesador.Microcontroller

class WHNZ extends InstruccionMultiple {
	
	new(List<Instruccion> instrucciones) {
		super(instrucciones)
	}

	override operate(Microcontroller micro, (Microcontroller)=>void instruction) {
		while (micro.condicionACumplir) instruction.apply(micro)
	}

}
