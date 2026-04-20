package com.example.demo.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import model.Korisnik;
import model.Poruka;

public interface PorukaRepository extends JpaRepository<Poruka, Long>{
	
	@Query("select p from Poruka p where p.posiljalac = :k1 and p.primalac = :k2 ")
	public List<Poruka> getKonverzaciju(@Param("k1")Korisnik k1, @Param("k2")Korisnik k2);

	@Query("select p from Poruka p where p.primalac = :k order by p.datumSlanja desc")
    List<Poruka> sveMojePoruke(@Param("k") Korisnik k);

	public List<Poruka> findByPrimalac(Korisnik k);
	
}
