package com.example.demo.controllers;

import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.services.KategorijaStazeService;
import com.example.demo.services.OmiljenaStazaService;
import com.example.demo.services.StazaService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.KategorijaStaze;
import model.Korisnik;
import model.Staza;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Controller
@RequestMapping("/staze/")
public class StazaController {
	
	@Autowired
	StazaService ss;
	
	@Autowired
	KategorijaStazeService ks;
	
	@Autowired
	OmiljenaStazaService oss;
	
	@GetMapping("sveStaze")
	public String prikaziSveStaze(HttpServletRequest request) {
	    List<Staza> sveStaze = ss.getSveStaze();
	    List<KategorijaStaze> sveKategorije = ks.getSveKategorije();
	    
	    request.setAttribute("staze", sveStaze);
	    request.setAttribute("kategorije", sveKategorije);
	    
	    return "prikazStaza";
	}
	
	@GetMapping("pretraga")
	public String pretrazi(@RequestParam("idKat") Integer idKat, HttpServletRequest request) {
	    List<Staza> filtriraneStaze;
	    
	    if (idKat == null || idKat == 0) {
	        filtriraneStaze = ss.getSveStaze();
	    } else {
	        filtriraneStaze = ss.getPoKategoriji(idKat);
	    }
	    
	    request.setAttribute("staze", filtriraneStaze);
	    request.setAttribute("kategorije", ks.getSveKategorije()); 
	    
	    return "prikazStaza";
	}
    
    @GetMapping("detalji")
    public String getDetaljiStaze(@RequestParam("ids")Integer id, HttpServletRequest request) {
    	Staza s = ss.pronadjiStazuPoId(id);
    	request.getSession().setAttribute("izabranaStaza", s);
    	return "detaljiStaze";
    }
    
    @RequestMapping(value="/getDostupneStazeReport", method=RequestMethod.GET)
    public void dostupneStazeReport(HttpServletResponse response) throws Exception {
        List<Staza> staze = ss.getSveStazeSortirane(); 
        
        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(staze);
        
        InputStream inputStream = this.getClass().getResourceAsStream("/jasperreports/DostupneStaze.jrxml");
        JasperReport jasperReport = JasperCompileManager.compileReport(inputStream);
        
        Map<String, Object> params = new HashMap<String, Object>();
        
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, params, dataSource);
        
        response.setContentType("application/x-download");
        response.addHeader("Content-disposition", "attachment; filename=DostupneStaze.pdf");
        OutputStream out = response.getOutputStream();
        JasperExportManager.exportReportToPdfStream(jasperPrint, out);
    }
    
    @GetMapping("dodajUOmiljene")
    public String dodajUOmiljene(@RequestParam("ids") Integer ids, HttpServletRequest request) {
        Korisnik ulogovani = (Korisnik) request.getSession().getAttribute("ulogovaniKorisnik");
        
        Staza s = ss.pronadjiStazuPoId(ids); 
        
        oss.dodajOmiljene(ulogovani, s);
        
        return "redirect:/staze/sveStaze?added=true";
    }
    
    @GetMapping("izbaciIzOmiljenih")
    public String izbaciIzOmiljenih(@RequestParam("idOS") Integer idOS) {
        oss.izbaciIzOmiljenih(idOS);
        
        return "redirect:/nalog/omiljeneStaze";
    }
    
    @PostMapping("promeniStatus")
    public String promeniStatus(@RequestParam("stazaId") Integer stazaId) {
        ss.promeniStatusStaze(stazaId);
        
        return "redirect:/staze/detalji?ids=" + stazaId;
    }
}
