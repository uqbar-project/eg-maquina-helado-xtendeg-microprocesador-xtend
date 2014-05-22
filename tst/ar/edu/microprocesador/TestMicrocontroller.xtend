package ar.edu.microprocesador

import ar.edu.microprocesador.excepciones.SystemException
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

		programNOP = new ArrayList<Byte>
		programNOP.add(1 as byte) // NOP
		programNOP.add(1 as byte) // NOP
		programNOP.add(1 as byte) // NOP

		programSuma8y5 = new ArrayList<Byte>
		programSuma8y5.add(9 as byte) // LODV 
		programSuma8y5.add(8 as byte) // dato: 8  
		programSuma8y5.add(5 as byte) // SWAP
		programSuma8y5.add(9 as byte) // LODV 
		programSuma8y5.add(5 as byte) // dato: 5
		programSuma8y5.add(2 as byte) // ADD
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
		micro.loadProgram(programSuma8y5)
		micro.start()
		micro.step()
		micro.step()
		micro.step()
		micro.step()
		micro.stop()
		Assert.assertEquals(13, micro.AAcumulator)
		Assert.assertEquals(0, micro.BAcumulator)

		micro.loadProgram(programNOP)
		micro.start()
		micro.step()
		micro.step()
		micro.step()
		micro.stop()
		Assert.assertEquals(3, micro.PC)
		Assert.assertEquals(0, micro.AAcumulator)
		Assert.assertEquals(0, micro.BAcumulator)
	}

}
