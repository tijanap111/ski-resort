package com.example.demo.security;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.demo.repositories.KorisnikRepository;

import model.Korisnik;

@Service
public class MyDetailUserService implements UserDetailsService{


	@Autowired
	KorisnikRepository kr;
	
	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		Korisnik k = kr.findByEmail(email);
	    if (k == null) {
	        throw new UsernameNotFoundException("Korisnik sa korisničkim imenom " + email + " nije pronađen.");
	    }
	    System.out.println("Nasli smo korisnika za korisnicko ime u MyDetailUserService klasi..");
		UserDetails ud = new CustomUserDetail(k);
		return ud;
	}

}