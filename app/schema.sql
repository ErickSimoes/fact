-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema fact
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fact
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fact` DEFAULT CHARACTER SET utf8 ;
USE `fact` ;

-- -----------------------------------------------------
-- Table `fact`.`grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fact`.`grupo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `periodo` VARCHAR(30) NOT NULL,
  `semestre` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fact`.`estudante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fact`.`estudante` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(70) NOT NULL,
  `email` VARCHAR(35) NULL,
  `palavra_passe` VARCHAR(10) NOT NULL,
  `grupo_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_grupo_idx` (`grupo_id` ASC) VISIBLE,
  CONSTRAINT `fk_grupo`
    FOREIGN KEY (`grupo_id`)
    REFERENCES `fact`.`grupo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fact`.`avaliacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fact`.`avaliacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(20) NULL,
  `semestre` VARCHAR(10) NULL,
  `data` DATE NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fact`.`criterio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fact`.`criterio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(40) NOT NULL,
  `descricao` VARCHAR(255) NOT NULL,
  `nota_maxima` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fact`.`justificativa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fact`.`justificativa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fact`.`avaliacao_has_criterio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fact`.`avaliacao_has_criterio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `avaliacao_id` INT NOT NULL,
  `criterio_id` INT NOT NULL,
  `justificativa_id` INT NOT NULL,
  `nota` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_avaliacao_idx` (`avaliacao_id` ASC) VISIBLE,
  INDEX `fk_criterio_idx` (`criterio_id` ASC) VISIBLE,
  INDEX `fk_avaliacao_justificativa_idx` (`justificativa_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_avaliacao`
    FOREIGN KEY (`avaliacao_id`)
    REFERENCES `fact`.`avaliacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_criterio`
    FOREIGN KEY (`criterio_id`)
    REFERENCES `fact`.`criterio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_avaliacao_justificativa`
    FOREIGN KEY (`justificativa_id`)
    REFERENCES `fact`.`justificativa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fact`.`avaliacao_has_estudante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fact`.`avaliacao_has_estudante` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `avaliacao_id` INT NOT NULL,
  `estudante_avaliado_id` INT NOT NULL,
  `estudante_avaliador_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_avaliacao_has_estudante_avaliacao1_idx` (`avaliacao_id` ASC) VISIBLE,
  INDEX `fk_avaliacao_has_estudante_avaliador_idx` (`estudante_avaliador_id` ASC) VISIBLE,
  INDEX `fk_avaliacao_has_estudante_avaliado_idx` (`estudante_avaliado_id` ASC) VISIBLE,
  CONSTRAINT `fk_avaliacao_has_estudante_avaliacao1`
    FOREIGN KEY (`avaliacao_id`)
    REFERENCES `fact`.`avaliacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_avaliacao_has_estudante_avaliado`
    FOREIGN KEY (`estudante_avaliado_id`)
    REFERENCES `fact`.`estudante` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_avaliacao_has_estudante_avaliador`
    FOREIGN KEY (`estudante_avaliador_id`)
    REFERENCES `fact`.`estudante` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fact`.`professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fact`.`professor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(70) NOT NULL,
  `email` VARCHAR(35) NOT NULL,
  `senha` CHAR(97) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
