package ar.edu.microprocesador

import java.util.ArrayList
import java.util.List

class MicrocontrollerImpl implements Microcontroller {
	
	byte acumuladorA
	byte acumuladorB
	int programCounter
	List<Byte> datos

	new() {
		this.reset
	}
	
	override run(List<(Microcontroller) => void> program) {
		this.reset
		program.forEach [ instruccion |
			this.advancePC 
			instruccion.apply(this)
		]
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
	
}