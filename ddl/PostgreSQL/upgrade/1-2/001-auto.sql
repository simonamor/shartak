-- Convert schema 'ddl/_source/deploy/1/001-auto.yml' to 'ddl/_source/deploy/2/001-auto.yml':;

;
BEGIN;

;
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
CREATE TABLE "descriptions" (
  "tile_id" serial NOT NULL,
  "tile_description" text NOT NULL,
  PRIMARY KEY ("tile_id")
);

;
CREATE TABLE "inventories" (
  "character_id" integer NOT NULL,
  "item_id" integer NOT NULL,
  "item_quantity" integer NOT NULL,
  PRIMARY KEY ("character_id", "item_id")
);
CREATE INDEX "inventories_idx_character_id" on "inventories" ("character_id");
CREATE INDEX "inventories_idx_item_id" on "inventories" ("item_id");

;
CREATE TABLE "items" (
  "item_id" serial NOT NULL,
  "item_name" character(32) NOT NULL,
  "item_type" character(32) NOT NULL,
  "item_data" text NOT NULL,
  PRIMARY KEY ("item_id")
);

;
CREATE TABLE "maps" (
  "tile_id" integer NOT NULL,
  "tile_x" integer NOT NULL,
  "tile_y" integer NOT NULL,
  "tile_z" integer NOT NULL,
  PRIMARY KEY ("tile_id"),
  CONSTRAINT "tile_coords" UNIQUE ("tile_x", "tile_y", "tile_z")
);

;
CREATE TABLE "skills" (
  "skill_id" serial NOT NULL,
  "skill_name" character(32) NOT NULL,
  "skill_requirements" character(32) NOT NULL,
  "skill_data" text NOT NULL,
  "skill_prerequisites" text NOT NULL,
  PRIMARY KEY ("skill_id")
);

;
CREATE TABLE "skillsets" (
  "character_id" integer NOT NULL,
  "skill_id" integer NOT NULL,
  "item_quantity" integer NOT NULL,
  PRIMARY KEY ("character_id", "skill_id")
);
CREATE INDEX "skillsets_idx_character_id" on "skillsets" ("character_id");
CREATE INDEX "skillsets_idx_skill_id" on "skillsets" ("skill_id");

;
CREATE TABLE "tiles" (
  "tile_id" serial NOT NULL,
  "tile_name" character(32) NOT NULL,
  "colour_code" character(6) NOT NULL,
  "move_type" character(10) NOT NULL,
  PRIMARY KEY ("tile_id")
);

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

COMMIT;

