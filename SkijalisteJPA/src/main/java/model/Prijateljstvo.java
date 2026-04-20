package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;


/**
 * The persistent class for the prijateljstvo database table.
 * 
 */
@Entity
@NamedQuery(name="Prijateljstvo.findAll", query="SELECT p FROM Prijateljstvo p")
public class Prijateljstvo implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="prijateljstvo_id")
	private long prijateljstvoId;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="datum_odgovora")
	private Date datumOdgovora;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="datum_zahteva")
	private Date datumZahteva;

	private String status;

	//bi-directional many-to-one association to Korisnik
	@ManyToOne
	@JoinColumn(name="posiljalac_id")
	private Korisnik posiljalac;

	//bi-directional many-to-one association to Korisnik
	@ManyToOne
	@JoinColumn(name="primalac_id")
	private Korisnik primalac;

	public Prijateljstvo() {
	}

	public long getPrijateljstvoId() {
		return this.prijateljstvoId;
	}

	public void setPrijateljstvoId(long prijateljstvoId) {
		this.prijateljstvoId = prijateljstvoId;
	}

	public Date getDatumOdgovora() {
		return this.datumOdgovora;
	}

	public void setDatumOdgovora(Date datumOdgovora) {
		this.datumOdgovora = datumOdgovora;
	}

	public Date getDatumZahteva() {
		return this.datumZahteva;
	}

	public void setDatumZahteva(Date datumZahteva) {
		this.datumZahteva = datumZahteva;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Korisnik getPosiljalac() {
		return this.posiljalac;
	}

	public void setPosiljalac(Korisnik posiljalac) {
		this.posiljalac = posiljalac;
	}

	public Korisnik getPrimalac() {
		return this.primalac;
	}

	public void setPrimalac(Korisnik primalac) {
		this.primalac = primalac;
	}

}