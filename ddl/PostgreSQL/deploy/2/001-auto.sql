-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Sat Dec 31 16:04:25 2016
-- 
;
--
-- Table: account_roles
--
CREATE TABLE "account_roles" (
  "account_id" integer NOT NULL,
  "role_id" integer NOT NULL,
  PRIMARY KEY ("account_id", "role_id")
);

;
--
-- Table: accounts
--
CREATE TABLE "accounts" (
  "account_id" serial NOT NULL,
  "email" character(128) NOT NULL,
  "password" text,
  PRIMARY KEY ("account_id"),
  CONSTRAINT "email" UNIQUE ("email")
);

;
--
-- Table: items
--
CREATE TABLE "items" (
  "item_id" serial NOT NULL,
  "item_name" character(32) NOT NULL,
  "item_type" character(32) NOT NULL,
  "item_data" text NOT NULL,
  PRIMARY KEY ("item_id")
);

;
--
-- Table: maps
--
CREATE TABLE "maps" (
  "tile_id" integer NOT NULL,
  "tile_x" integer NOT NULL,
  "tile_y" integer NOT NULL,
  "tile_z" integer NOT NULL,
  PRIMARY KEY ("tile_id"),
  CONSTRAINT "tile_coords" UNIQUE ("tile_x", "tile_y", "tile_z")
);

;
--
-- Table: roles
--
CREATE TABLE "roles" (
  "role_id" serial NOT NULL,
  "role" character(255) NOT NULL,
  "description" character(255),
  PRIMARY KEY ("role_id")
);

;
--
-- Table: sessions
--
CREATE TABLE "sessions" (
  "id" character(72) NOT NULL,
  "session_data" text,
  "expires" integer,
  PRIMARY KEY ("id")
);

;
--
-- Table: skills
--
CREATE TABLE "skills" (
  "skill_id" serial NOT NULL,
  "skill_name" character(32) NOT NULL,
  "skill_requirements" character(32) NOT NULL,
  "skill_data" text NOT NULL,
  "skill_prerequisites" text NOT NULL,
  PRIMARY KEY ("skill_id")
);

;
--
-- Table: tiles
--
CREATE TABLE "tiles" (
  "tile_id" serial NOT NULL,
  "tile_name" character(32) NOT NULL,
  "colour_code" character(6) NOT NULL,
  "move_type" character(10) NOT NULL,
  PRIMARY KEY ("tile_id")
);

;
--
-- Table: characters
--
CREATE TABLE "characters" (
  "character_id" serial NOT NULL,
  "character_name" character(32) NOT NULL,
  "account_id" integer NOT NULL,
  "character_health" integer NOT NULL,
  "character_exp" integer NOT NULL,
  "character_max_ap" integer NOT NULL,
  "character_ap" integer NOT NULL,
  PRIMARY KEY ("character_id"),
  CONSTRAINT "character_name" UNIQUE ("character_name")
);
CREATE INDEX "characters_idx_account_id" on "characters" ("account_id");

;
--
-- Table: descriptions
--
CREATE TABLE "descriptions" (
  "tile_id" serial NOT NULL,
  "tile_description" text NOT NULL,
  PRIMARY KEY ("tile_id")
);

;
--
-- Table: inventories
--
CREATE TABLE "inventories" (
  "character_id" integer NOT NULL,
  "item_id" integer NOT NULL,
  "item_quantity" integer NOT NULL,
  PRIMARY KEY ("character_id", "item_id")
);
CREATE INDEX "inventories_idx_character_id" on "inventories" ("character_id");
CREATE INDEX "inventories_idx_item_id" on "inventories" ("item_id");

;
--
-- Table: skillsets
--
CREATE TABLE "skillsets" (
  "character_id" integer NOT NULL,
  "skill_id" integer NOT NULL,
  "item_quantity" integer NOT NULL,
  PRIMARY KEY ("character_id", "skill_id")
);
CREATE INDEX "skillsets_idx_character_id" on "skillsets" ("character_id");
CREATE INDEX "skillsets_idx_skill_id" on "skillsets" ("skill_id");

;
--
-- Foreign Key Definitions
--

;
ALTER TABLE "characters" ADD CONSTRAINT "characters_fk_account_id" FOREIGN KEY ("account_id")
  REFERENCES "accounts" ("account_id") DEFERRABLE;

;
ALTER TABLE "descriptions" ADD CONSTRAINT "descriptions_fk_tile_id" FOREIGN KEY ("tile_id")
  REFERENCES "tiles" ("tile_id") ON DELETE CASCADE DEFERRABLE;

;
ALTER TABLE "inventories" ADD CONSTRAINT "inventories_fk_character_id" FOREIGN KEY ("character_id")
  REFERENCES "characters" ("character_id") ON DELETE CASCADE DEFERRABLE;

;
ALTER TABLE "inventories" ADD CONSTRAINT "inventories_fk_item_id" FOREIGN KEY ("item_id")
  REFERENCES "items" ("item_id") DEFERRABLE;

;
ALTER TABLE "skillsets" ADD CONSTRAINT "skillsets_fk_character_id" FOREIGN KEY ("character_id")
  REFERENCES "characters" ("character_id") DEFERRABLE;

;
ALTER TABLE "skillsets" ADD CONSTRAINT "skillsets_fk_skill_id" FOREIGN KEY ("skill_id")
  REFERENCES "skills" ("skill_id") ON DELETE CASCADE DEFERRABLE;

;
