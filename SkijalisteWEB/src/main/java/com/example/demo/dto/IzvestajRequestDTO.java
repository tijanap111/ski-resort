package com.example.demo.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.validation.constraints.NotNull;

public class IzvestajRequestDTO {

	@NotNull(message = "Datum 'od' je obavezan.")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date datumOd;

    @NotNull(message = "Datum 'do' je obavezan.")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date datumDo;

	public Date getDatumOd() {
		return datumOd;
	}

	public void setDatumOd(Date datumOd) {
		this.datumOd = datumOd;
	}

	public Date getDatumDo() {
		return datumDo;
	}

	public void setDatumDo(Date datumDo) {
		this.datumDo = datumDo;
	}
    
    
}
