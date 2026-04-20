package com.example.demo.services;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.demo.repositories.PrijateljstvoRepository;
import model.Korisnik;
import model.Prijateljstvo;

@Service
public class PrijateljstvoService {
	
	@Autowired
	PrijateljstvoRepository pr;
	
	public void posaljiZahtev(Korisnik posiljalac, Korisnik primalac) {
	    List<Prijateljstvo> veza = pr.proveriPrijateljstvo(posiljalac.getKorisnikId(), primalac.getKorisnikId());
	    if (veza.isEmpty()) {
	        Prijateljstvo p = new Prijateljstvo();
	        p.setPosiljalac(posiljalac);
	        p.setPrimalac(primalac);
	        p.setDatumZahteva(new Date());
	        p.setStatus("CEKANJE");
	        pr.save(p);
	    }
	}
	
	public void prihvatiZahtev(long prijateljstvoId) {
	    Prijateljstvo p = pr.findById(prijateljstvoId).orElse(null);
	    if (p != null) {
	        p.setStatus("PRIHVACENO");
	        p.setDatumOdgovora(new Date());
	        pr.save(p);
	    }
	}
	
	public List<Prijateljstvo> getZahtevi(String status, Korisnik k) {
	    return pr.pronadjiPoStatusuIKorisniku(status, k.getKorisnikId());
	}

	public List<Prijateljstvo> getPrijatelji(Korisnik k) {
	    return pr.getPrihvacenaPrijateljstva("PRIHVACENO", k.getKorisnikId());
	}
	
	public void odbijZahtev(long prijateljstvoId) {
	    Prijateljstvo p = pr.findById(prijateljstvoId).orElse(null);
	    if (p != null) {
	        p.setStatus("ODBIJENO");
	        p.setDatumOdgovora(new Date());
	        pr.save(p);
	    }
	}

    public boolean daLiSuPrijatelji(Korisnik k1, Korisnik k2) {
        List<Prijateljstvo> lista = pr.proveriPrijateljstvo(k1.getKorisnikId(), k2.getKorisnikId());
        for (Prijateljstvo p : lista) {
            if ("PRIHVACENO".equals(p.getStatus())) return true;
        }
        return false;
    }
    
    
}