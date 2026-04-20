package com.example.demo.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import model.Korisnik;
import model.OmiljenaStaza;
import model.Staza;

public interface OmiljenaStazaRepository extends JpaRepository<OmiljenaStaza, Integer> {
	
	public List<OmiljenaStaza> findByKorisnik(Korisnik k);
	
	@Query("SELECT count(os) > 0 FROM OmiljenaStaza os WHERE os.korisnik = :k AND os.staza = :s")
	boolean daLiJeOmiljena(@Param("k") Korisnik k, @Param("s") Staza s);
	
	
}
