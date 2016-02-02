package ar.edu.microprocesadorCreacionales.instrucciones

import ar.edu.microprocesadorCreacionales.Microcontroller
import java.util.List

class InstruccionMultiple extends Instruccion {
	
	List<Instruccion> instrucciones
	
	new(List<Instruccion> instrucciones) {
		this.instrucciones = instrucciones
	}
	
	override doExecute(Microcontroller micro) {
		instrucciones.forEach [ instruccion | instruccion.doExecute(micro) ]
	}
	
}