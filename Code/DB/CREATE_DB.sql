-- MySQL Script generated by MySQL Workbench
-- Sat Apr  7 11:56:36 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema group3
-- -----------------------------------------------------
-- DROP SCHEMA IF EXISTS `group3` ;

-- -----------------------------------------------------
-- Schema group3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `group3` DEFAULT CHARACTER SET utf8 ;
USE `group3` ;

-- -----------------------------------------------------
-- Table `group3`.`Patient`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `group3`.`Patient` ;

CREATE TABLE IF NOT EXISTS `group3`.`Patient` (
  `P_ID` VARCHAR(12) NOT NULL,
  `fname` VARCHAR(45) NULL,
  `lname` VARCHAR(45) NULL,
  `mname` VARCHAR(45) NULL,
  `phoneNum` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `updated` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`P_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group3`.`Questionnaire`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group3`.`Questionnaire` ;

CREATE TABLE IF NOT EXISTS `group3`.`Questionnaire` (
  `Q_ID` VARCHAR(12) NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`Q_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group3`.`Form`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group3`.`Form` ;

CREATE TABLE IF NOT EXISTS `group3`.`Form` (
  `F_ID` VARCHAR(12) NOT NULL,
  `name` VARCHAR(45) NULL,
  `type` VARCHAR(45) NULL,
  `time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Questionnaire_Q_ID` VARCHAR(12) NOT NULL,
  `Patient_P_ID` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`F_ID`),
  INDEX `fk_Form_Questionnaire1_idx` (`Questionnaire_Q_ID` ASC),
  INDEX `fk_Form_Patient1_idx` (`Patient_P_ID` ASC),
  CONSTRAINT `fk_Form_Questionnaire1`
    FOREIGN KEY (`Questionnaire_Q_ID`)
    REFERENCES `group3`.`Questionnaire` (`Q_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Form_Patient1`
    FOREIGN KEY (`Patient_P_ID`)
    REFERENCES `group3`.`Patient` (`P_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group3`.`QSection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group3`.`QSection` ;

CREATE TABLE IF NOT EXISTS `group3`.`QSection` (
  `QS_ID` VARCHAR(12) NOT NULL,
  `title` VARCHAR(45) NULL,
  `prompt` VARCHAR(256) NULL,
  `numOptions` INT NULL,
  `numQ` INT NULL,
  `Questionnaire_Q_ID` VARCHAR(12) NOT NULL,
  `Parent_QS_ID` VARCHAR(12) NULL,
  PRIMARY KEY (`QS_ID`),
  INDEX `fk_QSection_Questionnaire1_idx` (`Questionnaire_Q_ID` ASC),
  INDEX `fk_QSection_QSection1_idx` (`Parent_QS_ID` ASC),
  CONSTRAINT `fk_QSection_Questionnaire1`
    FOREIGN KEY (`Questionnaire_Q_ID`)
    REFERENCES `group3`.`Questionnaire` (`Q_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_QSection_QSection1`
    FOREIGN KEY (`Parent_QS_ID`)
    REFERENCES `group3`.`QSection` (`QS_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group3`.`Question`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group3`.`Question` ;

CREATE TABLE IF NOT EXISTS `group3`.`Question` (
  `Qu_ID` VARCHAR(12) NOT NULL,
  `qu_text` VARCHAR(256) NULL,
  `qu_num` INT NULL,
  `QSection_QS_ID` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`Qu_ID`),
  INDEX `fk_Question_QSection1_idx` (`QSection_QS_ID` ASC),
  CONSTRAINT `fk_Question_QSection1`
    FOREIGN KEY (`QSection_QS_ID`)
    REFERENCES `group3`.`QSection` (`QS_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group3`.`Answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group3`.`Answer` ;

CREATE TABLE IF NOT EXISTS `group3`.`Answer` (
  `ans` VARCHAR(256) NULL,
  `Question_Qu_ID` VARCHAR(12) NOT NULL,
  `Form_F_ID` VARCHAR(12) NOT NULL,
  INDEX `fk_Answer_Question1_idx` (`Question_Qu_ID` ASC),
  INDEX `fk_Answer_Form1_idx` (`Form_F_ID` ASC),
  CONSTRAINT `fk_Answer_Question1`
    FOREIGN KEY (`Question_Qu_ID`)
    REFERENCES `group3`.`Question` (`Qu_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Answer_Form1`
    FOREIGN KEY (`Form_F_ID`)
    REFERENCES `group3`.`Form` (`F_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group3`.`User`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `group3`.`User` ;

CREATE TABLE IF NOT EXISTS `group3`.`User` (
  `U_ID` VARCHAR(12) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`U_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group3`.`User_has_Patient`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `group3`.`User_has_Patient` ;

CREATE TABLE IF NOT EXISTS `group3`.`User_has_Patient` (
  `User_U_ID` VARCHAR(12) NOT NULL,
  `Patient_P_ID` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`User_U_ID`, `Patient_P_ID`),
  INDEX `fk_User_has_Patient_Patient1_idx` (`Patient_P_ID` ASC),
  INDEX `fk_User_has_Patient_User1_idx` (`User_U_ID` ASC),
  CONSTRAINT `fk_User_has_Patient_User1`
    FOREIGN KEY (`User_U_ID`)
    REFERENCES `group3`.`User` (`U_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Patient_Patient1`
    FOREIGN KEY (`Patient_P_ID`)
    REFERENCES `group3`.`Patient` (`P_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group3`.`optionTitle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group3`.`optionTitle` ;

CREATE TABLE IF NOT EXISTS `group3`.`optionTitle` (
  `QSection_QS_ID` VARCHAR(12) NOT NULL,
  `colNum` INT NOT NULL,
  `title` VARCHAR(45) NULL,
  INDEX `fk_optionTitle_QSection1_idx` (`QSection_QS_ID` ASC),
  CONSTRAINT `fk_optionTitle_QSection1`
    FOREIGN KEY (`QSection_QS_ID`)
    REFERENCES `group3`.`QSection` (`QS_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group3`.`Diagnosis`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group3`.`Diagnosis` ;

CREATE TABLE IF NOT EXISTS `group3`.`Diagnosis` (
  `D_ID` VARCHAR(12) NOT NULL,
  `title` VARCHAR(45) NULL,
  `logic` VARCHAR(4096) NULL,
  `posMessage` VARCHAR(256) NULL,
  `negMessage` VARCHAR(256) NULL,
  `footnote` VARCHAR(256) NULL,
  `Questionnaire_Q_ID` VARCHAR(12) NOT NULL,
  `Parent_D_ID` VARCHAR(12) NULL,
  PRIMARY KEY (`D_ID`),
  INDEX `fk_Diagnosis_Questionnaire1_idx` (`Questionnaire_Q_ID` ASC),
  INDEX `fk_Diagnosis_Diagnosis1_idx` (`Parent_D_ID` ASC),
  CONSTRAINT `fk_Diagnosis_Questionnaire1`
    FOREIGN KEY (`Questionnaire_Q_ID`)
    REFERENCES `group3`.`Questionnaire` (`Q_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Diagnosis_Diagnosis1`
    FOREIGN KEY (`Parent_D_ID`)
    REFERENCES `group3`.`Diagnosis` (`D_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
