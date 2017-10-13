-- Convert schema 'ddl/_source/deploy/4/001-auto.yml' to 'ddl/_source/deploy/5/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE tile_type_descriptions (
  tile_type_id INTEGER PRIMARY KEY NOT NULL,
  description mediumtext NOT NULL,
  FOREIGN KEY (tile_type_id) REFERENCES tile_types(tile_type_id) ON DELETE CASCADE
);

;
CREATE TABLE tile_types (
  tile_type_id INTEGER PRIMARY KEY NOT NULL,
  name char(32) NOT NULL,
  colour_code char(6) NOT NULL,
  move_type char(10) NOT NULL
);

;
ALTER TABLE characters ADD COLUMN map_x integer NOT NULL;

;
ALTER TABLE characters ADD COLUMN map_y integer NOT NULL;

;
ALTER TABLE characters ADD COLUMN map_z integer NOT NULL;

;
CREATE INDEX characters_idx_map_x_map_y_map_z ON characters (map_x, map_y, map_z);

;

;
CREATE TEMPORARY TABLE maps_temp_alter (
  map_id INTEGER PRIMARY KEY NOT NULL,
  map_x integer NOT NULL,
  map_y integer NOT NULL,
  map_z integer NOT NULL,
  tile_type_id integer NOT NULL,
  name char(64)
);

;
INSERT INTO maps_temp_alter( ) SELECT  FROM maps;

;
DROP TABLE maps;

;
CREATE TABLE maps (
  map_id INTEGER PRIMARY KEY NOT NULL,
  map_x integer NOT NULL,
  map_y integer NOT NULL,
  map_z integer NOT NULL,
  tile_type_id integer NOT NULL,
  name char(64)
);

;
CREATE UNIQUE INDEX map_coords02 ON maps (map_x, map_y, map_z);

;
INSERT INTO maps SELECT map_id, map_x, map_y, map_z, tile_type_id, name FROM maps_temp_alter;

;
DROP TABLE maps_temp_alter;

;
DROP TABLE descriptions;

;
DROP TABLE tiles;

;

COMMIT;

