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
	Map<Byte, (ProgramIterator) => Instruccion> instructions
	
	/* Singleton instructions */
	NOP nop
	SWAP swap
	ADD add
	
	
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
		
		nop = new NOP
		swap = new SWAP
		add = new ADD
	}

	def void initialize() {
		instructions = new HashMap<Byte, (ProgramIterator) => Instruccion> => [
			put(1 as byte, [ programIt | nop ])
			put(2 as byte, [ programIt | add ])
			put(5 as byte, [ programIt | swap ])
			put(9 as byte, [ programIt |
				val dato = programIt.nextValue 
				new LODV(dato)
			])
		]
	}

	def getInstruction(ProgramIterator programIt, byte codigoInstruccion) {
		val instruccionAEjecutar = instructions.get(codigoInstruccion).apply(programIt)
		if (instruccionAEjecutar == null) {
			throw new SystemException("La instrucción de código " + codigoInstruccion + " no es reconocida")
		}
		instruccionAEjecutar
	}
	
}