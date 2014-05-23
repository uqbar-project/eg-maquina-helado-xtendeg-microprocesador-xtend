package ar.edu.microprocesador.creationals

import ar.edu.microprocesador.instrucciones.Instruccion
import java.util.Iterator
import java.util.List

class ProgramIterator implements Iterator<Instruccion> {

	List<Byte> programMemory
	byte index

	new(List<Byte> program) {
		programMemory = program
		index = 0 as byte
	}

	override hasNext() {
		readByteActual > 0
	}

	def byte readByteActual() {
		programMemory.get(index)
	}

	override remove() {
		throw new UnsupportedOperationException("remove - Program Iterator")
	}

	override next() {
		val instruccion = InstruccionFactory.instance.getInstruction(nextValue)
		instruccion.prepare(this)
		instruccion
	}

	def byte nextValue() {
		val valorActual = this.readByteActual
		this.advanceIndex()
		valorActual
	}

	def void advanceIndex() {
		index = (index + 1) as byte
	}

}
