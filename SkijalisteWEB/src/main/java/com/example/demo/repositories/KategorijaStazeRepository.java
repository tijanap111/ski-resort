package com.example.demo.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import model.KategorijaStaze;

public interface KategorijaStazeRepository extends JpaRepository<KategorijaStaze, Integer> {
	
	@Query("select k from KategorijaStaze k where k.naziv like %:naziv% ")
	public List<KategorijaStaze> pronadjiPoNazivu(@Param("naziv")String naziv);
}
