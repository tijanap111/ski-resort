package com.example.demo.services;

import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repositories.KorisnikRepository;
import com.example.demo.repositories.PrijateljstvoRepository;

import model.Korisnik;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Service
public class KorisnikService {

	@Autowired
	KorisnikRepository kr;
	
	@Autowired
	PrijateljstvoRepository pr;
	
	public Korisnik registerKorisnik(Korisnik k) {
		return kr.save(k);
	}
	
	public List<Korisnik> getAll() {
		return kr.findAll();
	}
	
	public Korisnik findByEmail(String email) {
		return kr.findByEmail(email);
	}
	
	public Korisnik pronadjiPoEmailu(String email) {
	    return kr.findByEmail(email); 
	}
	
	public Korisnik pronadjiPoId(Integer id) {
		return kr.pronadjiPoId(id);
	}
	
	public List<Korisnik> pronadjipoImenuIPrez(String ime, String prezime) {
		return kr.findByImeAndPrezime(ime, prezime);
	}
	
	public List<Korisnik> getKorisniciUPeriodu(Date datumOd, Date datumDo) {
	    return kr.getKorisniciUPeriodu(datumOd, datumDo);
	}
	
	public byte[] getReportBytes(Date datumOd, Date datumDo) throws Exception {
        List<Korisnik> korisnici = kr.getKorisniciUPeriodu(datumOd, datumDo);
        
        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(korisnici);
        
        InputStream inputStream = this.getClass().getResourceAsStream("/jasperreports/NoviKorisnici.jrxml");
        JasperReport jasperReport = JasperCompileManager.compileReport(inputStream);
        
        Map<String, Object> params = new HashMap<>();
        params.put("datumOd", datumOd);
        params.put("datumDo", datumDo);
        
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, params, dataSource);
        
        inputStream.close();
        return JasperExportManager.exportReportToPdf(jasperPrint);
    }
	
	public void posaljiZahtev(Korisnik posiljalac, Korisnik primalac) {
	    model.Prijateljstvo p = new model.Prijateljstvo();
	    p.setPosiljalac(posiljalac);
	    p.setPrimalac(primalac);
	    p.setStatus("CEKANJE");
	    p.setDatumZahteva(new Date());
	    
	    pr.save(p);
	}

	public List<Korisnik> getSviOsimPrijatelja(Korisnik ulogovani) {
	    return kr.findPotencijalniPrijatelji(ulogovani.getKorisnikId());
	}
}
