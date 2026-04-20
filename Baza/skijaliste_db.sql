-- MySQL Workbench Forward Engineering
USE skijaliste_db;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
-- -----------------------------------------------------
-- Schema skijaliste_db
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`korisnik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`korisnik` (
  `korisnik_id` BIGINT NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `lozinka` VARCHAR(45) NOT NULL,
  `uloga` VARCHAR(45) NOT NULL,
  `datum_registracije` DATE NOT NULL,
  PRIMARY KEY (`korisnik_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`ski_oprema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ski_oprema` (
  `oprema_id` INT NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  `tip` VARCHAR(45) NOT NULL,
  `cena_po_satu` DOUBLE NOT NULL,
  `ukupna_kolicina` INT NOT NULL,
  `dostupna_kolicina` INT NOT NULL,
  PRIMARY KEY (`oprema_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`iznajmljivanje_opreme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`iznajmljivanje_opreme` (
  `iznajmljivanje_id` INT NOT NULL AUTO_INCREMENT,
  `datum_od` DATETIME NOT NULL,
  `datum_do` DATETIME NOT NULL,
  `broj_sati` INT NOT NULL DEFAULT 1,
  `ukupna_cena` DOUBLE NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `oprema_id` INT NOT NULL,
  `korisnik_id` BIGINT NOT NULL,
  PRIMARY KEY (`iznajmljivanje_id`),
  INDEX `fk_Iznajmljivanje_opreme_Ski_oprema1_idx` (`oprema_id` ASC) VISIBLE,
  INDEX `fk_Iznajmljivanje_opreme_Korisnik1_idx` (`korisnik_id` ASC) VISIBLE,
  CONSTRAINT `fk_Iznajmljivanje_opreme_Korisnik1`
    FOREIGN KEY (`korisnik_id`)
    REFERENCES `mydb`.`korisnik` (`korisnik_id`),
  CONSTRAINT `fk_Iznajmljivanje_opreme_Ski_oprema1`
    FOREIGN KEY (`oprema_id`)
    REFERENCES `mydb`.`ski_oprema` (`oprema_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`kategorija_staze`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`kategorija_staze` (
  `kategorija_id` INT NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  `opis` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`kategorija_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`staza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`staza` (
  `staza_id` INT NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  `tezina` VARCHAR(45) NOT NULL,
  `duzina` DOUBLE NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `slika` VARCHAR(255) NULL DEFAULT NULL,
  `nadmorska_visina_vrh` INT NULL DEFAULT NULL,
  `nadmorska_visina_dno` INT NULL DEFAULT NULL,
  `kategorija_id` INT NOT NULL,
  PRIMARY KEY (`staza_id`),
  INDEX `fk_Staza_Kategorija_staze_idx` (`kategorija_id` ASC) VISIBLE,
  CONSTRAINT `fk_Staza_Kategorija_staze`
    FOREIGN KEY (`kategorija_id`)
    REFERENCES `mydb`.`kategorija_staze` (`kategorija_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`omiljena_staza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`omiljena_staza` (
  `omiljena_id` INT NOT NULL,
  `datum_dodavanja` DATE NOT NULL,
  `staza_id` INT NOT NULL,
  `korisnik_id` BIGINT NOT NULL,
  PRIMARY KEY (`omiljena_id`),
  INDEX `fk_Omiljena_staza_Staza1_idx` (`staza_id` ASC) VISIBLE,
  INDEX `fk_Omiljena_staza_Korisnik1_idx` (`korisnik_id` ASC) VISIBLE,
  CONSTRAINT `fk_Omiljena_staza_Korisnik1`
    FOREIGN KEY (`korisnik_id`)
    REFERENCES `mydb`.`korisnik` (`korisnik_id`),
  CONSTRAINT `fk_Omiljena_staza_Staza1`
    FOREIGN KEY (`staza_id`)
    REFERENCES `mydb`.`staza` (`staza_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`poruka`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`poruka` (
  `poruka_id` BIGINT NOT NULL,
  `sadrzaj` TEXT NULL DEFAULT NULL,
  `datum_slanja` DATETIME NULL DEFAULT NULL,
  `procitana` INT NULL DEFAULT NULL,
  `posiljalac_id` BIGINT NOT NULL,
  `primalac_id` BIGINT NOT NULL,
  PRIMARY KEY (`poruka_id`),
  INDEX `fk_Poruka_Korisnik1_idx` (`posiljalac_id` ASC) VISIBLE,
  INDEX `fk_Poruka_Korisnik2_idx` (`primalac_id` ASC) VISIBLE,
  CONSTRAINT `fk_Poruka_Korisnik1`
    FOREIGN KEY (`posiljalac_id`)
    REFERENCES `mydb`.`korisnik` (`korisnik_id`),
  CONSTRAINT `fk_Poruka_Korisnik2`
    FOREIGN KEY (`primalac_id`)
    REFERENCES `mydb`.`korisnik` (`korisnik_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`prijateljstvo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`prijateljstvo` (
  `prijateljstvo_id` BIGINT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `datum_zahteva` DATETIME NOT NULL,
  `datum_odgovora` DATETIME NOT NULL,
  `posiljalac_id` BIGINT NOT NULL,
  `primalac_id` BIGINT NOT NULL,
  PRIMARY KEY (`prijateljstvo_id`),
  INDEX `fk_Prijateljstvo_Korisnik1_idx` (`posiljalac_id` ASC) VISIBLE,
  INDEX `fk_Prijateljstvo_Korisnik2_idx` (`primalac_id` ASC) VISIBLE,
  CONSTRAINT `fk_Prijateljstvo_Korisnik1`
    FOREIGN KEY (`posiljalac_id`)
    REFERENCES `mydb`.`korisnik` (`korisnik_id`),
  CONSTRAINT `fk_Prijateljstvo_Korisnik2`
    FOREIGN KEY (`primalac_id`)
    REFERENCES `mydb`.`korisnik` (`korisnik_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

ALTER TABLE `iznajmljivanje_opreme` 
ADD COLUMN `broj_sati` INT DEFAULT 1;

SET SQL_SAFE_UPDATES = 0;

-- 1. Brišemo sva iznajmljivanja
DELETE FROM `iznajmljivanje_opreme`;

-- 2. Vraćamo dostupnu količinu na nivo ukupne za svu opremu
UPDATE `ski_oprema` SET `dostupna_kolicina` = `ukupna_kolicina`;

SET SQL_SAFE_UPDATES = 1;

ALTER TABLE `ski_oprema` 
CHANGE COLUMN `cena_po_satu` `cena_po_danu` DOUBLE NULL DEFAULT NULL;

ALTER TABLE `iznajmljivanje_opreme` 
CHANGE COLUMN `broj_sati` `broj_dana` INT NULL DEFAULT NULL;

SET SQL_SAFE_UPDATES = 0;

-- Popravljamo korisnika 2 (sa 2025 na 2026)
UPDATE korisnik SET datum_registracije = '2026-01-13 16:53:00' WHERE korisnik_id = 2;

-- Popravljamo korisnika 3 (sa 2025 na 2026)
UPDATE korisnik SET datum_registracije = '2026-03-21 16:36:00' WHERE korisnik_id = 3;

-- Ostale samo proveravamo (već bi trebali biti 2026)
UPDATE korisnik SET datum_registracije = '2026-04-18 09:30:00' WHERE korisnik_id = 1;
UPDATE korisnik SET datum_registracije = '2026-02-01 07:07:00' WHERE korisnik_id = 4;
UPDATE korisnik SET datum_registracije = '2026-01-01 08:08:00' WHERE korisnik_id = 5;
UPDATE korisnik SET datum_registracije = '2026-03-03 17:17:00' WHERE korisnik_id = 6;
UPDATE korisnik SET datum_registracije = '2026-04-18 10:16:00' WHERE korisnik_id = 7;

SET SQL_SAFE_UPDATES = 1;

UPDATE staza 
SET duzina = 900 
WHERE staza_id = 7;

SELECT staza_id, naziv, duzina FROM staza;