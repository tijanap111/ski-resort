package com.example.demo.controllers;

import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.AuthenticationRequest;
import com.example.demo.dto.AuthenticationResponse;
import com.example.demo.security.JWTUtil;
import com.example.demo.services.IznajmljivanjeService;
import com.example.demo.services.KorisnikService;
import com.example.demo.services.OmiljenaStazaService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Korisnik;
import model.OmiljenaStaza;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Controller
@RequestMapping("/nalog/")
public class KorisnikController {

	@Autowired
	KorisnikService service;
	
	@Autowired
	OmiljenaStazaService oss;
	
	@Autowired
	IznajmljivanjeService is;
	
	@Autowired
    AuthenticationManager authenticationManager;
	
	@Autowired
    JWTUtil jwtUtil;
	
	@Autowired
    PasswordEncoder passwordEncoder;
	
	@GetMapping("getLogin")
	public String prikaziLogin() {
		return "login";
	}
	
	@GetMapping("getRegister")
	public String prikaziRegistraciju() {
		return "registracija";
	}
	
	@PostMapping("loginForm")
	public String loginForm(@RequestParam("email") String email, 
	                        @RequestParam("lozinka") String lozinka, 
	                        HttpServletRequest request) {
	    try {
	        Authentication authentication = authenticationManager.authenticate(
	                new UsernamePasswordAuthenticationToken(email, lozinka)
	        );

	        SecurityContextHolder.getContext().setAuthentication(authentication);
	        
	        request.getSession().setAttribute("SPRING_SECURITY_CONTEXT", SecurityContextHolder.getContext());
	        
	        Korisnik k = service.findByEmail(email);
	        request.getSession().setAttribute("ulogovaniKorisnik", k);
	        
	        if (k.getUloga().equals("ADMIN")) {
	            return "redirect:/nalog/admin";
	        } else {
	            return "redirect:/nalog/korisnikProfil";
	        }

	    } catch (Exception e) {
	        return "redirect:/nalog/getLogin?error=true";
	    }
	}
	
	@PostMapping("login")
	@ResponseBody
	public ResponseEntity<AuthenticationResponse> login(@RequestBody AuthenticationRequest authRequest) {
	    Authentication authentication = authenticationManager.authenticate(
	            new UsernamePasswordAuthenticationToken(authRequest.getUsername(), authRequest.getPassword())
	    );

	    UserDetails userDetails = (UserDetails) authentication.getPrincipal();
	    String token = jwtUtil.generateToken(userDetails);
	    AuthenticationResponse res = new AuthenticationResponse();
	    res.setJwt(token);
	    
	    return ResponseEntity.ok(res);
	}
	
	@GetMapping("admin")
	public String prikaziAdminProfil(HttpServletRequest request) {
	    request.setAttribute("svaOprema", is.getSvaOprema());
	    request.setAttribute("svaIznajmljivanja", is.getAllIznajmljivanja());
	    
	    return "admin";
	}
	
	@GetMapping("korisnikProfil")
	public String prikaziKorisnikProfil() {
	    return "profil";
	}
	
	@GetMapping("logout")
	public String logout(HttpServletRequest request) {
	    request.getSession().invalidate();
	    SecurityContextHolder.clearContext();
	    
	    return "redirect:/nalog/getLogin";
	}
	
	@PostMapping("register")
	public String register(@RequestParam("ime") String ime, 
	                       @RequestParam("prezime") String prezime,
	                       @RequestParam("email") String email,
	                       @RequestParam("lozinka") String lozinka) {
	    
	    if (service.findByEmail(email) != null) {
	        return "redirect:/nalog/getLogin?exists=true";
	    }

	    Korisnik novi = new Korisnik();
	    novi.setIme(ime);
	    novi.setPrezime(prezime);
	    novi.setEmail(email);
	    novi.setLozinka(passwordEncoder.encode(lozinka));
	    novi.setUloga("USER");
	    novi.setDatumRegistracije(new Date());
	    novi.setSlika("images/users/default.jpg");
	    
	    service.registerKorisnik(novi);
	    return "redirect:/nalog/getLogin?success=true"; 
	}
	
	@GetMapping("omiljeneStaze")
	public String omiljeneStaze(HttpServletRequest request) {
	    Korisnik ulogovani = (Korisnik) request.getSession().getAttribute("ulogovaniKorisnik");
	    List<OmiljenaStaza> lista = oss.getOmiljeneStazeZaKorisnika(ulogovani);
	    
	    request.setAttribute("omiljene", lista);
	    return "omiljene";
	}
	
	@GetMapping("prijatelji")
	public String listaPrijatelja() {
	    return "prijatelji";
	}
	
	@GetMapping("sviKorisnici")
	public String prikaziSve(HttpServletRequest request) {
	    Korisnik ulogovani = (Korisnik) request.getSession().getAttribute("ulogovaniKorisnik");
	    
	    if (ulogovani != null) {
	        List<Korisnik> skijasi = service.getSviOsimPrijatelja(ulogovani);
	        request.setAttribute("sviKorisnici", skijasi);
	    }
	    return "sviKorisnici";
	}
	
	
	@GetMapping("posaljiZahtev")
	public String posaljiZahtev(@RequestParam("idP") Integer idP, HttpServletRequest request) {
	    Korisnik posiljalac = (Korisnik) request.getSession().getAttribute("ulogovaniKorisnik");
	    Korisnik primalac = service.pronadjiPoId(idP); 
	    
	    service.posaljiZahtev(posiljalac, primalac);
	    
	    return "redirect:/nalog/sviKorisnici?sent=true";
	}
	
	@RequestMapping(value="getNoviKorisniciReport", method=RequestMethod.GET)
	public void showReport(@RequestParam("datumOd") @DateTimeFormat(pattern="yyyy-MM-dd") Date datumOd, 
            @RequestParam("datumDo") @DateTimeFormat(pattern="yyyy-MM-dd") Date datumDo, HttpServletResponse response) throws Exception {
		
		JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(service.getKorisniciUPeriodu(datumOd, datumDo));
		InputStream inputStream = this.getClass().getResourceAsStream("/jasperreports/NoviKorisnici.jrxml");
		JasperReport jasperReport = JasperCompileManager.compileReport(inputStream);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("datumRegistracije", datumOd);
		JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, params, dataSource);
		inputStream.close();
		
		response.setContentType("application/pdf");
		response.addHeader("Content-disposition", "attachment; filename=NoviKorisnici.pdf");
		OutputStream out = response.getOutputStream();
		JasperExportManager.exportReportToPdfStream(jasperPrint, out);
		out.flush();
	    out.close();
	}
}
