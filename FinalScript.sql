-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema swp1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema swp1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `swp1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `swp1` ;

-- -----------------------------------------------------
-- Table `swp1`.`account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `swp1`.`account` (
  `Account` VARCHAR(200) CHARACTER SET 'utf8mb3' NOT NULL,
  `Password` VARCHAR(200) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `Email` VARCHAR(200) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `PhoneNumber` VARCHAR(20) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `Name` VARCHAR(50) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `RoleID` INT NULL DEFAULT NULL,
  `Money` DOUBLE NULL DEFAULT NULL,
  `createdAt` DATETIME NULL DEFAULT NULL,
  `deleteAt` DATETIME NULL DEFAULT NULL,
  `isActive` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`Account`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `swp1`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `swp1`.`product` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `SellPrice` DOUBLE NULL DEFAULT NULL,
  `Amount` INT NULL DEFAULT NULL,
  `Supplier` VARCHAR(200) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `Image` VARCHAR(200) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `ExpirationDate` DATE NULL DEFAULT NULL,
  `Description` TEXT NULL DEFAULT NULL,
  `createdAt` DATETIME NULL DEFAULT NULL,
  `deleteAt` DATETIME NULL DEFAULT NULL,
  `status` TINYINT(1) NULL DEFAULT NULL,
  `updateAt` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `swp1`.`transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `swp1`.`transaction` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `BuyPrice` DOUBLE NULL DEFAULT NULL,
  `BuyAmount` INT NULL DEFAULT NULL,
  `ProductID` INT NULL DEFAULT NULL,
  `createdAt` DATETIME NULL DEFAULT NULL,
  `deleteAt` DATETIME NULL DEFAULT NULL,
  `accountId` VARCHAR(200) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `Description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ProductID` (`ProductID` ASC) VISIBLE,
  INDEX `accountId` (`accountId` ASC) VISIBLE,
  CONSTRAINT `transaction_ibfk_1`
    FOREIGN KEY (`ProductID`)
    REFERENCES `swp1`.`product` (`Id`),
  CONSTRAINT `transaction_ibfk_2`
    FOREIGN KEY (`accountId`)
    REFERENCES `swp1`.`account` (`Account`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `swp1`.`card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `swp1`.`card` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Seri` VARCHAR(200) NULL DEFAULT NULL,
  `Code` VARCHAR(200) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `price` DOUBLE NULL DEFAULT NULL,
  `isBuy` TINYINT(1) NULL DEFAULT NULL,
  `ExpirationDate` DATE NULL DEFAULT NULL,
  `TransactionId` INT NULL DEFAULT NULL,
  `CreatedAt` DATETIME NULL DEFAULT NULL,
  `ProductId` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Seri_UNIQUE` (`Seri` ASC) VISIBLE,
  INDEX `TransactionId` (`TransactionId` ASC) VISIBLE,
  INDEX `ProductId` (`ProductId` ASC) VISIBLE,
  CONSTRAINT `card_ibfk_1`
    FOREIGN KEY (`TransactionId`)
    REFERENCES `swp1`.`transaction` (`Id`),
  CONSTRAINT `card_ibfk_2`
    FOREIGN KEY (`ProductId`)
    REFERENCES `swp1`.`product` (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `swp1`.`history-transfers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `swp1`.`history-transfers` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `FromAccount` VARCHAR(200) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `ToAccount` VARCHAR(200) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `Amount` DOUBLE NULL DEFAULT NULL,
  `createdAt` DATETIME NULL DEFAULT NULL,
  `deleteAt` DATETIME NULL DEFAULT NULL,
  `TransactionType` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
