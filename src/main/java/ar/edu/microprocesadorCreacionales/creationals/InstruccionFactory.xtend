package ar.edu.microprocesadorCreacionales.creationals

import ar.edu.microprocesadorCreacionales.excepciones.SystemException
import ar.edu.microprocesadorCreacionales.instrucciones.ADD
import ar.edu.microprocesadorCreacionales.instrucciones.Instruccion
import ar.edu.microprocesadorCreacionales.instrucciones.LODV
import ar.edu.microprocesadorCreacionales.instrucciones.NOP
import ar.edu.microprocesadorCreacionales.instrucciones.SWAP
import java.util.Map

class InstruccionFactory {

	static InstruccionFactory instance
	Map<Byte, AbstractOperationFactory> instructions
	
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
		instructions = #{
			1 as byte -> new NOPFactory,
			2 as byte -> new ADDFactory,
			5 as byte -> new SWAPFactory,
			9 as byte -> new LODVFactory
		}
	}

	def getInstruction(ProgramIterator programIt, byte codigoInstruccion) {
		val instruccionAEjecutar = instructions.get(codigoInstruccion).create(programIt)
		if (instruccionAEjecutar == null) {
			throw new SystemException("La instrucción de código " + codigoInstruccion + " no es reconocida")
		}
		instruccionAEjecutar
	}
	
}

abstract class AbstractOperationFactory {
	def Instruccion create(ProgramIterator programIt)
}

class NOPFactory extends AbstractOperationFactory {
	NOP nop = new NOP 
	
	override create(ProgramIterator programIt) {
		nop	
	}
	
}

class ADDFactory extends AbstractOperationFactory {
	ADD add = new ADD 
	
	override create(ProgramIterator programIt) {
		add	
	}
	
}

class SWAPFactory extends AbstractOperationFactory {
	SWAP swap = new SWAP 
	
	override create(ProgramIterator programIt) {
		swap	
	}
	
}

class LODVFactory extends AbstractOperationFactory {
	
	override create(ProgramIterator programIt) {
		val dato = programIt.nextValue 
		new LODV(dato)
	}
	
}