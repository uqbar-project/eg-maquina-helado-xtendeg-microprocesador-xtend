package ar.edu.microprocesadorCreacionales

import ar.edu.microprocesadorCreacionales.excepciones.SystemException
import java.util.ArrayList
import java.util.List
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestMicrocontroller {

	Microcontroller micro
	List<Byte> programNOP
	List<Byte> programSuma8y5

	@Before
	def void setUp() {
		micro = new MicrocontrollerImpl

		programNOP = new ArrayList<Byte> => [
			add(1 as byte) // NOP
			add(1 as byte) // NOP
			add(1 as byte) // NOP
		]

		programSuma8y5 = new ArrayList<Byte> => [
			add(9 as byte) // LODV
			add(8 as byte) // dato: 8
			add(5 as byte) // SWAP
			add(9 as byte) // LODV
			add(5 as byte) // dato: 5
			add(2 as byte) // ADD
		]
	}

	@Test
	def void nop() {
		micro => [
			loadProgram(programNOP)
			start
			step
			step
			step
			stop
		]
		Assert.assertEquals(3, micro.PC)
	}

	@Test
	def void suma() {
		micro => [
			loadProgram(programSuma8y5)
			start
			step
			step
			step
			step
			stop
		]
		Assert.assertEquals(13, micro.AAcumulator)
		Assert.assertEquals(0, micro.BAcumulator)
	}

	@Test(expected=typeof(SystemException))
	def void cargarProgramaMientrasOtroEjecuta() {
		micro => [
			loadProgram(programNOP)
			start
			loadProgram(programNOP)
		]
	}

	@Test(expected=typeof(SystemException))
	def void ejecutarProgramaNoEmpezado() {
		micro.step()
	}

	@Test(expected=typeof(SystemException))
	def void ejecutarProgramaNoCargado() {
		micro.start()
		micro.step()
	}

	@Test
	def void ejecutarDosProgramas() {
		micro => [
			loadProgram(programSuma8y5)
			start
			step
			step
			step
			step
			stop
			Assert.assertEquals(13, AAcumulator)
			Assert.assertEquals(0, BAcumulator)
			
			loadProgram(programNOP)
			start
			step
			step
			step
			stop
			Assert.assertEquals(3, PC)
			Assert.assertEquals(0, AAcumulator)
			Assert.assertEquals(0, BAcumulator)
		]
	}

}
