package com.example.demo.exceptions;

public class KorisnikNotFoundException extends RuntimeException {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public KorisnikNotFoundException(String message) {
		super(message);
	}
}
