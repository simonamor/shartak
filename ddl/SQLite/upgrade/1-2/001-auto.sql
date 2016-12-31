-- Convert schema 'ddl/_source/deploy/1/001-auto.yml' to 'ddl/_source/deploy/2/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE characters (
  character_id INTEGER PRIMARY KEY NOT NULL,
  character_name char(32) NOT NULL,
  account_id integer NOT NULL,
  character_health integer NOT NULL,
  character_exp integer NOT NULL,
  character_max_ap integer NOT NULL,
  character_ap integer NOT NULL,
  FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

;
CREATE INDEX characters_idx_account_id ON characters (account_id);

;
CREATE UNIQUE INDEX character_name ON characters (character_name);

;
CREATE TABLE descriptions (
  tile_id INTEGER PRIMARY KEY NOT NULL,
  tile_description mediumtext NOT NULL,
  FOREIGN KEY (tile_id) REFERENCES tiles(tile_id) ON DELETE CASCADE
);

;
CREATE TABLE inventories (
  character_id integer NOT NULL,
  item_id integer NOT NULL,
  item_quantity integer NOT NULL,
  PRIMARY KEY (character_id, item_id),
  FOREIGN KEY (character_id) REFERENCES characters(character_id) ON DELETE CASCADE,
  FOREIGN KEY (item_id) REFERENCES items(item_id)
);

;
CREATE INDEX inventories_idx_character_id ON inventories (character_id);

;
CREATE INDEX inventories_idx_item_id ON inventories (item_id);

;
CREATE TABLE items (
  item_id INTEGER PRIMARY KEY NOT NULL,
  item_name char(32) NOT NULL,
  item_type char(32) NOT NULL,
  item_data mediumtext NOT NULL
);

;
CREATE TABLE maps (
  tile_id INTEGER PRIMARY KEY NOT NULL,
  tile_x integer NOT NULL,
  tile_y integer NOT NULL,
  tile_z integer NOT NULL
);

;
CREATE UNIQUE INDEX tile_coords ON maps (tile_x, tile_y, tile_z);

;
CREATE TABLE skills (
  skill_id INTEGER PRIMARY KEY NOT NULL,
  skill_name char(32) NOT NULL,
  skill_requirements char(32) NOT NULL,
  skill_data mediumtext NOT NULL,
  skill_prerequisites mediumtext NOT NULL
);

;
CREATE TABLE skillsets (
  character_id integer NOT NULL,
  skill_id integer NOT NULL,
  item_quantity integer NOT NULL,
  PRIMARY KEY (character_id, skill_id),
  FOREIGN KEY (character_id) REFERENCES characters(character_id),
  FOREIGN KEY (skill_id) REFERENCES skills(skill_id) ON DELETE CASCADE
);

;
CREATE INDEX skillsets_idx_character_id ON skillsets (character_id);

;
CREATE INDEX skillsets_idx_skill_id ON skillsets (skill_id);

;
CREATE TABLE tiles (
  tile_id INTEGER PRIMARY KEY NOT NULL,
  tile_name char(32) NOT NULL,
  colour_code char(6) NOT NULL,
  move_type char(10) NOT NULL
);

;

COMMIT;

