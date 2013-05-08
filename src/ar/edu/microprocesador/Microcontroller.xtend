package ar.edu.microprocesador

import java.util.List
import ar.edu.microprocesador.instrucciones.Instruccion

abstract class Microcontroller implements Cloneable {
	
	/**
	 * programacion: carga y ejecuta un conjunto de instrucciones en memoria
	 * 
	 * @param program
	 *            un conjunto de instrucciones a ejecutar en el orden en que se
	 *            ingresaron
	 */
	def void run(List<Instruccion> program)

	/**
	 * E/S Pone un valor en el canal de E/S que sera leido por la proxima
	 * instrucci�n IN que haga referencia al canal indicado monitoreo y
	 * debugging
	 */
	// def void setInput(byte channel, byte value)

	/**
	 * Retorna el valor del acumulador A
	 */
	def byte getAAcumulator()

	/**
	 * Setea el valor del acumulador A
	 */
	def void setAAcumulator(byte value)

	/**
	 * Retorna el valor del acumulador B
	 */
	def byte getBAcumulator()

	/**
	 * Setea el valor del acumulador B
	 */
	def void setBAcumulator(byte value)

	/**
	 * Retorna el valor del PC
	 */
	def int getPC()

	/**
	 * Avanza el program counter una instrucci�n
	 */
	def void advancePC()

	/**
	 * Inicializa el microcontrolador
	 */
	def void reset()

	/**
	 * Retorna el valor de la memoria de datos en la direccion indicada
	 * 
	 * @param addr
	 *            direcci�n de memoria
	 * @return valor de la memoria de datos en esa direcci�n
	 */
	def byte getData(int addr)

	/**
	 * Setea el valor de la memoria de datos en la direccion indicada
	 * 
	 * @param addr
	 *            direcci�n de memoria
	 * @param value
	 *            un valor
	 */
	def void setData(int addr, byte value)

	/**
	 * AGREGADOS PARA UNDO
	 */
	
	/**
	 * copia el estado de un microcontrolador a otro
	 * @param micro desde el cual se va a copiar el estado (origen), el destino es el objeto receptor
	 */
	def void copyFrom(Microcontroller micro)
	
	override Object clone() {
		super.clone
	}
	
}