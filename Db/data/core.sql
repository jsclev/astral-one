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
insert into unit_type (tiled_id, name, display_name) values (-1, 'Infantry1', 'Infantry 1');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Infantry2', 'Infantry 2');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Infantry3', 'Infantry 3');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Infantry4', 'Infantry 4');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Infantry5', 'Infantry 5');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Infantry6', 'Infantry 6');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Infantry7', 'Infantry 7');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Infantry8', 'Mechanized Infantry');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Cavalry1', 'Tank 1');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Cavalry2', 'Tank 2');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Cavalry3', 'Tank 3');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Cavalry4', 'Tank 4');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Cavalry5', 'Tank 5');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Cavalry6', 'Tank 6');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Cavalry7', 'Tank 7');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Cavalry8', 'Mechanized Tank');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Artillery1', 'Light Cannon');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Artillery2', 'Cannon');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Artillery3', 'Heavy Cannon');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Artillery4', 'Howitzer');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Air1', 'Bomber');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Air2', 'Fighter');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Air3', 'Stealth Bomber');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Air4', 'Stealth Fighter');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Air5', 'Helicopter');

insert into unit_type (tiled_id, name, display_name) values (-1, 'AircraftCarrier', 'Carrier');

insert into unit_type (tiled_id, name, display_name) values (-1, 'AlpineTroop', 'Alpine Troop');

insert into unit_type (tiled_id, name, display_name) values (-1, 'Trade1', 'Caravan');

insert into unit_type (tiled_id, name, display_name) values (-1, 'CityCreator', 'MCV');

insert into unit_type (tiled_id, name, display_name) values (-1, 'Diplomat', 'Diplomat');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Engineer', 'Engineer');

insert into unit_type (tiled_id, name, display_name) values (-1, 'Explorer', 'Explorer Drone');

insert into unit_type (tiled_id, name, display_name) values (-1, 'Fanatic', 'Fanatic');

insert into unit_type (tiled_id, name, display_name) values (-1, 'Trade2', 'Freight');

insert into unit_type (tiled_id, name, display_name) values (-1, 'Marine', 'Marine');

insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval1', 'Ship 1');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval2', 'Ship 2');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval3', 'Ship 3');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval4', 'Ship 4');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval5', 'Ship 5');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval6', 'Ship 6');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval7', 'Ship 7');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval8', 'Ship 8');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval9', 'Ship 9');
insert into unit_type (tiled_id, name, display_name) values (-1, 'NavalTransport', 'Transport');
insert into unit_type (tiled_id, name, display_name) values (-1, 'ParaTrooper', 'ParaTrooper');
insert into unit_type (tiled_id, name, display_name) values (-1, 'Submarine', 'Submarine');

-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Infantry1', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Infantry2', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Infantry3', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Infantry4', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Infantry5', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Infantry6', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Infantry7', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Infantry8', 'Mechanized Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Cavalry1', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Cavalry2', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Cavalry3', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Cavalry4', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Cavalry5', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Cavalry6', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Cavalry7', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Cavalry8', 'Mechanized Tank');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Artillery1', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Artillery2', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Artillery3', 'Cannon');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Artillery4', 'Howitzer');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Air1', 'Bomber');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Air2', 'Fighter');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Air3', 'Stealth Bomber');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Air4', 'Stealth Fighter');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Air5', 'Helicopter');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval1', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval2', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval3', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval4', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval5', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval6', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval7', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval8', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Naval9', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'NavalTransport', 'Transport');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Submarine', 'Submarine');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'AircraftCarrier', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'CityCreator', 'MCV');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Explorer', 'Basic Infantry');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'Marine', 'Marine');
-- insert into unit_type (tiled_id, name, display_name) values (-1, 'ParaTrooper', 'ParaTrooper');

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
insert into terrain values (1, 21, 'Desert', 0.0, 1.0, 0.0, 1.0, 1.0);
insert into terrain values (2, 1, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (3, 20, 'Glacier', 0.0, 0.0, 0.0, 2.0, 1.0);
insert into terrain values (4, 0, 'Grass', 2.0, 0.0, 0.0, 1.0, 1.0);
insert into terrain values (5, 19, 'Hills', 1.0, 0.0, 0.0, 2.0, 2.0);
insert into terrain values (6, 22, 'Jungle', 1.0, 0.0, 0.0, 2.0, 1.5);
insert into terrain values (7, 17, 'Mountain', 0.0, 1.0, 0.0, 3.0, 3.0);
insert into terrain values (8, 24, 'Water', 1.0, 0.0, 2.0, 1.0, 1.0);
insert into terrain values (9, 20, 'Plains', 1.0, 1.0, 0.0, 1.0, 1.0);
insert into terrain values (10, 20, 'River', 0.0, 0.0, 1.0, 0.33, 0.5);
insert into terrain values (11, 23, 'Swamp', 1.0, 0.0, 0.0, 2.0, 1.5);
insert into terrain values (12, 20, 'Tundra', 1.0, 0.0, 0.0, 1.0, 1.0);

insert into terrain values (15, 3, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (16, 4, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (17, 5, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (18, 6, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (19, 7, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (20, 8, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (21, 9, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (22, 10, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (23, 11, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (24, 12, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (25, 13, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (26, 14, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (27, 15, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (28, 16, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (29, 2, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);

insert into terrain values (30, 25, 'Hills', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (31, 26, 'Swamp', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (32, 27, 'Glacier', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain values (33, 18, 'Mountain', 0.0, 1.0, 0.0, 3.0, 3.0);
