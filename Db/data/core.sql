-- Turns
insert into turn values (1, 1, -4000, '4000 BC');
insert into turn values (2, 2, -3980, '3980 BC');
insert into turn values (3, 3, -3960, '3960 BC');
insert into turn values (4, 4, -3940, '3940 BC');
insert into turn values (5, 5, -3920, '3920 BC');
insert into turn values (6, 6, -3900, '3900 BC');
insert into turn values (7, 7, -3880, '3880 BC');
insert into turn values (8, 8, -3860, '3860 BC');

-- Action types
insert into command_type values (1, 'Move Unit');
insert into command_type values (2, 'Attack Unit');
insert into command_type values (3, 'Build City');
insert into command_type values (4, 'Build Building');
insert into command_type values (5, 'Research Tech');
insert into command_type values (6, 'Create Unit');

-- Unit types
insert into unit_type values (1, 'Settlers');
insert into unit_type values (2, 'Warriors');

-- Building types
insert into building_type values (1, 'Airport');
insert into building_type values (2, 'Aqueduct');
insert into building_type values (3, 'Bank');
insert into building_type values (4, 'Barracks');
insert into building_type values (5, 'Capitalization');
insert into building_type values (6, 'Cathedral');
insert into building_type values (7, 'City Walls');
insert into building_type values (8, 'Coastal Fortress');
insert into building_type values (9, 'Colosseum');
insert into building_type values (10, 'Courthouse');
insert into building_type values (11, 'Factory');
insert into building_type values (12, 'Granary');
insert into building_type values (13, 'Harbor');
insert into building_type values (14, 'Hydro Plant');
insert into building_type values (15, 'Library');
insert into building_type values (16, 'Marketplace');
insert into building_type values (17, 'Mass Transit');
insert into building_type values (18, 'Mfg. Plant');
insert into building_type values (19, 'Nuclear Plant');
insert into building_type values (20, 'Offshore Platform');
insert into building_type values (21, 'Palace');
insert into building_type values (22, 'Police Station');
insert into building_type values (23, 'Port Facility');
insert into building_type values (24, 'Power Plant');
insert into building_type values (25, 'Recycling Center');
insert into building_type values (26, 'Research Lab');
insert into building_type values (27, 'SAM Missile Battery');
insert into building_type values (28, 'SDI Defense');
insert into building_type values (29, 'Sewer System');
insert into building_type values (30, 'Solar Plant');
insert into building_type values (31, 'SS Component');
insert into building_type values (32, 'SS Module');
insert into building_type values (33, 'SS Structural');
insert into building_type values (34, 'Stock Exchange');
insert into building_type values (35, 'Superhighways');
insert into building_type values (36, 'Supermarket');
insert into building_type values (37, 'Temple');
insert into building_type values (38, 'University');

-- Techs
insert into tech values (1, NULL, 'Alphabet', 'alphabet');

-- Terrain
insert into terrain values (1, 'Desert', 0.0, 1.0, 0.0, 1.0, 1.0);
insert into terrain values (2, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (3, 'Glacier', 0.0, 0.0, 0.0, 2.0, 1.0);
insert into terrain values (4, 'Grassland', 2.0, 0.0, 0.0, 1.0, 1.0);
insert into terrain values (5, 'Hills', 1.0, 0.0, 0.0, 2.0, 2.0);
insert into terrain values (6, 'Jungle', 1.0, 0.0, 0.0, 2.0, 1.5);
insert into terrain values (7, 'Mountains', 0.0, 1.0, 0.0, 3.0, 3.0);
insert into terrain values (8, 'Ocean', 1.0, 0.0, 2.0, 1.0, 1.0);
insert into terrain values (9, 'Plains', 1.0, 1.0, 0.0, 1.0, 1.0);
insert into terrain values (10, 'River', 0.0, 0.0, 1.0, 0.33, 0.5);
insert into terrain values (11, 'Swamp', 1.0, 0.0, 0.0, 2.0, 1.5);
insert into terrain values (12, 'Tundra', 1.0, 0.0, 0.0, 1.0, 1.0);
