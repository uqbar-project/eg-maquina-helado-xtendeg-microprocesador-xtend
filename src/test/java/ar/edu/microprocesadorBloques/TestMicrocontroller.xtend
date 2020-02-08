package ar.edu.microprocesadorBloques

import java.util.ArrayList
import java.util.List
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertEquals
import static org.junit.jupiter.api.Assertions.assertThrows

@DisplayName("Dado un microprocesador")
class TestMicrocontroller {

	Microcontroller micro
	List<(Microcontroller)=>void> instrucciones

	@BeforeEach
	def void setUp() {
		micro = new MicrocontrollerImpl
		instrucciones = new ArrayList<(Microcontroller)=>void>
	}

	@Test
	@DisplayName("al ejecutar cada instrucción va avanzando el program counter")
	def void programCounterAvanzaConNOP() {
		instrucciones.add(NOP)
		instrucciones.add(NOP)
		instrucciones.add(NOP)
		micro.run(instrucciones)
		assertEquals(3, micro.getPC)
	}

	@Test
	@DisplayName("puede hacer una suma de números pequeños y dejar el resultado en los acumuladores")
	def void sumaSimple() {
		instrucciones.add(LODV(10))
		instrucciones.add(SWAP)
		instrucciones.add(LODV(22))
		instrucciones.add(ADD)
		micro.run(instrucciones)
		assertEquals(0, micro.getAAcumulator)
		assertEquals(32, micro.getBAcumulator)
	}

	@Test
	@DisplayName("puede hacer una suma de números grandes y dejar el resultado en los acumuladores")
	def void sumaNumerosGrandes() {
		instrucciones.add(LODV(100))
		instrucciones.add(SWAP)
		instrucciones.add(LODV(50))
		instrucciones.add(ADD)
		micro.run(instrucciones)
		assertEquals(23, micro.getAAcumulator)
		assertEquals(127, micro.getBAcumulator)
	}

	@Test
	@DisplayName("la división por cero resulta en error")
	def void divisionPorCero() {
		assertThrows(ArithmeticException, [
			instrucciones.add(LODV(0))
			instrucciones.add(SWAP)
			instrucciones.add(LODV(2))
			instrucciones.add(DIV)
			micro.run(instrucciones)
		])
	}

	/** ******************************************************************************/
	/**                        Instrucciones como bloques                           **/
	/** ******************************************************************************/
	def (Microcontroller)=>void NOP() {
		[micro|]
	}

	def (Microcontroller)=>void LODV(int valor) {
		[micro|micro.AAcumulator = valor as byte]
	}

	def (Microcontroller)=>void SWAP() {
		[ micro |
			val byte swapValue = micro.getBAcumulator
			micro.BAcumulator = micro.getAAcumulator
			micro.AAcumulator = swapValue
		]
	}

	def (Microcontroller)=>void DIV() {
		[ micro |
			var result = micro.getAAcumulator / micro.getBAcumulator
			if (result > Byte.MAX_VALUE) {
				micro.BAcumulator = Byte.MAX_VALUE
				micro.AAcumulator = (result - Byte.MAX_VALUE) as byte
			} else {
				micro.BAcumulator = result as byte
				micro.AAcumulator = 0 as byte
			}
		]
	}

	def (Microcontroller)=>void ADD() {
		[ micro |
			var suma = micro.getAAcumulator + micro.getBAcumulator
			if (suma > Byte.MAX_VALUE) {
				micro.BAcumulator = Byte.MAX_VALUE
				micro.AAcumulator = (suma - Byte.MAX_VALUE) as byte
			} else {
				micro.BAcumulator = suma as byte
				micro.AAcumulator = 0 as byte
			}
		]
	}

}
