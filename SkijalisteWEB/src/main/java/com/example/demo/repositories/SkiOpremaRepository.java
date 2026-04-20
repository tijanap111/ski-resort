package com.example.demo.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import model.SkiOprema;

public interface SkiOpremaRepository extends JpaRepository<SkiOprema, Integer> {
	
	@Query("select o from SkiOprema o where o.naziv like %:naziv% ")
	public List<SkiOprema> pronadjiPoNazivu(@Param("naziv")String naziv);
	
	public List<SkiOprema> findByTip(String tip);

	@Query("select s from SkiOprema s where s.opremaId = :id")
	public SkiOprema getOpremaById(@Param("id") Integer id);
}
