package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the korisnik database table.
 * 
 */
@Entity
@NamedQuery(name="Korisnik.findAll", query="SELECT k FROM Korisnik k")
public class Korisnik implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="korisnik_id")
	private long korisnikId;

	@Temporal(TemporalType.DATE)
	@Column(name="datum_registracije")
	private Date datumRegistracije;

	private String email;

	private String ime;

	private String lozinka;

	private String prezime;

	private String uloga;
	
	private String slika;

	//bi-directional many-to-one association to IznajmljivanjeOpreme
	@OneToMany(mappedBy="korisnik")
	private List<IznajmljivanjeOpreme> iznajmljivanjeOpremes;

	//bi-directional many-to-one association to OmiljenaStaza
	@OneToMany(mappedBy="korisnik")
	private List<OmiljenaStaza> omiljenaStazas;

	//bi-directional many-to-one association to Poruka
	@OneToMany(mappedBy="posiljalac")
	private List<Poruka> poslatePoruke;

	//bi-directional many-to-one association to Poruka
	@OneToMany(mappedBy="primalac")
	private List<Poruka> primljenePoruke;

	//bi-directional many-to-one association to Prijateljstvo
	@OneToMany(mappedBy="posiljalac")
	private List<Prijateljstvo> poslatiZahtevi;

	//bi-directional many-to-one association to Prijateljstvo
	@OneToMany(mappedBy="primalac")
	private List<Prijateljstvo> primljeniZahtevi;

	public Korisnik() {
	}

	public long getKorisnikId() {
		return this.korisnikId;
	}

	public void setKorisnikId(long korisnikId) {
		this.korisnikId = korisnikId;
	}

	public Date getDatumRegistracije() {
		return this.datumRegistracije;
	}

	public void setDatumRegistracije(Date datumRegistracije) {
		this.datumRegistracije = datumRegistracije;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getIme() {
		return this.ime;
	}

	public void setIme(String ime) {
		this.ime = ime;
	}

	public String getLozinka() {
		return this.lozinka;
	}

	public void setLozinka(String lozinka) {
		this.lozinka = lozinka;
	}

	public String getPrezime() {
		return this.prezime;
	}

	public void setPrezime(String prezime) {
		this.prezime = prezime;
	}

	public String getUloga() {
		return this.uloga;
	}

	public void setUloga(String uloga) {
		this.uloga = uloga;
	}

	public List<IznajmljivanjeOpreme> getIznajmljivanjeOpremes() {
		return this.iznajmljivanjeOpremes;
	}

	public void setIznajmljivanjeOpremes(List<IznajmljivanjeOpreme> iznajmljivanjeOpremes) {
		this.iznajmljivanjeOpremes = iznajmljivanjeOpremes;
	}

	public IznajmljivanjeOpreme addIznajmljivanjeOpreme(IznajmljivanjeOpreme iznajmljivanjeOpreme) {
		getIznajmljivanjeOpremes().add(iznajmljivanjeOpreme);
		iznajmljivanjeOpreme.setKorisnik(this);

		return iznajmljivanjeOpreme;
	}

	public IznajmljivanjeOpreme removeIznajmljivanjeOpreme(IznajmljivanjeOpreme iznajmljivanjeOpreme) {
		getIznajmljivanjeOpremes().remove(iznajmljivanjeOpreme);
		iznajmljivanjeOpreme.setKorisnik(null);

		return iznajmljivanjeOpreme;
	}

	public List<OmiljenaStaza> getOmiljenaStazas() {
		return this.omiljenaStazas;
	}

	public void setOmiljenaStazas(List<OmiljenaStaza> omiljenaStazas) {
		this.omiljenaStazas = omiljenaStazas;
	}

	public OmiljenaStaza addOmiljenaStaza(OmiljenaStaza omiljenaStaza) {
		getOmiljenaStazas().add(omiljenaStaza);
		omiljenaStaza.setKorisnik(this);

		return omiljenaStaza;
	}

	public OmiljenaStaza removeOmiljenaStaza(OmiljenaStaza omiljenaStaza) {
		getOmiljenaStazas().remove(omiljenaStaza);
		omiljenaStaza.setKorisnik(null);

		return omiljenaStaza;
	}

	public List<Poruka> getPoslatePoruke() {
		return this.poslatePoruke;
	}

	public void setPoslatePoruke(List<Poruka> poslatePoruke) {
		this.poslatePoruke = poslatePoruke;
	}

	public Poruka addPorukas1(Poruka porukas1) {
		getPoslatePoruke().add(porukas1);
		porukas1.setPosiljalac(this);

		return porukas1;
	}

	public Poruka removePorukas1(Poruka porukas1) {
		getPoslatePoruke().remove(porukas1);
		porukas1.setPrimalac(null);

		return porukas1;
	}

	public List<Poruka> getPrimljenePoruke() {
		return this.primljenePoruke;
	}

	public void setPrimljenePoruke(List<Poruka> primljenePoruke) {
		this.primljenePoruke = primljenePoruke;
	}

	public Poruka addPorukas2(Poruka porukas2) {
		getPrimljenePoruke().add(porukas2);
		porukas2.setPrimalac(this);

		return porukas2;
	}

	public Poruka removePorukas2(Poruka porukas2) {
		getPrimljenePoruke().remove(porukas2);
		porukas2.setPrimalac(null);

		return porukas2;
	}

	public List<Prijateljstvo> getPoslatiZahtevi() { 
		return this.poslatiZahtevi; 
	}
	
    public void setPoslatiZahtevi(List<Prijateljstvo> poslatiZahtevi) { 
    	this.poslatiZahtevi = poslatiZahtevi; 
    }

	public Prijateljstvo addPrijateljstvos1(Prijateljstvo prijateljstvos1) {
		getPoslatiZahtevi().add(prijateljstvos1);
		prijateljstvos1.setPosiljalac(this);

		return prijateljstvos1;
	}

	public Prijateljstvo removePrijateljstvos1(Prijateljstvo prijateljstvos1) {
		getPoslatiZahtevi().remove(prijateljstvos1);
		prijateljstvos1.setPosiljalac(null);

		return prijateljstvos1;
	}

	public List<Prijateljstvo> getPrimljeniZahtevi() { 
		return this.primljeniZahtevi; 
	}
	
    public void setPrimljeniZahtevi(List<Prijateljstvo> primljeniZahtevi) { 
    	this.primljeniZahtevi = primljeniZahtevi; 
    }

	public Prijateljstvo addPrijateljstvos2(Prijateljstvo prijateljstvos2) {
		getPrimljeniZahtevi().add(prijateljstvos2);
		prijateljstvos2.setPrimalac(this);

		return prijateljstvos2;
	}

	public Prijateljstvo removePrijateljstvos2(Prijateljstvo prijateljstvos2) {
		getPrimljeniZahtevi().remove(prijateljstvos2);
		prijateljstvos2.setPrimalac(null);

		return prijateljstvos2;
	}

	public String getSlika() {
		return slika;
	}

	public void setSlika(String slika) {
		this.slika = slika;
	}

}