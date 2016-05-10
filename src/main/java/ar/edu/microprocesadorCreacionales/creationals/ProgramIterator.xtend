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
		index < programMemory.length
	}

	override remove() {
		throw new UnsupportedOperationException("remove - Program Iterator")
	}

	override next() {
		val nextValue = this.nextValue()
		val instruccion = InstruccionFactory.instance.getInstruction(nextValue) 
		instruccion.prepare(this)
		instruccion
	}

	def byte nextValue() {
		programMemory.get(index++)
	}

}
