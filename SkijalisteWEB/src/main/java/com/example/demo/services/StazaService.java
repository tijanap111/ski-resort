package com.example.demo.services;


import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.repositories.OmiljenaStazaRepository;
import com.example.demo.repositories.StazaRepository;

import model.Korisnik;
import model.OmiljenaStaza;
import model.Staza;

@Service
public class StazaService {
	
	@Autowired
	StazaRepository sr;
	
	@Autowired
	OmiljenaStazaRepository osr;
	
	public List<Staza> pretrazujPoNazivu(String naziv) {
		return sr.pronadjiStazePoNazivu(naziv);
	}
	
	public List<Staza> pretrazujPoTezini(String tezina) {
		return sr.findByTezina(tezina);
	}
	
	public void dodajUOmiljene(Korisnik korisnik, Staza staza) {
		if (!osr.daLiJeOmiljena(korisnik, staza)) {
			OmiljenaStaza os = new OmiljenaStaza();
			os.setKorisnik(korisnik);
			os.setStaza(staza);
			Date datum = new Date();
			os.setDatumDodavanja(datum);
			
			osr.save(os);
		}
	}
	
	public List<Staza> getSveStaze() {
	    return sr.findAll();
	}
	
	public List<Staza> getPoKategoriji(Integer kategorijaId) {
	    return sr.getPoKategoriji(kategorijaId); 
	}
	
	public Staza pronadjiStazuPoId(Integer id) {
        return sr.pronadjiStazuPoId(id);
    }

	public List<Staza> getSveStazeSortirane() {
		return sr.findAllByOrderByTezinaAsc();
	}
	
	@Transactional
	public void promeniStatusStaze(Integer stazaId) {
	    Staza s = sr.findById(stazaId).get();
	    if (s.getStatus().equals("OTVORENA")) {
	        s.setStatus("ZATVORENA");
	    } else {
	        s.setStatus("OTVORENA");
	    }
	}
}
