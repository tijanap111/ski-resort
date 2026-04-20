package com.example.demo.services;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repositories.PorukaRepository;
import com.example.demo.repositories.PrijateljstvoRepository;

import model.Korisnik;
import model.Poruka;
import model.Prijateljstvo;

@Service
public class PorukaService {

	@Autowired
	PorukaRepository por;
	
	@Autowired
	PrijateljstvoRepository pr;
	
	public void posaljiPoruku(Korisnik posiljalac, Korisnik primalac, String tekst) {
		List<Prijateljstvo> prijateljstva = pr.getPrihvacenaPrijateljstva("PRIHVACENO", posiljalac.getKorisnikId());
		
		boolean jesuPrijatelji = false;
		
		for (Prijateljstvo p : prijateljstva) {
			if (p.getPosiljalac().equals(primalac) || p.getPrimalac().equals(primalac)) {
				jesuPrijatelji = true;
				break;
			}
		}
		
		if (jesuPrijatelji) {
			Poruka poruka = new Poruka();
			poruka.setPosiljalac(posiljalac);
			poruka.setPrimalac(primalac);
			poruka.setDatumSlanja(new Date());
			poruka.setSadrzaj(tekst);
			poruka.setProcitana(0);
			
			por.save(poruka);
		}
	}
	
	public void sacuvajPoruku(Korisnik posiljalac, Korisnik primalac, String tekst) {
		Poruka p = new Poruka();
		p.setPosiljalac(posiljalac);
		p.setPrimalac(primalac);
		p.setSadrzaj(tekst);
		p.setDatumSlanja(new Date());
		
		por.save(p);
	}
	
	public List<Poruka> getSveMojePoruke(Korisnik ulogovani) {
        return por.sveMojePoruke(ulogovani);
    } 
	
	public List<Poruka> svePorukeZaKorisnika(Korisnik k) {
	    return por.findByPrimalac(k); 
	}
}
