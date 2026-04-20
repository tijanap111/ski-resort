package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.List;


/**
 * The persistent class for the kategorija_staze database table.
 * 
 */
@Entity
@Table(name="kategorija_staze")
@NamedQuery(name="KategorijaStaze.findAll", query="SELECT k FROM KategorijaStaze k")
public class KategorijaStaze implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="kategorija_id")
	private int kategorijaId;

	private String naziv;

	private String opis;

	//bi-directional many-to-one association to Staza
	@OneToMany(mappedBy="kategorijaStaze")
	private List<Staza> stazas;

	public KategorijaStaze() {
	}

	public int getKategorijaId() {
		return this.kategorijaId;
	}

	public void setKategorijaId(int kategorijaId) {
		this.kategorijaId = kategorijaId;
	}

	public String getNaziv() {
		return this.naziv;
	}

	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}

	public String getOpis() {
		return this.opis;
	}

	public void setOpis(String opis) {
		this.opis = opis;
	}

	public List<Staza> getStazas() {
		return this.stazas;
	}

	public void setStazas(List<Staza> stazas) {
		this.stazas = stazas;
	}

	public Staza addStaza(Staza staza) {
		getStazas().add(staza);
		staza.setKategorijaStaze(this);

		return staza;
	}

	public Staza removeStaza(Staza staza) {
		getStazas().remove(staza);
		staza.setKategorijaStaze(null);

		return staza;
	}

}