package com.example.demo.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import model.Staza;

public interface StazaRepository extends JpaRepository<Staza, Integer>{
	public List<Staza> findByTezina(String tezina);
	public List<Staza> findByStatus(String status);
	
	@Query("select s from Staza s where s.naziv like %:naziv% ")
	public List<Staza> pronadjiStazePoNazivu(@Param("naziv")String naziv);
	
	@Query("select s from Staza s where s.stazaId = :id")
    public Staza pronadjiStazuPoId(@Param("id") Integer id);
	
	@Query("select s from Staza s where s.kategorijaStaze.kategorijaId = :id")
    List<Staza> getPoKategoriji(@Param("id") Integer id);
	
	public List<Staza> findAllByOrderByTezinaAsc();
}
