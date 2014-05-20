package ar.edu.microprocesador.excepciones

class SystemException extends RuntimeException {

	new(Throwable e) {
		super(e)
	}
	
	new(String msg, Throwable e) {
		super(msg, e)
	}	
	
}