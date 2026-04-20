package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.List;


/**
 * The persistent class for the staza database table.
 * 
 */
@Entity
@NamedQuery(name="Staza.findAll", query="SELECT s FROM Staza s")
public class Staza implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="staza_id")
	private int stazaId;

	private double duzina;

	@Column(name="nadmorska_visina_dno")
	private int nadmorskaVisinaDno;

	@Column(name="nadmorska_visina_vrh")
	private int nadmorskaVisinaVrh;

	private String naziv;

	private String slika;

	private String status;

	private String tezina;

	//bi-directional many-to-one association to OmiljenaStaza
	@OneToMany(mappedBy="staza")
	private List<OmiljenaStaza> omiljenaStazas;

	//bi-directional many-to-one association to KategorijaStaze
	@ManyToOne
	@JoinColumn(name="kategorija_id")
	private KategorijaStaze kategorijaStaze;

	public Staza() {
	}

	public int getStazaId() {
		return this.stazaId;
	}

	public void setStazaId(int stazaId) {
		this.stazaId = stazaId;
	}

	public double getDuzina() {
		return this.duzina;
	}

	public void setDuzina(double duzina) {
		this.duzina = duzina;
	}

	public int getNadmorskaVisinaDno() {
		return this.nadmorskaVisinaDno;
	}

	public void setNadmorskaVisinaDno(int nadmorskaVisinaDno) {
		this.nadmorskaVisinaDno = nadmorskaVisinaDno;
	}

	public int getNadmorskaVisinaVrh() {
		return this.nadmorskaVisinaVrh;
	}

	public void setNadmorskaVisinaVrh(int nadmorskaVisinaVrh) {
		this.nadmorskaVisinaVrh = nadmorskaVisinaVrh;
	}

	public String getNaziv() {
		return this.naziv;
	}

	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}

	public String getSlika() {
		return this.slika;
	}

	public void setSlika(String slika) {
		this.slika = slika;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTezina() {
		return this.tezina;
	}

	public void setTezina(String tezina) {
		this.tezina = tezina;
	}

	public List<OmiljenaStaza> getOmiljenaStazas() {
		return this.omiljenaStazas;
	}

	public void setOmiljenaStazas(List<OmiljenaStaza> omiljenaStazas) {
		this.omiljenaStazas = omiljenaStazas;
	}

	public OmiljenaStaza addOmiljenaStaza(OmiljenaStaza omiljenaStaza) {
		getOmiljenaStazas().add(omiljenaStaza);
		omiljenaStaza.setStaza(this);

		return omiljenaStaza;
	}

	public OmiljenaStaza removeOmiljenaStaza(OmiljenaStaza omiljenaStaza) {
		getOmiljenaStazas().remove(omiljenaStaza);
		omiljenaStaza.setStaza(null);

		return omiljenaStaza;
	}

	public KategorijaStaze getKategorijaStaze() {
		return this.kategorijaStaze;
	}

	public void setKategorijaStaze(KategorijaStaze kategorijaStaze) {
		this.kategorijaStaze = kategorijaStaze;
	}

}