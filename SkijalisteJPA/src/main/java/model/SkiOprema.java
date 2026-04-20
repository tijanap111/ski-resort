package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.List;


/**
 * The persistent class for the ski_oprema database table.
 * 
 */
@Entity
@Table(name="ski_oprema")
@NamedQuery(name="SkiOprema.findAll", query="SELECT s FROM SkiOprema s")
public class SkiOprema implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="oprema_id")
	private int opremaId;

	@Column(name="cena_po_danu")
	private double cenaPoDanu;

	@Column(name="dostupna_kolicina")
	private int dostupnaKolicina;

	private String naziv;

	private String tip;

	@Column(name="ukupna_kolicina")
	private int ukupnaKolicina;

	//bi-directional many-to-one association to IznajmljivanjeOpreme
	@OneToMany(mappedBy="skiOprema")
	private List<IznajmljivanjeOpreme> iznajmljivanjeOpremes;

	public SkiOprema() {
	}

	public int getOpremaId() {
		return this.opremaId;
	}

	public void setOpremaId(int opremaId) {
		this.opremaId = opremaId;
	}

	public double getCenaPoDanu() {
		return this.cenaPoDanu;
	}

	public void setCenaPoDanu(double cenaPoDanu) {
		this.cenaPoDanu = cenaPoDanu;
	}

	public int getDostupnaKolicina() {
		return this.dostupnaKolicina;
	}

	public void setDostupnaKolicina(int dostupnaKolicina) {
		this.dostupnaKolicina = dostupnaKolicina;
	}

	public String getNaziv() {
		return this.naziv;
	}

	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}

	public String getTip() {
		return this.tip;
	}

	public void setTip(String tip) {
		this.tip = tip;
	}

	public int getUkupnaKolicina() {
		return this.ukupnaKolicina;
	}

	public void setUkupnaKolicina(int ukupnaKolicina) {
		this.ukupnaKolicina = ukupnaKolicina;
	}

	public List<IznajmljivanjeOpreme> getIznajmljivanjeOpremes() {
		return this.iznajmljivanjeOpremes;
	}

	public void setIznajmljivanjeOpremes(List<IznajmljivanjeOpreme> iznajmljivanjeOpremes) {
		this.iznajmljivanjeOpremes = iznajmljivanjeOpremes;
	}

	public IznajmljivanjeOpreme addIznajmljivanjeOpreme(IznajmljivanjeOpreme iznajmljivanjeOpreme) {
		getIznajmljivanjeOpremes().add(iznajmljivanjeOpreme);
		iznajmljivanjeOpreme.setSkiOprema(this);

		return iznajmljivanjeOpreme;
	}

	public IznajmljivanjeOpreme removeIznajmljivanjeOpreme(IznajmljivanjeOpreme iznajmljivanjeOpreme) {
		getIznajmljivanjeOpremes().remove(iznajmljivanjeOpreme);
		iznajmljivanjeOpreme.setSkiOprema(null);

		return iznajmljivanjeOpreme;
	}

}