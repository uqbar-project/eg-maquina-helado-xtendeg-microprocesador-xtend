package ar.edu.microprocesador

import ar.edu.microprocesador.instrucciones.ADD
import ar.edu.microprocesador.instrucciones.DIV
import ar.edu.microprocesador.instrucciones.IFNZ
import ar.edu.microprocesador.instrucciones.Instruccion
import ar.edu.microprocesador.instrucciones.LOD
import ar.edu.microprocesador.instrucciones.LODV
import ar.edu.microprocesador.instrucciones.NOP
import ar.edu.microprocesador.instrucciones.STR
import ar.edu.microprocesador.instrucciones.SUB
import ar.edu.microprocesador.instrucciones.SWAP
import ar.edu.microprocesador.instrucciones.WHNZ
import java.util.ArrayList
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertEquals
import static org.junit.jupiter.api.Assertions.assertThrows

@DisplayName("Dado un microprocesador")
class TestMicrocontroller {

	Microcontroller micro
	Instruccion swap = new SWAP

	@BeforeEach
	def void init() {
		micro = new MicrocontrollerImpl
	}

	@Test
	@DisplayName("al ejecutar un programa con NOPs va avanzando el program counter")
	def void programCounterAvanzaConNOP() {
		val nop = new NOP
		micro.run(
			#[ 
				nop, 
				nop, 
				nop
			]
			)
		assertEquals(3, micro.getPC)
	}

	@Test
	@DisplayName("puede hacer una suma simple y dejar el resultado en los acumuladores")
	def void sumaSimple() {
		micro.run(#[
			new LODV(10),
			swap,
			new LODV(22),
			new ADD
		])
		assertEquals(32, micro.getAAcumulator)
		assertEquals(0, micro.getBAcumulator)
	}

	@Test
	@DisplayName("puede hacer una suma de números grandes y dejar el resultado en los acumuladores")
	def void sumaNumerosGrandes() {
		micro.run(
			#[
				new LODV(100),
				swap,
				new LODV(50),
				new ADD
			])
		assertEquals(127, micro.getAAcumulator)
		assertEquals(23, micro.getBAcumulator)
	}

	@Test
	@DisplayName("al dividir por cero debe detener la ejecución por error")
	def void divisionPorCero() {
		assertThrows(ArithmeticException, [
			micro.run(
				#[
					new LODV(0),
					swap,
					new LODV(2),
					new DIV
				]
			)
		])
	}

	/**
	 * BONUS 3 : requiere mayor manejo del micro
	 * Se desea poder deshacer la última instrucción ejecutada 
	 * (o sea, que el microprocesador vuelva al estado anterior). 
	 * Ejemplo: si se hizo un SWAP, el acumulador A debe volver a tener lo que
	 *  el acumulador B tenía y viceversa. 
	 **/
	@Test
	@DisplayName("puede deshacer un SWAP correctamente, dejando los acumuladores como estaban")
	def void undoSWAP() {
		val carga100 = new LODV(100)
		val swap = swap
		carga100.execute(micro)
		swap.execute(micro)
		assertEquals(100, micro.getBAcumulator)
		assertEquals(0, micro.getAAcumulator)
		swap.undo(micro)
		assertEquals(0, micro.getBAcumulator)
		assertEquals(100, micro.getAAcumulator)
	}

	/**
	 * Segundo test, undo
	 * En el caso del ADD se debe deshacer 
	 *  la suma y los valores de los acumuladores deben quedar como estaban
	 *  previamente. 
	 */
	@Test
	@DisplayName("puede deshacer una suma correctamente, dejando los acumuladores como estaban")
	def void undoADD() {
		val carga100 = new LODV(100)
		val swap = swap
		carga100.execute(micro)
		swap.execute(micro)
		new LODV(50).execute(micro)
		val suma = new ADD
		suma.execute(micro)
		assertEquals(127, micro.getAAcumulator)
		assertEquals(23, micro.getBAcumulator)
		suma.undo(micro)
		assertEquals(50, micro.getAAcumulator)
		assertEquals(100, micro.getBAcumulator)
	}

	@Test
	@DisplayName("puede resolver un if exitosamente - rama verdadera por el if")
	def void ifSWAP() {
		micro.AAcumulator = 5 as byte
		micro.BAcumulator = 9 as byte
		micro.run(#[
			new IFNZ(#[swap])
		])
		assertEquals(9, micro.AAcumulator)
		assertEquals(5, micro.BAcumulator)
	}

	@Test
	@DisplayName("puede resolver un if exitosamente - rama falsa por el else")
	def void ifSWAPnot() {
		micro.AAcumulator = 0 as byte
		micro.BAcumulator = 9 as byte
		micro.run(#[
			new IFNZ(#[swap])
		])
		assertEquals(0, micro.AAcumulator)
		assertEquals(9, micro.BAcumulator)
	}

	@Test
	@DisplayName("puede resolver un if exitosamente - múltiples operaciones")
	def void ifVariasInstrucciones() {
		micro.AAcumulator = 5 as byte
		micro.BAcumulator = 9 as byte
		micro.run(#[
			new IFNZ(#[
				swap,
				new ADD
			])
		])
		assertEquals(14, micro.AAcumulator)
		assertEquals(0, micro.BAcumulator)
	}

	@Test
	@DisplayName("puede sumar los primeros cinco números utilizando un while")
	def void sumaPrimeros5Numeros() {
		// Cargo 0 (el T = total) en el campo de datos 1
		// Cargo 5 (el I = indice) en Acumulador A 
		val programaSuma5PrimerosNumeros = new ArrayList<Instruccion> => [
			add(new LODV(0))
			add(new STR(1))
			add(new LODV(5))	
		]

		val iteracion = new ArrayList<Instruccion> => [
			// sumo al total el valor actual de I
			add(new STR(0)) // guardo I en dir0 
			add(swap) // lo paso a AcumB 
			add(new LOD(1)) // bajo el total a AcumA
			add(new ADD) // sumo Total + I
			add(new STR(1)) // guardo esa suma en dir1

			// resto 1 a I
			add(new LODV(1)) // cargo 1 en AcumA 
			add(swap) // lo paso a AcumB
			add(new LOD(0)) // cargo I en AcumA
			add(new SUB) // obtengo I - 1
		]

		// ... y sigue el while
		val bloqueWhile = new WHNZ(iteracion)

		// cuando termina el while , bajo el total a AcumA
		programaSuma5PrimerosNumeros => [
			add(bloqueWhile)
			add(new LOD(1))
		]
		micro.run(programaSuma5PrimerosNumeros)
		assertEquals(15, micro.AAcumulator)
	}

}
