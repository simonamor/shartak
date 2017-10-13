-- Convert schema 'ddl/_source/deploy/4/001-auto.yml' to 'ddl/_source/deploy/5/001-auto.yml':;

;
BEGIN;

;
SET foreign_key_checks=0;

;
CREATE TABLE `tile_type_descriptions` (
  `tile_type_id` integer unsigned NOT NULL auto_increment,
  `description` mediumtext NOT NULL,
  INDEX (`tile_type_id`),
  PRIMARY KEY (`tile_type_id`),
  CONSTRAINT `tile_type_descriptions_fk_tile_type_id` FOREIGN KEY (`tile_type_id`) REFERENCES `tile_types` (`tile_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB;

;
CREATE TABLE `tile_types` (
  `tile_type_id` integer unsigned NOT NULL auto_increment,
  `name` char(32) NOT NULL,
  `colour_code` char(6) NOT NULL,
  `move_type` char(10) NOT NULL,
  PRIMARY KEY (`tile_type_id`)
) ENGINE=InnoDB;

;
SET foreign_key_checks=1;

;
ALTER TABLE maps DROP PRIMARY KEY,
                 DROP INDEX tile_coords,
                 DROP COLUMN tile_id,
                 DROP COLUMN tile_x,
                 DROP COLUMN tile_y,
                 DROP COLUMN tile_z,
                 ADD COLUMN map_id integer unsigned NOT NULL auto_increment,
                 ADD COLUMN map_x integer NOT NULL,
                 ADD COLUMN map_y integer NOT NULL,
                 ADD COLUMN map_z integer NOT NULL,
                 ADD COLUMN tile_type_id integer NOT NULL,
                 ADD COLUMN name char(64) NULL,
                 ADD PRIMARY KEY (map_id),
                 ADD UNIQUE map_coords (map_x, map_y, map_z),
                 ENGINE=InnoDB;

;
ALTER TABLE characters ADD COLUMN map_x integer NOT NULL,
                       ADD COLUMN map_y integer NOT NULL,
                       ADD COLUMN map_z integer NOT NULL,
                       ADD INDEX characters_idx_map_x_map_y_map_z (map_x, map_y, map_z),
                       ADD CONSTRAINT characters_fk_map_x_map_y_map_z FOREIGN KEY (map_x, map_y, map_z) REFERENCES maps (map_x, map_y, map_z);

;
ALTER TABLE descriptions DROP FOREIGN KEY descriptions_fk_tile_id;

;
DROP TABLE descriptions;

;
DROP TABLE tiles;

;

COMMIT;

