package com.example.demo.services;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repositories.OmiljenaStazaRepository;

import model.Korisnik;
import model.OmiljenaStaza;
import model.Staza;

@Service
public class OmiljenaStazaService {

	@Autowired
	OmiljenaStazaRepository osp;
	
	public void dodajOmiljene(Korisnik k, Staza s) {
		if (!osp.daLiJeOmiljena(k, s)) {
			OmiljenaStaza novaOmiljena = new OmiljenaStaza();
			novaOmiljena.setKorisnik(k);
			novaOmiljena.setStaza(s);
			novaOmiljena.setDatumDodavanja(new Date());
			
			osp.save(novaOmiljena);
		}
	}
	
	public void izbaciIzOmiljenih(int omiljenaId) {
		osp.deleteById(omiljenaId);
	}
	
	public List<OmiljenaStaza> getOmiljeneStazeZaKorisnika(Korisnik k) {
		return osp.findByKorisnik(k);
	}
}
