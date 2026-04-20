package com.example.demo.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.example.demo.services.KorisnikService;
import com.example.demo.services.PrijateljstvoService;
import jakarta.servlet.http.HttpServletRequest;
import model.Korisnik;

@Controller
@RequestMapping("/prijateljstvo/")
public class PrijateljstvoController {
	
	@Autowired
	PrijateljstvoService ps;
	@Autowired
	KorisnikService ks;
	
	@GetMapping("prijatelji")
	public String prikaziPrijatelje(HttpServletRequest request) {
	    org.springframework.security.core.Authentication auth = 
	        org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication();
	    
	    if (auth != null && auth.isAuthenticated()) {
	        String email = auth.getName();
	        Korisnik k = ks.pronadjiPoEmailu(email);
	        request.getSession().setAttribute("ulogovaniKorisnik", k);
	        
	        request.setAttribute("zahtevi", ps.getZahtevi("CEKANJE", k));
	        request.setAttribute("prijatelji", ps.getPrijatelji(k));
	        request.setAttribute("ulogovaniKorisnik", k);
	    }
	    
	    return "prijatelji";
	}

	@GetMapping("posaljiZahtev")
	public String posaljiZahtev(@RequestParam("idPrimaoca") Integer idPrimaoca, HttpServletRequest request) {
		Korisnik posiljalac = (Korisnik)request.getSession().getAttribute("ulogovaniKorisnik");
		Korisnik primalac = ks.pronadjiPoId(idPrimaoca);
		
		if (posiljalac != null && primalac != null) {
			ps.posaljiZahtev(posiljalac, primalac);
		}
		return "redirect:/prijateljstvo/prijatelji?sent=true";
	}
	
	@GetMapping("prihvati")
	public String prihvatiZahtev(@RequestParam("idP") Long id) {
		ps.prihvatiZahtev(id);
		return "redirect:/prijateljstvo/prijatelji";
	}

	@GetMapping("odbij")
	public String odbijZahtev(@RequestParam("idP") Long id) {
		ps.odbijZahtev(id);
		return "redirect:/prijateljstvo/prijatelji";
	}
}