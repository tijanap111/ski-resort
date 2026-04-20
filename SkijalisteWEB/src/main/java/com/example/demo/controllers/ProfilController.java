package com.example.demo.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.services.KorisnikService;
import com.example.demo.services.PrijateljstvoService;

import jakarta.servlet.http.HttpServletRequest;
import model.Korisnik;

@Controller
@RequestMapping("/profilController/")
public class ProfilController {

    @Autowired
    KorisnikService ks;

    @Autowired
    PrijateljstvoService ps;

    @GetMapping("profil")
    public String prikaziProfil(HttpServletRequest r) {
        Korisnik korisnik = ks.pronadjiPoId(2);
        
        r.setAttribute("korisnik", korisnik);
        r.setAttribute("zahtevi", ps.getZahtevi("CEKA", korisnik));
        r.setAttribute("prijatelji", ps.getPrijatelji(korisnik));
        
        return "profil";
    }
}