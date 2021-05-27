package ar.edu.microprocesadorCreacionales

import ar.edu.microprocesadorCreacionales.creationals.ProgramBuilder
import ar.edu.microprocesadorCreacionales.excepciones.SystemException
import java.util.List
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import static org.junit.jupiter.api.Assertions.assertEquals
import static org.junit.jupiter.api.Assertions.assertThrows

@DisplayName("(Versión refactorizada) Dado un microprocesador")
class TestMicrocontrollerRefactorizado {

	Microcontroller micro

	@BeforeEach
	def void setUp() {
		micro = new MicrocontrollerImpl
	}

	def programNOP() {
		new ProgramBuilder()
			.NOP
			.NOP
			.NOP
			.build
	}
			
	def	programSuma8y5() {
		new ProgramBuilder()
			.LODV(8)
			.SWAP
			.LODV(5)
			.ADD
			.build	
	}
	
	@Test
	@DisplayName("al ejecutar cada instrucción va avanzando el program counter")
	def void nop() {
		micro => [
			loadProgram(programNOP)
			run
		]
		assertEquals(3, micro.PC)
	}

	@Test
	@DisplayName("puede hacer una suma de números pequeños y dejar el resultado en los acumuladores")
	def void suma() {
		micro => [
			loadProgram(programSuma8y5)
			run
		]
		assertEquals(13, micro.AAcumulator)
		assertEquals(0, micro.BAcumulator)
	}

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
		suma()
		nop()
	}

}
