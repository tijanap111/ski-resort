package com.example.demo.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;

@EnableWebSecurity
@Configuration
public class SecurityConfig{
	
	@Autowired
	AuthorizeFilter autorizeFilter;
	
	@Bean
	SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
	    http.csrf(csrf -> csrf.disable())
	        .securityContext(context -> context.requireExplicitSave(false)) 
	        .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.ALWAYS))
	        .authorizeHttpRequests(requests -> requests
	        	    .dispatcherTypeMatchers(jakarta.servlet.DispatcherType.FORWARD).permitAll() 
	        	    
	        	    .requestMatchers("/staze/sveStaze", "/staze/pretraga", "/staze/detalji").permitAll()
	        	    .requestMatchers("/nalog/getLogin", "/nalog/getRegister", "/nalog/loginForm", "/nalog/register").permitAll()
	        	    .requestMatchers("/", "/login.jsp", "/registracija.jsp", "/prikazStaza.jsp").permitAll()
	        	    .requestMatchers("/css/**", "/images/**", "/static/**").permitAll()
	        	    .requestMatchers("/staze/dodajUOmiljene", "/staze/izbaciIzOmiljenih").hasAnyRole("ADMIN", "USER")
	        	    
	        	    .anyRequest().authenticated())
	            .formLogin(login -> login
	                .loginPage("/nalog/getLogin")
	                .permitAll()
	            )
	            .logout(logout -> logout
	                .logoutRequestMatcher(new AntPathRequestMatcher("/nalog/logout"))
	                .logoutSuccessUrl("/nalog/getLogin")
	                .deleteCookies("JSESSIONID")
	                .invalidateHttpSession(true)
	                .permitAll()
	            )
	            .addFilterBefore(autorizeFilter, UsernamePasswordAuthenticationFilter.class);

	        return http.build();
	}
	
	
	 @Bean
	 AuthenticationManager authenticationManager(UserDetailsService userDetailsService,PasswordEncoder passwordEncoder) {
		DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
		authenticationProvider.setUserDetailsService(userDetailsService);
		authenticationProvider.setPasswordEncoder(passwordEncoder);

		return new ProviderManager(authenticationProvider);
	  }
	
	@Bean
	 PasswordEncoder getPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	
	private SecurityScheme createAPIKeyScheme() {
	    return new SecurityScheme().type(SecurityScheme.Type.HTTP)
	        .bearerFormat("JWT")
	        .scheme("bearer");
	}
	
	@Bean
	public OpenAPI openAPI() {
	    return new OpenAPI()
	    		.addSecurityItem(new SecurityRequirement()
	    		.addList("Bearer Authentication"))
	            .components(new Components().addSecuritySchemes
	            ("Bearer Authentication", createAPIKeyScheme()));
	     
	}

}
