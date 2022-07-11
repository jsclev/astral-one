insert into game
    (name, theme_id, created_at) values
    ('New Rome', (select theme_id from theme where name = 'Stone to Space'), '2022-03-31');

insert into player (game_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'New Rome'), 1, 'Abe Lincoln', 'AI', 8);
insert into player (game_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'New Rome'), 2, 'Cleopatra', 'AI', 1);
insert into player (game_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'New Rome'), 3, 'Genghis Khan', 'AI', 1);
insert into player (game_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'New Rome'), 4, 'Caesar', 'AI', 1);
insert into player (game_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'New Rome'), 5, 'Isabella', 'AI', 1);
insert into player (game_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'New Rome'), 6, 'Henry VIII', 'AI', 1);

-- Tiles 1 - 10
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 50, 50, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 51, 51, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 52, 52, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 19, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 40, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 41, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 42, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 45, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 44, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 45, 1, FALSE);
--
-- -- Tiles 11 - 20
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 46, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 47, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 48, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 49, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 50, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 52, 50, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 55, 50, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 54, 50, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 55, 50, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 56, 50, 1, FALSE);
--
-- -- Tiles 21 - 30
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 51, 54, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 51, 56, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 51, 59, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 51, 42, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 51, 59, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 51, 45, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 51, 41, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 51, 42, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 52, 45, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 55, 44, 1, FALSE);
--
-- -- Tiles 31 - 40
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 54, 45, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 55, 46, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 56, 49, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 57, 49, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 58, 49, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 49, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 49, 49, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 47, 47, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 46, 46, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 55, 55, 1, FALSE);
--
-- -- Tiles 41 - 50
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 56, 56, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 56, 57, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 56, 58, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 56, 59, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 56, 60, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 56, 61, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 57, 56, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 57, 57, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 57, 58, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 57, 59, 1, FALSE);
--
-- -- Tiles 51 - 60
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 58, 56, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 58, 57, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 58, 58, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 58, 59, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 58, 60, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 61, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 62, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 63, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 64, 1, FALSE);
-- insert into tile (game_id, map_id, row, col, terrain_id, has_river) values (1, 1, 59, 65, 1, FALSE);
--
-- -- Turn 1: Build city
-- insert into city values (1, 1, 1, 57, 'Rome');
-- insert into command values (1, 1, 1, 1, 1);
-- insert into create_city_command values (1, 1, 1);
--
-- -- Turn 1: Create barracks
-- insert into building values (1, 1, 1, (select building_type_id from building_type where name = 'Barracks'));
-- insert into command values (2, 1, 1, 1, 2);
-- insert into building_command values (2, 1);
--
-- -- Turn 1: Research Alphabet
-- insert into command values (3, 1, 1, 1, 3);
-- insert into research_advance_command values (3, (select advance_id from advance where name = 'Alphabet'));
--
-- -- Turn 1: Move Warriors
-- insert into command values (4, 1, 1, 1, 4);
-- insert into move_unit_command values (4, 2, 1, 2);

-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'CityCreator' and theme_id = 2), 1);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval1' and theme_id = 2), 2);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval2' and theme_id = 2), 3);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval3' and theme_id = 2), 4);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval4' and theme_id = 2), 5);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval5' and theme_id = 2), 6);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval6' and theme_id = 2), 7);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval7' and theme_id = 2), 8);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval8' and theme_id = 2), 9);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval9' and theme_id = 2), 10);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Air1' and theme_id = 2), 11);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Air2' and theme_id = 2), 12);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Air3' and theme_id = 2), 13);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Air4' and theme_id = 2), 14);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Air5' and theme_id = 2), 15);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Artillery1' and theme_id = 2), 16);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Artillery2' and theme_id = 2), 17);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Artillery3' and theme_id = 2), 18);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Artillery4' and theme_id = 2), 19);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Infantry1' and theme_id = 2), 20);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Infantry2' and theme_id = 2), 21);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Infantry3' and theme_id = 2), 22);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Infantry4' and theme_id = 2), 23);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Infantry5' and theme_id = 2), 24);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Infantry6' and theme_id = 2), 25);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Infantry7' and theme_id = 2), 26);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Infantry8' and theme_id = 2), 27);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Cavalry1' and theme_id = 2), 28);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Cavalry2' and theme_id = 2), 29);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Cavalry3' and theme_id = 2), 30);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Cavalry4' and theme_id = 2), 31);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Cavalry5' and theme_id = 2), 32);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Cavalry6' and theme_id = 2), 33);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Cavalry8' and theme_id = 2), 35);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Engineer' and theme_id = 2), 38);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Marine' and theme_id = 2), 39);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'ParaTrooper' and theme_id = 2), 40);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'AlpineTroop' and theme_id = 2), 41);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Trade1' and theme_id = 2), 42);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Trade2' and theme_id = 2), 43);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Fanatic' and theme_id = 2), 44);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Diplomat' and theme_id = 2), 45);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Spy' and theme_id = 2), 46);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Crusader' and theme_id = 2),  47);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Partisan' and theme_id = 2),  48);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'CruiseMissile' and theme_id = 2),  49);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'NuclearMissile' and theme_id = 2),  50);
