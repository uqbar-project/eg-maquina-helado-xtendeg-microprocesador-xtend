package ar.edu.microprocesador

import ar.edu.microprocesador.instrucciones.Instruccion
import java.util.List

interface Microcontroller extends Cloneable {

	/*** programacion: carga y ejecuta un conjunto de instrucciones en memoria */
	def void run(List<Instruccion> program)  

	/*** Getters y setters de acumuladores A y B */
	def byte getAAcumulator() 
	def void setAAcumulator(byte value) 
	def byte getBAcumulator() 
	def void setBAcumulator(byte value) 

	/*** Manejo de program counter */
	def void advancePC() // Avanza el program counter una instrucción
	def byte getPC()  
	def void reset() 	 // Inicializa el microcontrolador

	/*** Manejo de dirección de memoria de datos: getter y setter */
	def byte getData(int addr) 
	def void setData(int addr, byte value) 

	/*** Definición abstracta del clone */ 
	override Object clone()
	def void copyFrom(Microcontroller micro)
	
}