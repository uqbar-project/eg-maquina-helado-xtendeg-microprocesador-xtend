package ar.edu.microprocesador;

import java.util.List;

import ar.edu.microprocesador.instrucciones.Instruccion;

public interface Microcontroller extends Cloneable {

	/*** programacion: carga y ejecuta un conjunto de instrucciones en memoria */
	public void run(List<Instruccion> program);  

	/*** Getters y setters de acumuladores A y B */
	public byte getAAcumulator(); 
	public void setAAcumulator(byte value); 
	public byte getBAcumulator(); 
	public void setBAcumulator(byte value); 

	/*** Manejo de program counter */
	public void advancePC(); // Avanza el program counter una instrucción
	public byte getPC();  
	public void reset(); 	 // Inicializa el microcontrolador

	/*** Manejo de dirección de memoria de datos: getter y setter */
	public byte getData(int addr); 
	public void setData(int addr, byte value); 

	/*** Definición abstracta del clone */ 
	public Object clone();
	public void copyFrom(Microcontroller micro);
}
