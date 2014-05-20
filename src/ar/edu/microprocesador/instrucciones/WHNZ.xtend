package ar.edu.microprocesador.instrucciones

import ar.edu.microprocesador.instrucciones.Instruccion
import java.util.List
import ar.edu.microprocesador.Microcontroller

class WHNZ extends InstruccionMultiple {
	
	int vecesQueFueEjecutado

	new(List<Instruccion> instrucciones) {
		super(instrucciones)
	}

	override doExecute(Microcontroller micro) {
		vecesQueFueEjecutado = 0
		while (micro.getAAcumulator != 0) {
			vecesQueFueEjecutado = vecesQueFueEjecutado + 1
			super.doExecute(micro)
		}
	}

	/**
	 * Solo para test
	 * @return
	 */
	def getVecesQueFueEjecutado() {
		vecesQueFueEjecutado
	}
	
}