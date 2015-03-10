package ar.edu.microprocesador.creationals

import ar.edu.microprocesador.excepciones.SystemException
import ar.edu.microprocesador.instrucciones.ADD
import ar.edu.microprocesador.instrucciones.Instruccion
import ar.edu.microprocesador.instrucciones.LODV
import ar.edu.microprocesador.instrucciones.NOP
import ar.edu.microprocesador.instrucciones.SWAP
import java.util.HashMap
import java.util.Map

class InstruccionFactory {

	static InstruccionFactory instance
	Map<Byte, () => Instruccion> instructions
	
	/**
	 * El InstruccionFactory es un singleton, y tiene implementado un
	 * conjunto conocido de instancias que modelan la instrucción
	 * (no se generan n NOP, sino que
	 * se utiliza una sola instrucción NOP, una ADD, una LODV, etc.)
	 * 
	 * @return
	 */
	def static InstruccionFactory getInstance() {
		if (instance == null) {
			instance = new InstruccionFactory
		}
		instance
	}

	private new() {
		this.initialize()
	}

	def void initialize() {
		instructions = new HashMap<Byte, () => Instruccion>
		instructions.put(1 as byte, [ | new NOP ])
		instructions.put(2 as byte, [ | new ADD ])
		instructions.put(5 as byte, [ | new SWAP ])
		instructions.put(9 as byte, [ | new LODV ])
	}

	def getInstruction(byte codigoInstruccion) {
		var instruccionAEjecutar = instructions.get(codigoInstruccion).apply()
		if (instruccionAEjecutar == null) {
			throw new SystemException("La instrucción de código " + codigoInstruccion + " no es reconocida")
		}
		instruccionAEjecutar
	}
	
}