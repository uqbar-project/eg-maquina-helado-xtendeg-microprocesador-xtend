package ar.edu.microprocesador.instrucciones

import ar.edu.microprocesador.instrucciones.Instruccion
import ar.edu.microprocesador.Microcontroller

class SUB extends Instruccion {
	
	override doExecute(Microcontroller micro) {
		var result = micro.getAAcumulator - micro.getBAcumulator
		setearAcumuladores(micro, result)
	}
	
}