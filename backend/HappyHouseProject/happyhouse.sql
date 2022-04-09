-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema happyhouse
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema happyhouse
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `happyhouse` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `happyhouse` ;

-- -----------------------------------------------------
-- Table `happyhouse`.`sidocode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`sidocode` (
  `sidoCode` VARCHAR(10) NOT NULL,
  `sidoName` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`sidoCode`),
  UNIQUE INDEX `sidoName` (`sidoName` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`dongcode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`dongcode` (
  `dongCode` VARCHAR(10) NOT NULL,
  `sidoName` VARCHAR(30) NULL DEFAULT NULL,
  `gugunName` VARCHAR(30) NULL DEFAULT NULL,
  `dongName` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`dongCode`),
  INDEX `sidoName` (`sidoName` ASC) VISIBLE,
  CONSTRAINT `dongcode_ibfk_1`
    FOREIGN KEY (`sidoName`)
    REFERENCES `happyhouse`.`sidocode` (`sidoName`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`baseaddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`baseaddress` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `sidoName` VARCHAR(30) NULL DEFAULT NULL,
  `gugunName` VARCHAR(30) NULL DEFAULT NULL,
  `dongName` VARCHAR(30) NULL DEFAULT NULL,
  `dongCode` VARCHAR(10) NULL DEFAULT NULL,
  `lat` VARCHAR(20) NULL DEFAULT NULL,
  `lng` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`no`),
  INDEX `dongCode` (`dongCode` ASC) VISIBLE,
  CONSTRAINT `baseaddress_ibfk_1`
    FOREIGN KEY (`dongCode`)
    REFERENCES `happyhouse`.`dongcode` (`dongCode`))
ENGINE = InnoDB
AUTO_INCREMENT = 3597
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`category` (
  `large_cartegory_code` VARCHAR(1) NOT NULL,
  `large_category_name` VARCHAR(45) NULL DEFAULT NULL,
  `medium_category_code` VARCHAR(3) NOT NULL,
  `medium_category_name` VARCHAR(45) NULL DEFAULT NULL,
  `small_category_code` VARCHAR(6) NOT NULL,
  `small_category_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`small_category_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`guguncode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`guguncode` (
  `gugunCode` VARCHAR(10) NOT NULL,
  `gugunName` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`gugunCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`houseinfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`houseinfo` (
  `aptCode` INT NOT NULL,
  `aptName` VARCHAR(50) NULL DEFAULT NULL,
  `dongCode` VARCHAR(10) NULL DEFAULT NULL,
  `dongName` VARCHAR(30) NULL DEFAULT NULL,
  `buildYear` INT NULL DEFAULT NULL,
  `jibun` VARCHAR(30) NULL DEFAULT NULL,
  `lat` VARCHAR(30) NULL DEFAULT NULL,
  `lng` VARCHAR(30) NULL DEFAULT NULL,
  `img` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`aptCode`),
  INDEX `dongCode` (`dongCode` ASC) VISIBLE,
  CONSTRAINT `houseinfo_ibfk_1`
    FOREIGN KEY (`dongCode`)
    REFERENCES `happyhouse`.`dongcode` (`dongCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`housedeal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`housedeal` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `aptCode` INT NULL DEFAULT NULL,
  `dealAmount` VARCHAR(20) NULL DEFAULT NULL,
  `dealYear` INT NULL DEFAULT NULL,
  `dealMonth` INT NULL DEFAULT NULL,
  `dealDay` INT NULL DEFAULT NULL,
  `area` VARCHAR(30) NULL DEFAULT NULL,
  `floor` VARCHAR(30) NULL DEFAULT NULL,
  `type` VARCHAR(30) NULL DEFAULT NULL,
  `rentMoney` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`no`),
  INDEX `aptCode` (`aptCode` ASC) VISIBLE,
  CONSTRAINT `housedeal_ibfk_1`
    FOREIGN KEY (`aptCode`)
    REFERENCES `happyhouse`.`houseinfo` (`aptCode`))
ENGINE = InnoDB
AUTO_INCREMENT = 68865
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`user` (
  `user_id` VARCHAR(45) NOT NULL,
  `user_pass` VARCHAR(45) NULL DEFAULT NULL,
  `user_name` VARCHAR(45) NULL DEFAULT NULL,
  `user_phone` VARCHAR(45) NULL DEFAULT NULL,
  `user_addr` VARCHAR(45) NULL DEFAULT NULL,
  `user_email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`notices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`notices` (
  `articleno` INT NOT NULL AUTO_INCREMENT,
  `userid` VARCHAR(16) NULL DEFAULT NULL,
  `subject` VARCHAR(100) NULL DEFAULT NULL,
  `content` VARCHAR(2000) NULL DEFAULT NULL,
  `regtime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`articleno`),
  INDEX `happyhouse_userid_fk_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `happyhouse_userid_fk`
    FOREIGN KEY (`userid`)
    REFERENCES `happyhouse`.`user` (`user_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`store` (
  `store_id` INT NOT NULL,
  `store_name` VARCHAR(45) NULL DEFAULT NULL,
  `branch_name` VARCHAR(45) NULL DEFAULT NULL,
  `large_category_code` VARCHAR(1) NULL DEFAULT NULL,
  `medium_category_code` VARCHAR(3) NULL DEFAULT NULL,
  `small_category_code` VARCHAR(6) NULL DEFAULT NULL,
  PRIMARY KEY (`store_id`),
  INDEX `store_small_category_code_fk_idx` (`small_category_code` ASC) VISIBLE,
  CONSTRAINT `store_small_category_code_fk`
    FOREIGN KEY (`small_category_code`)
    REFERENCES `happyhouse`.`category` (`small_category_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`store_location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`store_location` (
  `store_id` INT NOT NULL,
  `sido_code` INT NULL DEFAULT NULL,
  `gugun_code` INT NULL DEFAULT NULL,
  `dong_code` INT NULL DEFAULT NULL,
  `address` VARCHAR(200) NULL DEFAULT NULL,
  `lng` DOUBLE NULL DEFAULT NULL,
  `lat` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`store_id`),
  CONSTRAINT `store_location_store_id_fk`
    FOREIGN KEY (`store_id`)
    REFERENCES `happyhouse`.`store` (`store_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`trash`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`trash` (
  `gu` VARCHAR(45) NOT NULL,
  `total` VARCHAR(45) NULL DEFAULT NULL,
  `landfill` VARCHAR(45) NULL DEFAULT NULL,
  `incineration` VARCHAR(45) NULL DEFAULT NULL,
  `recycle` VARCHAR(45) NULL DEFAULT NULL,
  `etc` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`gu`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `happyhouse`.`user_interest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `happyhouse`.`user_interest` (
  `user_id` VARCHAR(45) NOT NULL,
  `interest_dong` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_interest_interest_dong_fk`
    FOREIGN KEY ()
    REFERENCES `happyhouse`.`dongcode` (),
  CONSTRAINT `user_interest_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `happyhouse`.`user` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
