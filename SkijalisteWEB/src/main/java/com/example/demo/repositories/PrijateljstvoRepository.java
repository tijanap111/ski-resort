package com.example.demo.repositories;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import model.Prijateljstvo;

public interface PrijateljstvoRepository extends JpaRepository<Prijateljstvo, Long>{
	
	@Query("select p from Prijateljstvo p where p.status = :status and p.primalac.korisnikId = :idK")
	List<Prijateljstvo> pronadjiPoStatusuIKorisniku(@Param("status") String status, @Param("idK") long idK);

	@Query("select p from Prijateljstvo p where p.status = :status and (p.posiljalac.korisnikId = :idK or p.primalac.korisnikId = :idK)")
	List<Prijateljstvo> getPrihvacenaPrijateljstva(@Param("status") String status, @Param("idK") long idK);

    @Query("select p from Prijateljstvo p where (p.posiljalac.korisnikId = :k1 and p.primalac.korisnikId = :k2) or (p.posiljalac.korisnikId = :k2 and p.primalac.korisnikId = :k1)")
    List<Prijateljstvo> proveriPrijateljstvo(@Param("k1") long k1, @Param("k2") long k2);
    
    @Query("select p from Prijateljstvo p where p.status = 'CEKANJE' and p.primalac.korisnikId = :mojId")
    List<Prijateljstvo> pronadjiMojeZahteve(@Param("mojId") long mojId);
    
    
}