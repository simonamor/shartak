-- Convert schema 'ddl/_source/deploy/1/001-auto.yml' to 'ddl/_source/deploy/2/001-auto.yml':;

;
BEGIN;

;
SET foreign_key_checks=0;

;
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

;
CREATE TABLE `descriptions` (
  `tile_id` integer unsigned NOT NULL auto_increment,
  `tile_description` mediumtext NOT NULL,
  INDEX (`tile_id`),
  PRIMARY KEY (`tile_id`),
  CONSTRAINT `descriptions_fk_tile_id` FOREIGN KEY (`tile_id`) REFERENCES `tiles` (`tile_id`) ON DELETE CASCADE
) ENGINE=InnoDB;

;
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

;
CREATE TABLE `items` (
  `item_id` integer unsigned NOT NULL auto_increment,
  `item_name` char(32) NOT NULL,
  `item_type` char(32) NOT NULL,
  `item_data` mediumtext NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB;

;
CREATE TABLE `maps` (
  `tile_id` integer unsigned NOT NULL,
  `tile_x` integer NOT NULL,
  `tile_y` integer NOT NULL,
  `tile_z` integer NOT NULL,
  PRIMARY KEY (`tile_id`),
  UNIQUE `tile_coords` (`tile_x`, `tile_y`, `tile_z`)
);

;
CREATE TABLE `skills` (
  `skill_id` integer unsigned NOT NULL auto_increment,
  `skill_name` char(32) NOT NULL,
  `skill_requirements` char(32) NOT NULL,
  `skill_data` mediumtext NOT NULL,
  `skill_prerequisites` mediumtext NOT NULL,
  PRIMARY KEY (`skill_id`)
) ENGINE=InnoDB;

;
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

;
CREATE TABLE `tiles` (
  `tile_id` integer unsigned NOT NULL auto_increment,
  `tile_name` char(32) NOT NULL,
  `colour_code` char(6) NOT NULL,
  `move_type` char(10) NOT NULL,
  PRIMARY KEY (`tile_id`)
) ENGINE=InnoDB;

;
SET foreign_key_checks=1;

;
ALTER TABLE accounts ENGINE=InnoDB;

;

COMMIT;

