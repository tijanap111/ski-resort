package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;


/**
 * The persistent class for the omiljena_staza database table.
 * 
 */
@Entity
@Table(name="omiljena_staza")
@NamedQuery(name="OmiljenaStaza.findAll", query="SELECT o FROM OmiljenaStaza o")
public class OmiljenaStaza implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="omiljena_id")
	private int omiljenaId;

	@Temporal(TemporalType.DATE)
	@Column(name="datum_dodavanja")
	private Date datumDodavanja;

	//bi-directional many-to-one association to Korisnik
	@ManyToOne
	@JoinColumn(name="korisnik_id")
	private Korisnik korisnik;

	//bi-directional many-to-one association to Staza
	@ManyToOne
	@JoinColumn(name="staza_id")
	private Staza staza;

	public OmiljenaStaza() {
	}

	public int getOmiljenaId() {
		return this.omiljenaId;
	}

	public void setOmiljenaId(int omiljenaId) {
		this.omiljenaId = omiljenaId;
	}

	public Date getDatumDodavanja() {
		return this.datumDodavanja;
	}

	public void setDatumDodavanja(Date datumDodavanja) {
		this.datumDodavanja = datumDodavanja;
	}

	public Korisnik getKorisnik() {
		return this.korisnik;
	}

	public void setKorisnik(Korisnik korisnik) {
		this.korisnik = korisnik;
	}

	public Staza getStaza() {
		return this.staza;
	}

	public void setStaza(Staza staza) {
		this.staza = staza;
	}

}