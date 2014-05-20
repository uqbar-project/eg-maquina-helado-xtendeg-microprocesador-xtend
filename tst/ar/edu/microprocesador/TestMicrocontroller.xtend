package ar.edu.microprocesador

import org.junit.Before
import org.junit.Test
import ar.edu.microprocesador.instrucciones.NOP
import java.util.ArrayList
import ar.edu.microprocesador.instrucciones.Instruccion
import ar.edu.microprocesador.instrucciones.LODV
import ar.edu.microprocesador.instrucciones.SWAP
import ar.edu.microprocesador.instrucciones.ADD
import ar.edu.microprocesador.instrucciones.DIV
import org.junit.Assert
import ar.edu.microprocesador.instrucciones.WHNZ
import ar.edu.microprocesador.instrucciones.SUB

class TestMicrocontroller {
	
	Microcontroller micro
	
	@Before
	def void setUp() {
		micro = new MicrocontrollerImpl
	}

	@Test
	def void programCounterAvanzaConNOP() {
		var instrucciones = new ArrayList<Instruccion>
		var nop = new NOP
		instrucciones.add(nop)
		instrucciones.add(nop)
		instrucciones.add(nop)
		micro.run(instrucciones)
		Assert.assertEquals(3, micro.getPC)
	}

	@Test
	def void sumaSimple() {
		var instrucciones = new ArrayList<Instruccion>
		instrucciones.add(new LODV(10))
		instrucciones.add(new SWAP)
		instrucciones.add(new LODV(22))
		instrucciones.add(new ADD)
		micro.run(instrucciones)
		Assert.assertEquals(0, micro.getAAcumulator)
		Assert.assertEquals(32, micro.getBAcumulator)
	}

	@Test
	def void sumaNumerosGrandes() {
		var instrucciones = new ArrayList<Instruccion>
		instrucciones.add(new LODV(100))
		instrucciones.add(new SWAP)
		instrucciones.add(new LODV(50))
		instrucciones.add(new ADD)
		micro.run(instrucciones)
		Assert.assertEquals(23, micro.getAAcumulator)
		Assert.assertEquals(127, micro.getBAcumulator)
	}

	@Test(expected=typeof(ArithmeticException))
	def void divisionPorCero() {
		var instrucciones = new ArrayList<Instruccion>
		instrucciones.add(new LODV(0))
		instrucciones.add(new SWAP)
		instrucciones.add(new LODV(2))
		instrucciones.add(new DIV)
		micro.run(instrucciones)
	}

	/**
	 * BONUS 3 : requiere mayor manejo del micro
	 * Se desea poder deshacer la última instrucción ejecutada 
	 * (o sea, que el microprocesador vuelva al estado anterior). 
	 * Ejemplo: si se hizo un SWAP, el acumulador A debe volver a tener lo que
	 *  el acumulador B tenía y viceversa. 
	 **/
	@Test
	def void undoSWAP() {
		var carga100 = new LODV(100)
		var swap = new SWAP
		carga100.execute(micro)
		swap.execute(micro)
		Assert.assertEquals(100, micro.getBAcumulator)
		Assert.assertEquals(0, micro.getAAcumulator)
		swap.undo(micro)
		Assert.assertEquals(0, micro.getBAcumulator)
		Assert.assertEquals(100, micro.getAAcumulator)
	}

	/**
	 * Segundo test, undo
	 * En el caso del ADD se debe deshacer 
	 *  la suma y los valores de los acumuladores deben quedar como estaban
	 *  previamente. 
	 */
	@Test
	def void undoADD() {
		var carga100 = new LODV(100)
		var swap = new SWAP
		carga100.execute(micro)
		swap.execute(micro)
		new LODV(50).execute(micro)
		var suma = new ADD
		suma.execute(micro)
		Assert.assertEquals(23, micro.getAAcumulator)
		Assert.assertEquals(127, micro.getBAcumulator)
		suma.undo(micro)
		Assert.assertEquals(50, micro.getAAcumulator)
		Assert.assertEquals(100, micro.getBAcumulator)
	}

	// Test que prueba el while de 1 a 10 
	@Test
	def void for1a10() {
		var instrucciones = new ArrayList<Instruccion>
		// Cargo diez 
		instrucciones.add(new LODV(1))
		instrucciones.add(new SWAP)
		instrucciones.add(new LODV(10))
		
		var subInstrucciones = new ArrayList<Instruccion>
		subInstrucciones.add(new SUB)
		subInstrucciones.add(new LODV(1))
		subInstrucciones.add(new SWAP)
		var bloqueWhile = new WHNZ(subInstrucciones)
		instrucciones.add(bloqueWhile)
		micro.run(instrucciones)
		
		Assert.assertEquals(10, bloqueWhile.vecesQueFueEjecutado)
	}
	
}