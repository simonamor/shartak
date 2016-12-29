-- 
-- Created by SQL::Translator::Producer::MySQL
-- Created on Thu Dec 29 23:24:55 2016
-- 
;
SET foreign_key_checks=0;
--
-- Table: `account_roles`
--
CREATE TABLE `account_roles` (
  `account_id` integer unsigned NOT NULL,
  `role_id` integer unsigned NOT NULL,
  PRIMARY KEY (`account_id`, `role_id`)
);
--
-- Table: `accounts`
--
CREATE TABLE `accounts` (
  `account_id` integer unsigned NOT NULL auto_increment,
  `email` char(128) NOT NULL,
  `password` text NULL,
  PRIMARY KEY (`account_id`),
  UNIQUE `email` (`email`)
) ENGINE=InnoDB;
--
-- Table: `items`
--
CREATE TABLE `items` (
  `item_id` integer unsigned NOT NULL auto_increment,
  `item_name` char(32) NOT NULL,
  `item_type` char(32) NOT NULL,
  `item_data` mediumtext NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB;
--
-- Table: `maps`
--
CREATE TABLE `maps` (
  `tile_id` integer unsigned NOT NULL,
  `tile_x` integer NOT NULL,
  `tile_y` integer NOT NULL,
  `tile_z` integer NOT NULL,
  PRIMARY KEY (`tile_id`),
  UNIQUE `tile_coords` (`tile_x`, `tile_y`, `tile_z`)
);
--
-- Table: `roles`
--
CREATE TABLE `roles` (
  `role_id` integer unsigned NOT NULL auto_increment,
  `role` char(255) NOT NULL,
  `description` char(255) NULL,
  PRIMARY KEY (`role_id`)
);
--
-- Table: `sessions`
--
CREATE TABLE `sessions` (
  `id` char(72) NOT NULL,
  `session_data` mediumtext NULL,
  `expires` integer NULL,
  PRIMARY KEY (`id`)
);
--
-- Table: `skills`
--
CREATE TABLE `skills` (
  `skill_id` integer unsigned NOT NULL auto_increment,
  `skill_name` char(32) NOT NULL,
  `skill_requirements` char(32) NOT NULL,
  `skill_data` mediumtext NOT NULL,
  `skill_prerequisites` mediumtext NOT NULL,
  PRIMARY KEY (`skill_id`)
) ENGINE=InnoDB;
--
-- Table: `tiles`
--
CREATE TABLE `tiles` (
  `tile_id` integer unsigned NOT NULL auto_increment,
  `tile_name` char(32) NOT NULL,
  `colour_code` char(6) NOT NULL,
  `move_type` char(10) NOT NULL,
  PRIMARY KEY (`tile_id`)
) ENGINE=InnoDB;
--
-- Table: `characters`
--
CREATE TABLE `characters` (
  `character_id` integer unsigned NOT NULL auto_increment,
  `character_name` char(32) NOT NULL,
  `account_id` integer unsigned NOT NULL,
  `character_health` integer unsigned NOT NULL,
  `character_exp` integer unsigned NOT NULL,
  `character_max_ap` integer unsigned NOT NULL,
  `character_ap` integer unsigned NOT NULL,
  INDEX `characters_idx_account_id` (`account_id`),
  PRIMARY KEY (`character_id`),
  UNIQUE `character_name` (`character_name`),
  CONSTRAINT `characters_fk_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`)
) ENGINE=InnoDB;
--
-- Table: `descriptions`
--
CREATE TABLE `descriptions` (
  `tile_id` integer unsigned NOT NULL auto_increment,
  `tile_description` mediumtext NOT NULL,
  INDEX (`tile_id`),
  PRIMARY KEY (`tile_id`),
  CONSTRAINT `descriptions_fk_tile_id` FOREIGN KEY (`tile_id`) REFERENCES `tiles` (`tile_id`) ON DELETE CASCADE
) ENGINE=InnoDB;
--
-- Table: `inventories`
--
CREATE TABLE `inventories` (
  `character_id` integer unsigned NOT NULL,
  `item_id` integer unsigned NOT NULL,
  `item_quantity` integer unsigned NOT NULL,
  INDEX `inventories_idx_character_id` (`character_id`),
  INDEX `inventories_idx_item_id` (`item_id`),
  PRIMARY KEY (`character_id`, `item_id`),
  CONSTRAINT `inventories_fk_character_id` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE,
  CONSTRAINT `inventories_fk_item_id` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`)
) ENGINE=InnoDB;
--
-- Table: `skillsets`
--
CREATE TABLE `skillsets` (
  `character_id` integer unsigned NOT NULL,
  `skill_id` integer unsigned NOT NULL,
  `item_quantity` integer unsigned NOT NULL,
  INDEX `skillsets_idx_character_id` (`character_id`),
  INDEX `skillsets_idx_skill_id` (`skill_id`),
  PRIMARY KEY (`character_id`, `skill_id`),
  CONSTRAINT `skillsets_fk_character_id` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`),
  CONSTRAINT `skillsets_fk_skill_id` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`skill_id`) ON DELETE CASCADE
) ENGINE=InnoDB;
SET foreign_key_checks=1;
