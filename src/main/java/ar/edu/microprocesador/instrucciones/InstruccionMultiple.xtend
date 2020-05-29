package ar.edu.microprocesador.instrucciones

import java.util.List
import ar.edu.microprocesador.Microcontroller

abstract class InstruccionMultiple extends Instruccion {
	
	List<Instruccion> instrucciones
	
	new(List<Instruccion> instrucciones) {
		this.instrucciones = instrucciones
	}
	
	override doExecute(Microcontroller micro) {
		micro.operate([ Microcontroller microcontroller | 
			microcontroller.run(this.instrucciones)
		])
	}

	def void operate(Microcontroller micro, (Microcontroller)=>void instruction)

	def condicionACumplir(Microcontroller micro) {
		micro.AAcumulator != 0
	}
}
