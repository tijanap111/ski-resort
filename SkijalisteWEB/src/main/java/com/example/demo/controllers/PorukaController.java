package com.example.demo.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.services.KorisnikService;
import com.example.demo.services.PorukaService;

import jakarta.servlet.http.HttpServletRequest;
import model.Korisnik;
import model.Poruka;

@Controller
@RequestMapping("/poruke")
public class PorukaController {

	@Autowired
	PorukaService ps;
	
	@Autowired
	KorisnikService ks;
	
	@GetMapping("sanduce")
	public String getMojePoruke(HttpServletRequest request) {
	    Korisnik ulogovani = (Korisnik) request.getSession().getAttribute("ulogovaniKorisnik");
	    
	    if (ulogovani == null) {
	        return "redirect:/nalog/getLogin";
	    }

	    List<Poruka> poruke = ps.getSveMojePoruke(ulogovani);
	    request.setAttribute("listaPoruka", poruke);
	    
	    request.setAttribute("ulogovaniKorisnik", ulogovani);
	    
	    return "sanduce";
	}
	
	@PostMapping("posaljiPoruku")
    public String posaljiPoruku(@RequestParam("idPrimaoca") Integer idPrimaoca, 
                               @RequestParam("tekst") String tekst, 
                               HttpServletRequest request) {
        
        Korisnik posiljalac = (Korisnik) request.getSession().getAttribute("ulogovaniKorisnik");
        Korisnik primalac = ks.pronadjiPoId(idPrimaoca);

        if (posiljalac != null && primalac != null && !tekst.isEmpty()) {
            ps.sacuvajPoruku(posiljalac, primalac, tekst);
            request.setAttribute("poruka", "Poruka je uspešno poslata!");
        }

        return "redirect:/prijateljstvo/prijatelji";
    }
	
	@GetMapping("inbox")
	public String prikaziInbox(HttpServletRequest request) {
	    Korisnik ulogovani = (Korisnik) request.getSession().getAttribute("ulogovaniKorisnik");
	    
	    if (ulogovani != null) {
	        List<Poruka> mojePoruke = ps.svePorukeZaKorisnika(ulogovani);
	        request.setAttribute("poruke", mojePoruke);
	    }
	    return "sanduce";
	}
}
