package ar.edu.microprocesadorCreacionales

import ar.edu.microprocesadorCreacionales.creationals.ProgramBuilder
import ar.edu.microprocesadorCreacionales.excepciones.SystemException
import java.util.List
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestMicrocontrollerRefactorizado {

	Microcontroller micro
	List<Byte> programNOP
	List<Byte> programSuma8y5

	@Before
	def void setUp() {
		micro = new MicrocontrollerImpl
		programNOP = new ProgramBuilder().NOP.NOP.NOP.build
		programSuma8y5 = new ProgramBuilder().LODV(8).SWAP.LODV(5).ADD.build()
	}

	@Test
	def void nop() {
		micro => [
			loadProgram(programNOP)
			start
			step
			step
			step
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
		suma()
		nop()
	}

}
