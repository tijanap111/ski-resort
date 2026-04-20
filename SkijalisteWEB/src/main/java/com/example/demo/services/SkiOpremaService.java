package com.example.demo.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repositories.SkiOpremaRepository;

import model.SkiOprema;

@Service
public class SkiOpremaService {

	@Autowired
	SkiOpremaRepository sor;
	
	public List<SkiOprema> pretraziOpremu(String naziv) {
		List<SkiOprema> oprema = sor.pronadjiPoNazivu(naziv);
		
		return oprema;
	}
	
	public List<SkiOprema> getSvaOprema() {
        return sor.findAll();
    }

	public SkiOprema pronadjiOpremu(Integer id) {
	    return sor.getOpremaById(id);
	}
}
