package com.example.demo.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import model.IznajmljivanjeOpreme;
import model.Korisnik;

public interface IznajmljivanjeRepository extends JpaRepository<IznajmljivanjeOpreme, Integer> {
	
	public List<IznajmljivanjeOpreme> findByKorisnik(Korisnik k);
	
	public List<IznajmljivanjeOpreme> findByStatus(String status);
}
