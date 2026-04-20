package com.example.demo.repositories;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import model.Korisnik;

public interface KorisnikRepository extends JpaRepository<Korisnik, Long> {
	
	public Korisnik findByEmail(String email);
	
	@Query("select k from Korisnik k where k.korisnikId = :id")
	public Korisnik pronadjiPoId(@Param("id")Integer id);
	
	@Query("select k from Korisnik k where k.ime like %:ime% or k.prezime like %:prezime%")
	public List<Korisnik> findByImeAndPrezime(@Param("ime") String ime, @Param("prezime") String prezime);

	@Query("select k from Korisnik k where k.datumRegistracije between :datumOd and :datumDo order by k.datumRegistracije asc")
	public List<Korisnik> getKorisniciUPeriodu(Date datumOd, Date datumDo);
	
	List<Korisnik> findAllByOrderByPrezimeAsc();
	
	@Query("SELECT k FROM Korisnik k WHERE k.korisnikId != :mojId " +
		       "AND k.korisnikId NOT IN " +
		       "(SELECT p.primalac.korisnikId FROM Prijateljstvo p WHERE p.posiljalac.korisnikId = :mojId) " +
		       "AND k.korisnikId NOT IN " +
		       "(SELECT p.posiljalac.korisnikId FROM Prijateljstvo p WHERE p.primalac.korisnikId = :mojId)")
		List<Korisnik> findPotencijalniPrijatelji(@Param("mojId") long mojId);
}
