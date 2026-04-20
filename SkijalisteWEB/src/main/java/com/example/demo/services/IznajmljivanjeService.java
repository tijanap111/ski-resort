package com.example.demo.services;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.repositories.IznajmljivanjeRepository;
import com.example.demo.repositories.SkiOpremaRepository;

import model.IznajmljivanjeOpreme;
import model.Korisnik;
import model.SkiOprema;

@Service
public class IznajmljivanjeService {

	@Autowired
	IznajmljivanjeRepository ir;
	
	@Autowired
	SkiOpremaRepository sor;
	
	@Transactional
	public void iznajmiOpremu(Korisnik k, SkiOprema oprema, int brojDana) {
	    IznajmljivanjeOpreme iznajmljivanje = new IznajmljivanjeOpreme();
	    
	    Date datumOd = new Date();
	    java.util.Calendar cal = java.util.Calendar.getInstance();
	    cal.setTime(datumOd);
	    
	    cal.add(Calendar.DAY_OF_MONTH, brojDana);
	    Date datumDo = cal.getTime();
	    
	    iznajmljivanje.setKorisnik(k);
	    iznajmljivanje.setSkiOprema(oprema);
	    iznajmljivanje.setDatumOd(datumOd);
	    iznajmljivanje.setDatumDo(datumDo);
	    iznajmljivanje.setBrojDana(brojDana);
	    
	    double ukupnaCena = oprema.getCenaPoDanu() * brojDana;
	    iznajmljivanje.setUkupnaCena(ukupnaCena);
	    
	    iznajmljivanje.setStatus("AKTIVNO");
	    
	    ir.save(iznajmljivanje);
	    
	    oprema.setDostupnaKolicina(oprema.getDostupnaKolicina() - 1);
	    sor.save(oprema);
	}
	
	public List<SkiOprema> getSvaOprema() {
	    try {
	        return sor.findAll(); 
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}
	
	public SkiOprema pronadjiOpremu(Integer id) {
	    return sor.findById(id).orElse(null);
	}
	
	public List<IznajmljivanjeOpreme> getAllIznajmljivanja() {
	    try {
	        return ir.findAll();
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}
}
