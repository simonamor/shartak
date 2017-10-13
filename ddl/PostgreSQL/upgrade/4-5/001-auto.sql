-- Convert schema 'ddl/_source/deploy/4/001-auto.yml' to 'ddl/_source/deploy/5/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE "tile_type_descriptions" (
  "tile_type_id" serial NOT NULL,
  "description" text NOT NULL,
  PRIMARY KEY ("tile_type_id")
);

;
CREATE TABLE "tile_types" (
  "tile_type_id" serial NOT NULL,
  "name" character(32) NOT NULL,
  "colour_code" character(6) NOT NULL,
  "move_type" character(10) NOT NULL,
  PRIMARY KEY ("tile_type_id")
);

;
ALTER TABLE "tile_type_descriptions" ADD CONSTRAINT "tile_type_descriptions_fk_tile_type_id" FOREIGN KEY ("tile_type_id")
  REFERENCES "tile_types" ("tile_type_id") ON DELETE CASCADE DEFERRABLE;

;
ALTER TABLE characters ADD COLUMN map_x integer NOT NULL;

;
ALTER TABLE characters ADD COLUMN map_y integer NOT NULL;

;
ALTER TABLE characters ADD COLUMN map_z integer NOT NULL;

;
CREATE INDEX characters_idx_map_x_map_y_map_z on characters (map_x, map_y, map_z);

;
ALTER TABLE maps DROP CONSTRAINT maps_pkey;

;
ALTER TABLE maps DROP CONSTRAINT tile_coords;

;
ALTER TABLE maps DROP COLUMN tile_id;

;
ALTER TABLE maps DROP COLUMN tile_x;

;
ALTER TABLE maps DROP COLUMN tile_y;

;
ALTER TABLE maps DROP COLUMN tile_z;

;
ALTER TABLE maps ADD COLUMN map_id serial NOT NULL;

;
ALTER TABLE maps ADD COLUMN map_x integer NOT NULL;

;
ALTER TABLE maps ADD COLUMN map_y integer NOT NULL;

;
ALTER TABLE maps ADD COLUMN map_z integer NOT NULL;

;
ALTER TABLE maps ADD COLUMN tile_type_id integer NOT NULL;

;
ALTER TABLE maps ADD COLUMN name character(64);

;
ALTER TABLE maps ADD PRIMARY KEY (map_id);

;
ALTER TABLE maps ADD CONSTRAINT map_coords UNIQUE (map_x, map_y, map_z);

;
ALTER TABLE characters ADD CONSTRAINT characters_fk_map_x_map_y_map_z FOREIGN KEY (map_x, map_y, map_z)
  REFERENCES maps (map_x, map_y, map_z) DEFERRABLE;

;
DROP TABLE descriptions CASCADE;

;
DROP TABLE tiles CASCADE;

;

COMMIT;

