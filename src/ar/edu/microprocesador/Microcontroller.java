package ar.edu.microprocesador;

import java.util.List;

public interface Microcontroller extends Cloneable {

	// programacion
	/**
	 * carga el programa en memoria, el microcontrolador debe estar detenido
	 */
	public void loadProgram(List<Byte> program); //

	// control de programa
	/**
	 * Borra la memoria de datos y comienza la ejecucion del programa cargado
	 * actualmente
	 */
	public void start();

	/**
	 * Detiene el programa en ejecucion
	 */
	public void stop();

	/**
	 * Ejecuta la siguiente instruccion del programa actual
	 */
	public void step();

	/**
	 * Inicializa el microcontrolador
	 */
	public void reset();

	// E/S
	/**
	 * Pone un valor en el canal de E/S que sera leido por la proxima
	 * instrucci�n IN que haga referencia al canal indicado
	 */
	public void setInput(byte channel, byte value);

	// monitoreo y debugging
	/**
	 * Retorna el valor del acumulador A
	 */
	public byte getAAcumulator();

	/**
	 * Setea el valor del acumulador A
	 * 
	 * @param value
	 */
	public void setAAcumulator(byte value);

	/**
	 * Retorna el valor del acumulador B
	 * 
	 * @return
	 */
	public byte getBAcumulator();

	/**
	 * Setea el valor del acumulador B
	 * 
	 * @param value
	 */
	public void setBAcumulator(byte value);

	/**
	 * Retorna el valor del PC
	 * 
	 * @return
	 */
	public byte getPC();

	/**
	 * Setea el valor del PC
	 * 
	 * @deprecated
	 * @use advancePC
	 * @param value
	 * @return
	 */
	public byte setPC(int value);

	/**
	 * Avanza el program counter un byte
	 * 
	 * @return
	 */
	public void advancePC();

	/**
	 * Retorna el valor de la memoria de datos en la direccion indicada
	 * 
	 * @param addr
	 *            direcci�n de memoria
	 * @return
	 */
	public byte getData(int addr); //

	/**
	 * Setea el valor de la memoria de datos en la direccion indicada
	 * 
	 * @param addr
	 *            direcci�n de memoria
	 * @param value
	 *            un valor
	 */
	public void setData(int addr, byte value); //

	public void copyFrom(Microcontroller micro);

	public Microcontroller clone();
	/**
	 * Retorna el valor de la memoria de programa en la direccion indicada
	 * 
	 * @param addr
	 * @return
	 */
	//public byte getProgram(int addr);

	/**
	 * Setea el valor de la memoria de programa
	 * 
	 * @param addr
	 * @param value
	 */
	//public void setProgram(int addr, byte value);

}
