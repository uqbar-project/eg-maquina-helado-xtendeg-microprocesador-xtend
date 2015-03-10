package ar.edu.microprocesador

import java.util.ArrayList
import java.util.List
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestMicrocontroller {

	Microcontroller micro
	List<(Microcontroller)=>void> instrucciones

	@Before
	def void setUp() {
		micro = new MicrocontrollerImpl
		instrucciones = new ArrayList<(Microcontroller)=>void>
	}

	@Test
	def void programCounterAvanzaConNOP() {
		instrucciones.add(NOP)
		instrucciones.add(NOP)
		instrucciones.add(NOP)
		micro.run(instrucciones)
		Assert.assertEquals(3, micro.getPC)
	}

	@Test
	def void sumaSimple() {
		instrucciones.add(LODV(10))
		instrucciones.add(SWAP)
		instrucciones.add(LODV(22))
		instrucciones.add(ADD)
		micro.run(instrucciones)
		Assert.assertEquals(0, micro.getAAcumulator)
		Assert.assertEquals(32, micro.getBAcumulator)
	}

	@Test
	def void sumaNumerosGrandes() {
		instrucciones.add(LODV(100))
		instrucciones.add(SWAP)
		instrucciones.add(LODV(50))
		instrucciones.add(ADD)
		micro.run(instrucciones)
		Assert.assertEquals(23, micro.getAAcumulator)
		Assert.assertEquals(127, micro.getBAcumulator)
	}

	@Test(expected=typeof(ArithmeticException))
	def void divisionPorCero() {
		instrucciones.add(LODV(0))
		instrucciones.add(SWAP)
		instrucciones.add(LODV(2))
		instrucciones.add(DIV)
		micro.run(instrucciones)
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
