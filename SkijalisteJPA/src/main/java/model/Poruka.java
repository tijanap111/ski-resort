package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;


/**
 * The persistent class for the poruka database table.
 * 
 */
@Entity
@NamedQuery(name="Poruka.findAll", query="SELECT p FROM Poruka p")
public class Poruka implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="poruka_id")
	private long porukaId;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="datum_slanja")
	private Date datumSlanja;

	private int procitana;

	@Lob
	private String sadrzaj;

	//bi-directional many-to-one association to Korisnik
	@ManyToOne
	@JoinColumn(name="posiljalac_id")
	private Korisnik posiljalac;

	//bi-directional many-to-one association to Korisnik
	@ManyToOne
	@JoinColumn(name="primalac_id")
	private Korisnik primalac;

	public Poruka() {
	}

	public long getPorukaId() {
		return this.porukaId;
	}

	public void setPorukaId(long porukaId) {
		this.porukaId = porukaId;
	}

	public Date getDatumSlanja() {
		return this.datumSlanja;
	}

	public void setDatumSlanja(Date datumSlanja) {
		this.datumSlanja = datumSlanja;
	}

	public int getProcitana() {
		return this.procitana;
	}

	public void setProcitana(int procitana) {
		this.procitana = procitana;
	}

	public String getSadrzaj() {
		return this.sadrzaj;
	}

	public void setSadrzaj(String sadrzaj) {
		this.sadrzaj = sadrzaj;
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