insert into game values (1, 'Rome Was Built In A Day', '2022-03-31');

insert into tile values (1, 1, 1, 30, 30, 1, FALSE);
insert into tile values (2, 1, 1, 31, 31, 1, FALSE);
insert into tile values (3, 1, 1, 32, 32, 1, FALSE);
insert into tile values (4, 1, 1, 39, 19, 1, FALSE);
insert into tile values (5, 1, 1, 39, 20, 1, FALSE);
insert into tile values (6, 1, 1, 39, 21, 1, FALSE);
insert into tile values (7, 1, 1, 39, 22, 1, FALSE);
insert into tile values (8, 1, 1, 39, 23, 1, FALSE);
insert into tile values (9, 1, 1, 39, 24, 1, FALSE);
insert into tile values (10, 1, 1, 39, 25, 1, FALSE);
insert into tile values (11, 1, 1, 39, 26, 1, FALSE);
insert into tile values (12, 1, 1, 39, 27, 1, FALSE);
insert into tile values (13, 1, 1, 39, 28, 1, FALSE);
insert into tile values (14, 1, 1, 39, 29, 1, FALSE);
insert into tile values (15, 1, 1, 39, 30, 1, FALSE);
insert into tile values (16, 1, 1, 32, 30, 1, FALSE);
insert into tile values (17, 1, 1, 33, 30, 1, FALSE);
insert into tile values (18, 1, 1, 34, 30, 1, FALSE);
insert into tile values (19, 1, 1, 35, 30, 1, FALSE);
insert into tile values (20, 1, 1, 36, 30, 1, FALSE);
insert into tile values (21, 1, 1, 31, 34, 1, FALSE);
insert into tile values (22, 1, 1, 31, 36, 1, FALSE);
insert into tile values (23, 1, 1, 31, 39, 1, FALSE);
insert into tile values (24, 1, 1, 31, 42, 1, FALSE);
insert into tile values (25, 1, 1, 31, 39, 1, FALSE);
insert into tile values (26, 1, 1, 31, 25, 1, FALSE);
insert into tile values (27, 1, 1, 31, 21, 1, FALSE);
insert into tile values (28, 1, 1, 31, 22, 1, FALSE);
insert into tile values (29, 1, 1, 32, 23, 1, FALSE);
insert into tile values (30, 1, 1, 33, 24, 1, FALSE);
insert into tile values (31, 1, 1, 34, 25, 1, FALSE);
insert into tile values (32, 1, 1, 35, 26, 1, FALSE);
insert into tile values (33, 1, 1, 36, 29, 1, FALSE);
insert into tile values (34, 1, 1, 37, 29, 1, FALSE);
insert into tile values (35, 1, 1, 38, 29, 1, FALSE);
insert into tile values (36, 1, 1, 39, 29, 1, FALSE);
insert into tile values (37, 1, 1, 29, 29, 1, FALSE);
insert into tile values (38, 1, 1, 27, 27, 1, FALSE);

insert into player values (1, 1, 1, 'Mr. Caesar', 'Human');
insert into player values (2, 1, 1, 'Mr. Big Stuff', 'AI');

-- Turn 1: Build city
insert into city values (1, 1, 1, 37, 'Rome');
insert into command values (1, 1, 1, 1, (select command_type_id from command_type where name = 'Build City'), 1);
insert into settle_command values (1, 1, 1);

-- Turn 1: Create barracks
insert into building values (1, 1, 1, (select building_type_id from building_type where name = 'Barracks'));
insert into command values (2, 1, 1, 1, (select command_type_id from command_type where name = 'Build Building'), 2);
insert into building_command values (2, 1);

-- Turn 1: Research Alphabet
insert into command values (3, 1, 1, 1, (select command_type_id from command_type where name = 'Research Tech'), 3);
insert into tech_command values (3, (select tech_id from tech where name = 'Alphabet'));

-- Turn 1: Move Warriors
insert into command values (4, 1, 1, 1, (select command_type_id from command_type where name = 'Move Unit'), 4);
insert into move_command values (4, 2, 1, 2);

insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'City Creator'), 1);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval1'), 2);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval2'), 3);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval3'), 4);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval4'), 5);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval5'), 6);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval6'), 7);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval7'), 8);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval8'), 9);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Naval9'), 10);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Air1'), 11);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Air2'), 12);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Air3'), 13);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Air4'), 14);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Air5'), 15);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Artillery1'), 16);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Artillery2'), 17);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Artillery3'), 18);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Artillery4'), 19);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Infantry1'), 20);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Infantry2'), 21);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Infantry3'), 22);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Infantry4'), 23);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Infantry5'), 24);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Infantry6'), 25);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Infantry7'), 26);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Infantry8'), 27);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Cavalry1'), 28);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Cavalry2'), 29);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Cavalry3'), 30);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Cavalry4'), 31);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Cavalry5'), 32);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Cavalry6'), 33);
-- insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Cavalry7'), 34);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Cavalry8'), 35);
insert into unit (game_id, player_id, unit_type_id, tile_id) values (1, 1, (select unit_type_id from unit_type where name = 'Engineer'), 38);
