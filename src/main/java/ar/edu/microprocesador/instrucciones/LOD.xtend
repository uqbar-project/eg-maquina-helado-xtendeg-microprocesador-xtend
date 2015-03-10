package ar.edu.microprocesador.instrucciones

import ar.edu.microprocesador.instrucciones.Instruccion
import ar.edu.microprocesador.Microcontroller

class LOD extends Instruccion {
	
	int addr
	
	new(int addr) {
		this.addr = addr
	}
	
	override doExecute(Microcontroller micro) {
		micro.AAcumulator = micro.getData(addr)
	}
	
}