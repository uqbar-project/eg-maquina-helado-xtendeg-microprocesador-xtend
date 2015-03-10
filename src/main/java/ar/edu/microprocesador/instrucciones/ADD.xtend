package ar.edu.microprocesador.instrucciones

import ar.edu.microprocesador.Microcontroller

class ADD extends Instruccion {

	override doExecute(Microcontroller micro) {
		var suma = micro.getAAcumulator + micro.getBAcumulator
		setearAcumuladores(micro, suma)
	}
	
}