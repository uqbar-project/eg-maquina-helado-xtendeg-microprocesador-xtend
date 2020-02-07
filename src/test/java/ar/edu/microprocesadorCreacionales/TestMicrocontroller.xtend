package ar.edu.microprocesadorCreacionales

import ar.edu.microprocesadorCreacionales.excepciones.SystemException
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
	List<Byte> programNOP
	List<Byte> programSuma8y5

	@BeforeEach
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
	@DisplayName("al ejecutar cada instrucción va avanzando el program counter")
	def void nop() {
		micro => [
			loadProgram(programNOP)
			start
			step
			step
			step
			stop
		]
		assertEquals(3, micro.PC)
	}

	@Test
	@DisplayName("puede hacer una suma de números pequeños y dejar el resultado en los acumuladores")
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
		assertEquals(13, micro.AAcumulator)
		assertEquals(0, micro.BAcumulator)
	}

	@Test
	@DisplayName("al intentar cargar un programa mientras otro lo ejecuta debe resultar en error")
	def void cargarProgramaMientrasOtroEjecuta() {
		assertThrows(SystemException, [
			micro => [
				loadProgram(programNOP)
				start
				loadProgram(programNOP)
			]
		])
	}

	@Test
	@DisplayName("no permite ejecutar un programa si el micro no fue iniciado")
	def void ejecutarProgramaNoEmpezado() {
		assertThrows(SystemException, [
			micro.step()
		])
	}

	@Test
	@DisplayName("no permite ejecutar un programa que no fue cargado en su memoria")
	def void ejecutarProgramaNoCargado() {
		assertThrows(SystemException, [
			micro.start()
			micro.step()
		])
	}

	@Test
	@DisplayName("puede ejecutar un programa a continuación de otro")
	def void ejecutarDosProgramas() {
		micro => [
			loadProgram(programSuma8y5)
			start
			step
			step
			step
			step
			stop
			assertEquals(13, AAcumulator)
			assertEquals(0, BAcumulator)
			
			loadProgram(programNOP)
			start
			step
			step
			step
			stop
			assertEquals(3, PC)
			assertEquals(0, AAcumulator)
			assertEquals(0, BAcumulator)
		]
	}

}
