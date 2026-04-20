package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;


/**
 * The persistent class for the iznajmljivanje_opreme database table.
 * 
 */
@Entity
@Table(name="iznajmljivanje_opreme")
@NamedQuery(name="IznajmljivanjeOpreme.findAll", query="SELECT i FROM IznajmljivanjeOpreme i")
public class IznajmljivanjeOpreme implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="iznajmljivanje_id")
	private int iznajmljivanjeId;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="datum_do")
	private Date datumDo;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="datum_od")
	private Date datumOd;

	public int getBrojDana() {
		return brojDana;
	}

	public void setBrojDana(int brojDana) {
		this.brojDana = brojDana;
	}

	private String status;
	
	@Column(name="broj_dana")
	private int brojDana;

	@Column(name="ukupna_cena")
	private double ukupnaCena;

	//bi-directional many-to-one association to Korisnik
	@ManyToOne
	@JoinColumn(name="korisnik_id")
	private Korisnik korisnik;

	//bi-directional many-to-one association to SkiOprema
	@ManyToOne
	@JoinColumn(name="oprema_id")
	private SkiOprema skiOprema;

	public IznajmljivanjeOpreme() {
	}

	public int getIznajmljivanjeId() {
		return this.iznajmljivanjeId;
	}

	public void setIznajmljivanjeId(int iznajmljivanjeId) {
		this.iznajmljivanjeId = iznajmljivanjeId;
	}

	public Date getDatumDo() {
		return this.datumDo;
	}

	public void setDatumDo(Date datumDo) {
		this.datumDo = datumDo;
	}

	public Date getDatumOd() {
		return this.datumOd;
	}

	public void setDatumOd(Date datumOd) {
		this.datumOd = datumOd;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public double getUkupnaCena() {
		return this.ukupnaCena;
	}

	public void setUkupnaCena(double ukupnaCena) {
		this.ukupnaCena = ukupnaCena;
	}

	public Korisnik getKorisnik() {
		return this.korisnik;
	}

	public void setKorisnik(Korisnik korisnik) {
		this.korisnik = korisnik;
	}

	public SkiOprema getSkiOprema() {
		return this.skiOprema;
	}

	public void setSkiOprema(SkiOprema skiOprema) {
		this.skiOprema = skiOprema;
	}

}