-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema sice
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sice
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sice` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `sice` ;

-- -----------------------------------------------------
-- Table `sice`.`division_academica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sice`.`division_academica` (
                                                           `id_division_academica` INT NOT NULL AUTO_INCREMENT,
                                                           `nombre_division_academica` VARCHAR(60) NOT NULL,
    PRIMARY KEY (`id_division_academica`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sice`.`carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sice`.`carrera` (
                                                `id_carrera` INT NOT NULL AUTO_INCREMENT,
                                                `nombre_carrera` VARCHAR(90) NOT NULL,
    `division_academica_id_division_academica` INT NOT NULL,
    PRIMARY KEY (`id_carrera`),
    INDEX `fk_carrera_division_academica1_idx` (`division_academica_id_division_academica` ASC) VISIBLE,
    CONSTRAINT `fk_carrera_division_academica1`
    FOREIGN KEY (`division_academica_id_division_academica`)
    REFERENCES `sice`.`division_academica` (`id_division_academica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sice`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sice`.`usuario` (
                                                `id_usuario` INT NOT NULL AUTO_INCREMENT,
                                                `nombre_usuario` VARCHAR(45) NOT NULL,
    `apellido_usuario` VARCHAR(45) NOT NULL,
    `correo_electronico` VARCHAR(100) NOT NULL,
    `contrasena` VARCHAR(256) NOT NULL,
    `estado` TINYINT NOT NULL DEFAULT 1,
    `fecha_registrado` DATETIME NOT NULL,
    `codigo` VARCHAR(20) NULL,
    `id_tipo_usuario` INT NOT NULL,
    PRIMARY KEY (`id_usuario`),
    UNIQUE INDEX `correo_electronico_UNIQUE` (`correo_electronico` ASC) VISIBLE)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sice`.`examen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sice`.`examen` (
                                               `id_examen` INT NOT NULL AUTO_INCREMENT,
                                               `nombre_examen` VARCHAR(100) NOT NULL,
    `cantidad_preguntas` INT NOT NULL,
    `estado` TINYINT NOT NULL DEFAULT 0,
    `descripcion` VARCHAR(500) NULL,
    `usuario_id_usuario` INT NOT NULL,
    PRIMARY KEY (`id_examen`),
    INDEX `fk_examen_usuario1_idx` (`usuario_id_usuario` ASC) VISIBLE,
    CONSTRAINT `fk_examen_usuario1`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `sice`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sice`.`pregunta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sice`.`pregunta` (
                                                 `id_pregunta` INT NOT NULL AUTO_INCREMENT,
                                                 `pregunta` VARCHAR(300) NOT NULL,
    `id_tipo_pregunta` INT NOT NULL,
    PRIMARY KEY (`id_pregunta`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sice`.`opcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sice`.`opcion` (
                                               `id_opcion` INT NOT NULL AUTO_INCREMENT,
                                               `opcion` VARCHAR(350) NOT NULL,
    PRIMARY KEY (`id_opcion`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sice`.`examen_tiene_pregunta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sice`.`examen_tiene_pregunta` (
                                                              `examen_id_examen` INT NOT NULL,
                                                              `pregunta_id_pregunta` INT NOT NULL,
                                                              PRIMARY KEY (`examen_id_examen`, `pregunta_id_pregunta`),
    INDEX `fk_examen_has_pregunta_pregunta1_idx` (`pregunta_id_pregunta` ASC) VISIBLE,
    INDEX `fk_examen_has_pregunta_examen1_idx` (`examen_id_examen` ASC) VISIBLE,
    CONSTRAINT `fk_examen_has_pregunta_examen1`
    FOREIGN KEY (`examen_id_examen`)
    REFERENCES `sice`.`examen` (`id_examen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_examen_has_pregunta_pregunta1`
    FOREIGN KEY (`pregunta_id_pregunta`)
    REFERENCES `sice`.`pregunta` (`id_pregunta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sice`.`pregunta_opcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sice`.`pregunta_opcion` (
                                                        `pregunta_id_pregunta` INT NOT NULL,
                                                        `opcion_id_opcion` INT NOT NULL,
                                                        `correcta` TINYINT NOT NULL,
                                                        PRIMARY KEY (`pregunta_id_pregunta`, `opcion_id_opcion`),
    INDEX `fk_pregunta_has_opcion_opcion1_idx` (`opcion_id_opcion` ASC) VISIBLE,
    INDEX `fk_pregunta_has_opcion_pregunta1_idx` (`pregunta_id_pregunta` ASC) VISIBLE,
    CONSTRAINT `fk_pregunta_has_opcion_pregunta1`
    FOREIGN KEY (`pregunta_id_pregunta`)
    REFERENCES `sice`.`pregunta` (`id_pregunta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_pregunta_has_opcion_opcion1`
    FOREIGN KEY (`opcion_id_opcion`)
    REFERENCES `sice`.`opcion` (`id_opcion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sice`.`periodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sice`.`periodo` (
                                                `id_periodo` INT NOT NULL AUTO_INCREMENT,
                                                `descripcion` VARCHAR(100) NOT NULL,
    `fecha_inicio` DATE NOT NULL,
    `fecha_final` DATE NOT NULL,
    PRIMARY KEY (`id_periodo`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sice`.`aplicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sice`.`aplicacion` (
                                                   `id_aplicacion` INT NOT NULL AUTO_INCREMENT,
                                                   `periodo_id_periodo` INT NOT NULL,
                                                   `examen_id_examen` INT NOT NULL,
                                                   INDEX `fk_aplicacion_periodo1_idx` (`periodo_id_periodo` ASC) VISIBLE,
    INDEX `fk_aplicacion_examen1_idx` (`examen_id_examen` ASC) VISIBLE,
    PRIMARY KEY (`id_aplicacion`),
    CONSTRAINT `fk_aplicacion_periodo1`
    FOREIGN KEY (`periodo_id_periodo`)
    REFERENCES `sice`.`periodo` (`id_periodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_aplicacion_examen1`
    FOREIGN KEY (`examen_id_examen`)
    REFERENCES `sice`.`examen` (`id_examen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sice`.`grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sice`.`grupo` (
                                              `id_grupo` INT NOT NULL AUTO_INCREMENT,
                                              `grado` INT NOT NULL,
                                              `grupo` VARCHAR(1) NOT NULL,
    `periodo_id_periodo` INT NOT NULL,
    INDEX `fk_grupos_periodo1_idx` (`periodo_id_periodo` ASC) VISIBLE,
    PRIMARY KEY (`id_grupo`),
    CONSTRAINT `fk_grupos_periodo1`
    FOREIGN KEY (`periodo_id_periodo`)
    REFERENCES `sice`.`periodo` (`id_periodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sice`.`respuesta_abierta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sice`.`respuesta_abierta` (
                                                          `pregunta_id_pregunta` INT NOT NULL,
                                                          `aplicacion_id_aplicacion` INT NOT NULL,
                                                          `respuesta` VARCHAR(500) NULL,
    `correcta` TINYINT NOT NULL,
    PRIMARY KEY (`pregunta_id_pregunta`, `aplicacion_id_aplicacion`),
    INDEX `fk_pregunta_has_aplicacion_aplicacion1_idx` (`aplicacion_id_aplicacion` ASC) VISIBLE,
    INDEX `fk_pregunta_has_aplicacion_pregunta1_idx` (`pregunta_id_pregunta` ASC) VISIBLE,
    CONSTRAINT `fk_pregunta_has_aplicacion_pregunta1`
    FOREIGN KEY (`pregunta_id_pregunta`)
    REFERENCES `sice`.`pregunta` (`id_pregunta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_pregunta_has_aplicacion_aplicacion1`
    FOREIGN KEY (`aplicacion_id_aplicacion`)
    REFERENCES `sice`.`aplicacion` (`id_aplicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sice`.`respuesta_opcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sice`.`respuesta_opcion` (
                                                         `pregunta_opcion_pregunta_id_pregunta` INT NOT NULL,
                                                         `pregunta_opcion_opcion_id_opcion` INT NOT NULL,
                                                         `aplicacion_id_aplicacion` INT NOT NULL,
                                                         PRIMARY KEY (`pregunta_opcion_pregunta_id_pregunta`, `pregunta_opcion_opcion_id_opcion`, `aplicacion_id_aplicacion`),
    INDEX `fk_pregunta_opcion_has_aplicacion_aplicacion1_idx` (`aplicacion_id_aplicacion` ASC) VISIBLE,
    INDEX `fk_pregunta_opcion_has_aplicacion_pregunta_opcion1_idx` (`pregunta_opcion_pregunta_id_pregunta` ASC, `pregunta_opcion_opcion_id_opcion` ASC) VISIBLE,
    CONSTRAINT `fk_pregunta_opcion_has_aplicacion_pregunta_opcion1`
    FOREIGN KEY (`pregunta_opcion_pregunta_id_pregunta` , `pregunta_opcion_opcion_id_opcion`)
    REFERENCES `sice`.`pregunta_opcion` (`pregunta_id_pregunta` , `opcion_id_opcion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_pregunta_opcion_has_aplicacion_aplicacion1`
    FOREIGN KEY (`aplicacion_id_aplicacion`)
    REFERENCES `sice`.`aplicacion` (`id_aplicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sice`.`calificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sice`.`calificacion` (
                                                     `id_calificacion` INT NOT NULL AUTO_INCREMENT,
                                                     `calificacion` INT NULL,
                                                     `usuario_id_usuario` INT NOT NULL,
                                                     `aplicacion_id_aplicacion` INT NOT NULL,
                                                     PRIMARY KEY (`id_calificacion`),
    INDEX `fk_calificacion_usuario1_idx` (`usuario_id_usuario` ASC) VISIBLE,
    INDEX `fk_calificacion_aplicacion1_idx` (`aplicacion_id_aplicacion` ASC) VISIBLE,
    CONSTRAINT `fk_calificacion_usuario1`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `sice`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_calificacion_aplicacion1`
    FOREIGN KEY (`aplicacion_id_aplicacion`)
    REFERENCES `sice`.`aplicacion` (`id_aplicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sice`.`usuario_tiene_grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sice`.`usuario_tiene_grupo` (
                                                            `grupo_id_grupo` INT NOT NULL,
                                                            `usuario_id_usuario` INT NOT NULL,
                                                            PRIMARY KEY (`grupo_id_grupo`, `usuario_id_usuario`),
    INDEX `fk_grupo_has_usuario_usuario1_idx` (`usuario_id_usuario` ASC) VISIBLE,
    INDEX `fk_grupo_has_usuario_grupo1_idx` (`grupo_id_grupo` ASC) VISIBLE,
    CONSTRAINT `fk_grupo_has_usuario_grupo1`
    FOREIGN KEY (`grupo_id_grupo`)
    REFERENCES `sice`.`grupo` (`id_grupo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_grupo_has_usuario_usuario1`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `sice`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sice`.`grupo_tiene_carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sice`.`grupo_tiene_carrera` (
                                                            `carrera_id_carrera` INT NOT NULL,
                                                            `grupo_id_grupo` INT NOT NULL,
                                                            PRIMARY KEY (`carrera_id_carrera`, `grupo_id_grupo`),
    INDEX `fk_carrera_has_grupo_grupo1_idx` (`grupo_id_grupo` ASC) VISIBLE,
    INDEX `fk_carrera_has_grupo_carrera1_idx` (`carrera_id_carrera` ASC) VISIBLE,
    CONSTRAINT `fk_carrera_has_grupo_carrera1`
    FOREIGN KEY (`carrera_id_carrera`)
    REFERENCES `sice`.`carrera` (`id_carrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_carrera_has_grupo_grupo1`
    FOREIGN KEY (`grupo_id_grupo`)
    REFERENCES `sice`.`grupo` (`id_grupo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
