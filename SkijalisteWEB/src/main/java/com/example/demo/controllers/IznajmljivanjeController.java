package com.example.demo.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.services.IznajmljivanjeService;
import com.example.demo.services.SkiOpremaService;

import jakarta.servlet.http.HttpServletRequest;
import model.Korisnik;
import model.SkiOprema;

@Controller
@RequestMapping("/iznajmljivanje/")
public class IznajmljivanjeController {
    
    @Autowired
    IznajmljivanjeService is;
    
    @Autowired
    SkiOpremaService sos;
    
    @GetMapping("prikazOpreme")
    public String prikaziOpremuAdmin(HttpServletRequest request) {
        request.setAttribute("svaOprema", is.getSvaOprema());
        request.setAttribute("svaIznajmljivanja", is.getAllIznajmljivanja());
        
        return "admin";
    }

    @GetMapping("getForma")
    public String prikaziFormuZaIznajmljivanje(HttpServletRequest request) {
        request.setAttribute("svaOprema", is.getSvaOprema());
        return "formaIznajmljivanje";
    }

    @PostMapping("potvrdiIznajmljivanje")
    public String potvrdiIznajmljivanje(@RequestParam("idOpreme") Integer idOpreme, 
                                        @RequestParam("brojSati") int brojSati, 
                                        HttpServletRequest request) {
        
        Korisnik ulogovani = (Korisnik) request.getSession().getAttribute("ulogovaniKorisnik");
        if (ulogovani == null) return "redirect:/nalog/getLogin";

        SkiOprema o = is.pronadjiOpremu(idOpreme); 
        
        if (o != null) {
            if (o.getDostupnaKolicina() <= 0) { 
                request.setAttribute("greska", "Nema na stanju!");
                request.setAttribute("svaOprema", is.getSvaOprema());
                return "formaIznajmljivanje";
            }

            is.iznajmiOpremu(ulogovani, o, brojSati);
            return "redirect:/nalog/korisnikProfil?success=true";
        }
        return "redirect:/iznajmljivanje/getForma?error=true";
    }
}