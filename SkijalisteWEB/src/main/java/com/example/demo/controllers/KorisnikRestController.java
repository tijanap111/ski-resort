package com.example.demo.controllers;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.dto.IzvestajRequestDTO;
import com.example.demo.services.KorisnikService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/nalogRest/")
public class KorisnikRestController {

    @Autowired
    KorisnikService service;

    @PostMapping("generateReport")
    public ResponseEntity<?> getReport(@RequestBody @Valid IzvestajRequestDTO dto, BindingResult result) {
        if (result.hasErrors()) {
            List<String> errors = result.getAllErrors().stream()
                    .map(ObjectError::getDefaultMessage)
                    .collect(Collectors.toList());
            return ResponseEntity.badRequest().body(errors); 
        }

        try {
            byte[] izvestajBytes = service.getReportBytes(dto.getDatumOd(), dto.getDatumDo());
            
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.setContentDispositionFormData("attachment", "NoviKorisnici.pdf");
            
            return ResponseEntity.ok().headers(headers).body(izvestajBytes);
            
        } catch (Exception e) {
            throw new RuntimeException("Greška prilikom generisanja izveštaja: " + e.getMessage());
        }
    }

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<String> handleException(RuntimeException e) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
    }
}