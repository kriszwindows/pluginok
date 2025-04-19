-- hCoins Database Initialization SQL Script
-- Created by: Zorplex

-- Megjegyzés: Shared hosting környezetben az adatbázist előre létrehozzák neked,
-- és általában nincs jogosultságod új adatbázis létrehozásához.
-- Helyettesítsd a 'hcoins_' táblák előtagját a saját adatbázisod azonosítójával, ha szükséges.

-- Create coins table
CREATE TABLE IF NOT EXISTS `hcoins_coins` (
  `uuid` VARCHAR(36) PRIMARY KEY,
  `coins` DOUBLE DEFAULT 0.0,
  `username` VARCHAR(16),
  `last_updated` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create purchases log table (optional - for transaction history)
CREATE TABLE IF NOT EXISTS `hcoins_purchases` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `uuid` VARCHAR(36) NOT NULL,
  `username` VARCHAR(16),
  `item_id` VARCHAR(64) NOT NULL,
  `item_name` VARCHAR(128) NOT NULL,
  `price` DOUBLE NOT NULL,
  `purchase_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`uuid`) REFERENCES `hcoins_coins`(`uuid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS `idx_uuid` ON `hcoins_coins` (`uuid`);
CREATE INDEX IF NOT EXISTS `idx_username` ON `hcoins_coins` (`username`);

-- Add a sample record (optional)
-- INSERT INTO `hcoins_coins` (`uuid`, `coins`, `username`) VALUES
-- ('00000000-0000-0000-0000-000000000000', 1000, 'ExamplePlayer');

-- Megjegyzés: 
-- A config.yml fájlban állítsd be a "storage.mysql.database" értéket 
-- a tárhelyszolgáltató által megadott adatbázis nevére.
-- Példa: storage.mysql.database: 'u73699_lYSYSRhJuO'

-- Create privileges (optional - for security)
-- GRANT SELECT, INSERT, UPDATE, DELETE ON `hcoins`.* TO 'hcoins_user'@'localhost' IDENTIFIED BY 'password';
-- FLUSH PRIVILEGES;

-- Note: Replace 'password' with a secure password in production environment 