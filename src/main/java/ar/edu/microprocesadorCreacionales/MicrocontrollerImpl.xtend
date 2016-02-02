package ar.edu.microprocesadorCreacionales

import ar.edu.microprocesadorCreacionales.creationals.ProgramIterator
import ar.edu.microprocesadorCreacionales.excepciones.SystemException
import java.util.ArrayList
import java.util.List

class MicrocontrollerImpl implements Microcontroller {
	
	byte acumuladorA
	byte acumuladorB
	int programCounter
	List<Byte> datos
	boolean programStarted
	ProgramIterator programIterator
	
	new() {
		this.reset()
	}
	
	/** Manejo del estado del microcontroller */
	override getAAcumulator() {
		acumuladorA
	}
	
	override setAAcumulator(byte value) {
		acumuladorA = value
	}
	
	override getBAcumulator() {
		acumuladorB
	}
	
	override setBAcumulator(byte value) {
		acumuladorB = value
	}
	
	override getPC() {
		programCounter as byte
	}
	
	override advancePC() {
		programCounter = programCounter + 1
	}
	
	override reset() {
		programCounter = 0 as byte
		acumuladorA = 0 as byte
		acumuladorB = 0 as byte
		datos = new ArrayList<Byte>(1024) 
		for (int i : 0..1023) {
			datos.add(0 as byte)
		}
	}
	
	override getData(int addr) {
		datos.get(addr) as byte
	}
	
	override setData(int addr, byte value) {
		datos.set(addr, value)
	}
	
	override copyFrom(Microcontroller micro) {
		acumuladorA = micro.AAcumulator
		acumuladorB = micro.BAcumulator
		programCounter = micro.PC
		programCounter = programCounter - 1
		for (int i : 0..1023) {
			val data = micro.getData(i) as byte
			this.setData(i, data)
		}
	}
	
	override clone() {
		try {
			return super.clone as Microcontroller
		} catch (CloneNotSupportedException e) {
			throw new SystemException(e)
		}
	}
	
	override loadProgram(List<Byte> program) {
		if (this.programStarted) {
			throw new SystemException("Ya hay un programa en ejecución")
		}
		this.reset()
		this.programIterator = new ProgramIterator(program)
		//this.programMemory = program
	}
	
	override setInput(byte channel, byte value) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override setPC(int value) {
		throw new UnsupportedOperationException("Use advancePC() instead")
	}
	
	override start() {
		this.programStarted = true
	}

	override stop() {
		this.programStarted = false
	}

	override step() {
		if (!this.programStarted) {
			throw new SystemException("No hay un programa en ejecución")
		}
		if (this.programIterator == null) {
			throw new SystemException("No hay un programa cargado en memoria")
		}
		if (!programIterator.hasNext()) {
			throw new SystemException("No hay más instrucciones para ejecutar")
		}
		programIterator.next().execute(this)
		this.advancePC()
	}

	
}