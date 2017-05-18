package ar.edu.microprocesadorCreacionales.creationals

import ar.edu.microprocesadorCreacionales.instrucciones.Instruccion
import java.util.Iterator
import java.util.List

class ProgramIterator implements Iterator<Instruccion> {

	List<Byte> programMemory
	int index

	new(List<Byte> program) {
		programMemory = program
		index = 0
	}

	override hasNext() {
		index < programMemory.size
	}

	override remove() {
		throw new UnsupportedOperationException("remove - Program Iterator")
	}

	override next() {
		val instructionCode = this.nextValue()
		InstruccionFactory.instance.getInstruction(this, instructionCode) 
	}

	def byte nextValue() {
		programMemory.get(index++)
	}

}
