package ar.edu.microprocesador

import ar.edu.microprocesador.creationals.ProgramBuilder
import ar.edu.microprocesador.excepciones.SystemException
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
		programNOP = new ProgramBuilder().NOP.NOP.NOP.build
		programSuma8y5 = new ProgramBuilder().LODV(8).SWAP.LODV(5).ADD.build()
	}

	@Test
	def void nop() {
		micro.loadProgram(programNOP)
		micro.start()
		micro.step()
		micro.step()
		micro.step()
		micro.stop()
		Assert.assertEquals(3, micro.PC)
	}

	@Test
	def void suma() {
		micro.loadProgram(programSuma8y5)
		micro.start()
		micro.step()
		micro.step()
		micro.step()
		micro.step()
		micro.stop()
		Assert.assertEquals(13, micro.AAcumulator)
		Assert.assertEquals(0, micro.BAcumulator)
	}

	@Test(expected=typeof(SystemException))
	def void cargarProgramaMientrasOtroEjecuta() {
		micro.loadProgram(programNOP)
		micro.start()
		micro.loadProgram(programNOP)
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
