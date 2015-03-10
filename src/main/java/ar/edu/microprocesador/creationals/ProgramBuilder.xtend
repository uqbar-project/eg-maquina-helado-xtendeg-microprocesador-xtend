package ar.edu.microprocesador.creationals

import java.util.ArrayList
import java.util.List

class ProgramBuilder {
	List<Byte> programa = new ArrayList<Byte>
	
	def List<Byte> build() {
		programa
	}
	
	def ProgramBuilder NOP() {
		this.agregarByte(1)
	}

	def ProgramBuilder ADD() {
		this.agregarByte(2)
	}
	
	def ProgramBuilder SWAP() {
		this.agregarByte(5)
	}
	
	def ProgramBuilder LODV(int dato) {
		this.agregarByte(9)
		this.agregarByte(dato)
	}
	
	def ProgramBuilder agregarByte(int datoOInstruccion) {
		programa.add(datoOInstruccion as byte)
		this
	}

}