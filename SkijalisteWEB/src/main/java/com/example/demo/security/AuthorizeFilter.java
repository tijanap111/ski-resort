package com.example.demo.security;

import java.io.IOException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Korisnik;

@Component
public class AuthorizeFilter extends OncePerRequestFilter {

    @Autowired
    MyDetailUserService userservice;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if (path.contains("/getLogin") || path.contains("/getRegister") || 
            path.contains("/sveStaze") || path.contains("/pretraga") || 
            path.contains("/detalji") || path.contains("/images/") || 
            path.contains("/css/") || path.endsWith(".jsp") || path.equals("/")) {
            
            filterChain.doFilter(request, response);
            return;
        }

        Korisnik k = (Korisnik) request.getSession().getAttribute("ulogovaniKorisnik");
        if (k != null && SecurityContextHolder.getContext().getAuthentication() == null) {
            UserDetails userDetails = userservice.loadUserByUsername(k.getEmail());
            UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(
                    userDetails, null, userDetails.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(auth);
        }

        filterChain.doFilter(request, response);
    }
}