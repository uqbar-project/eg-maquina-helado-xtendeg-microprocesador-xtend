package ar.edu.microprocesadorCreacionales.creationals

import ar.edu.microprocesadorCreacionales.excepciones.SystemException
import ar.edu.microprocesadorCreacionales.instrucciones.ADD
import ar.edu.microprocesadorCreacionales.instrucciones.Instruccion
import ar.edu.microprocesadorCreacionales.instrucciones.LODV
import ar.edu.microprocesadorCreacionales.instrucciones.NOP
import ar.edu.microprocesadorCreacionales.instrucciones.SWAP
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
		instructions = new HashMap<Byte, () => Instruccion> => [
			put(1 as byte, [ | new NOP ])
			put(2 as byte, [ | new ADD ])
			put(5 as byte, [ | new SWAP ])
			put(9 as byte, [ | new LODV ])
		]
	}

	def getInstruction(byte codigoInstruccion) {
		var instruccionAEjecutar = instructions.get(codigoInstruccion).apply()
		if (instruccionAEjecutar == null) {
			throw new SystemException("La instrucción de código " + codigoInstruccion + " no es reconocida")
		}
		instruccionAEjecutar
	}
	
}