-- Convert schema 'ddl/_source/deploy/4/001-auto.yml' to 'ddl/_source/deploy/5/001-auto.yml':;

;
BEGIN;

-- 4 basic land types

;

INSERT INTO tile_types (tile_type_id,name,colour_code,move_type) VALUES (1,'Grass','228B22', 'walking');
INSERT INTO tile_types (tile_type_id,name,colour_code,move_type) VALUES (2,'Forest','CD853F', 'walking');
INSERT INTO tile_types (tile_type_id,name,colour_code,move_type) VALUES (3,'Water','1E90FF', 'swimming');
INSERT INTO tile_types (tile_type_id,name,colour_code,move_type) VALUES (4,'Rocks','A9A9A9', 'climbing');

-- descriptions

;

INSERT INTO tile_type_descriptions (tile_type_id, description) VALUES (1, 'Green grassy area with the occasional small flower.');
INSERT INTO tile_type_descriptions (tile_type_id, description) VALUES (2, 'Trees fairly close together but not enough to block out all the sunlight.');
INSERT INTO tile_type_descriptions (tile_type_id, description) VALUES (3, 'Cool clear water with a few fish swimming below the surface.');
INSERT INTO tile_type_descriptions (tile_type_id, description) VALUES (4, 'Boulders and rocks piled high.');

-- and 5x5 grid of tiles

-- F F G G G
-- F F G G W
-- F G R G W
-- G G R G W
-- G G G G G

;

INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (-2,-2,0,2,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (-1,-2,0,2,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (0,-2,0,1,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (1,-2,0,1,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (2,-2,0,1,NULL);

INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (-2,-1,0,2,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (-1,-1,0,2,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (0,-1,0,1,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (1,-1,0,1,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (2,-1,0,3,NULL);

INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (-2,0,0,2,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (-1,0,0,1,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (0,0,0,4,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (1,0,0,1,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (2,0,0,3,NULL);

INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (-2,1,0,1,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (-1,1,0,1,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (0,1,0,4,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (1,1,0,1,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (2,1,0,3,NULL);

INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (-2,2,0,1,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (-1,2,0,1,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (0,2,0,1,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (1,2,0,1,NULL);
INSERT INTO maps (map_x,map_y,map_z,tile_type_id,name) VALUES (2,2,0,1,NULL);

;

COMMIT;

