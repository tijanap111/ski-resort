package com.example.demo.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repositories.KategorijaStazeRepository;

import model.KategorijaStaze;

@Service
public class KategorijaStazeService {

	@Autowired
	KategorijaStazeRepository ksr;
	
	public void dodajNovuKategoriju(String naziv) {
		KategorijaStaze kategorija = new KategorijaStaze();
		kategorija.setNaziv(naziv);
		
		ksr.save(kategorija);
	}
	
	public List<KategorijaStaze> getSveKategorije() {
        return ksr.findAll();
    }
}
