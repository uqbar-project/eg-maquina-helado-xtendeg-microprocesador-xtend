package ar.edu.microprocesador.instrucciones

import ar.edu.microprocesador.Microcontroller
import java.util.List

class IFNZ extends InstruccionMultiple {
	
	new(List<Instruccion> instrucciones) {
		super(instrucciones)
	}
	
	override operate(Microcontroller micro, (Microcontroller)=>void instruction) {
		if (micro.condicionACumplir) instruction.apply(micro)
	}
}
