-- Themes
insert into theme (name, description, source) values ('Stone to Space', 'Stone age to space age', 0);

-- Turns
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 1, -4000, '4000 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 2, -3980, '3980 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 3, -3960, '3960 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 4, -3940, '3940 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 5, -3920, '3920 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 6, -3900, '3900 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 7, -3880, '3880 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 8, -3860, '3860 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 9, -3850, '3850 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 10, -3840, '3840 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 11, -3830, '3830 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 12, -3820, '3820 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 13, -3810, '3810 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 14, -3800, '3800 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 15, -3790, '3790 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 16, -3780, '3780 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 17, -3770, '3770 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 18, -3760, '3760 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 19, -3750, '3750 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 20, -3740, '3740 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 21, -3730, '3730 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 22, -3720, '3720 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 23, -3710, '3710 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 24, -3700, '3700 BC');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Stone to Space'), 25, -3690, '3690 BC');

-- Unit types
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry1', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry2', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry3', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry4', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry5', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry6', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry7', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry8', 'Mechanized Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry1', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry2', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry3', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry4', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry5', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry6', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry7', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry8', 'Mechanized Tank', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery1', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery2', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery3', 'Cannon', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery4', 'Howitzer', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air1', 'Bomber', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air2', 'Fighter', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air3', 'Stealth Bomber', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air4', 'Stealth Fighter', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air5', 'Helicopter', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval1', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval2', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval3', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval4', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval5', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval6', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval7', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval8', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval9', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'NavalTransport', 'Transport', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Submarine', 'Submarine', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'AircraftCarrier', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'CityCreator', 'MCV', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Explorer', 'Basic Infantry', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Marine', 'Marine', 1);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'ParaTrooper', 'ParaTrooper', 1);

insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air1', 'Bomber', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air2', 'Fighter', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air3', 'Stealth Bomber', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air4', 'Stealth Fighter', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air5', 'Helicopter', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'AircraftCarrier', 'Carrier', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'AlpineTroop', 'Alpine Troop', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery1', 'Light Cannon', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery2', 'Cannon', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery3', 'Heavy Cannon', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery4', 'Howitzer', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry1', 'Tank 1', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry2', 'Tank 2', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry3', 'Tank 3', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry4', 'Tank 4', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry5', 'Tank 5', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry6', 'Tank 6', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry7', 'Tank 7', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry8', 'Mechanized Tank', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'CityCreator', 'MCV', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Crusader', 'Crusader', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Diplomat', 'Diplomat', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Engineer', 'Engineer', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Explorer', 'Explorer Drone', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Fanatic', 'Fanatic', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry1', 'Infantry 1', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry2', 'Infantry 2', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry3', 'Infantry 3', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry4', 'Infantry 4', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry5', 'Infantry 5', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry6', 'Infantry 6', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry7', 'Infantry 7', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry8', 'Mechanized Infantry', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Marine', 'Marine', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval1', 'Ship 1', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval2', 'Ship 2', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval3', 'Ship 3', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval4', 'Ship 4', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval5', 'Ship 5', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval6', 'Ship 6', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval7', 'Ship 7', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval8', 'Ship 8', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval9', 'Ship 9', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'NavalTransport', 'Transport', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'ParaTrooper', 'ParaTrooper', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Partisan', 'Partisan', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Spy', 'Spy', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Submarine', 'Submarine', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Trade1', 'Caravan', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Trade2', 'Freight', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'CruiseMissile', 'Cruise Missile', 2);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'NuclearMissile', 'Nuclear Missile', 2);

insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air1', 'Bomber', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air2', 'Fighter', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air3', 'Stealth Bomber', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air4', 'Stealth Fighter', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air5', 'Helicopter', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'AircraftCarrier', 'Carrier', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'AlpineTroop', 'Alpine Troop', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery1', 'Light Cannon', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery2', 'Cannon', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery3', 'Heavy Cannon', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery4', 'Howitzer', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry1', 'Tank 1', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry2', 'Tank 2', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry3', 'Tank 3', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry4', 'Tank 4', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry5', 'Tank 5', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry6', 'Tank 6', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry7', 'Tank 7', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry8', 'Mechanized Tank', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'CityCreator', 'MCV', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Crusader', 'Crusader', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Diplomat', 'Diplomat', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Engineer', 'Engineer', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Explorer', 'Explorer Drone', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Fanatic', 'Fanatic', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry1', 'Infantry 1', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry2', 'Infantry 2', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry3', 'Infantry 3', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry4', 'Infantry 4', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry5', 'Infantry 5', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry6', 'Infantry 6', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry7', 'Infantry 7', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry8', 'Mechanized Infantry', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Marine', 'Marine', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval1', 'Ship 1', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval2', 'Ship 2', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval3', 'Ship 3', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval4', 'Ship 4', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval5', 'Ship 5', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval6', 'Ship 6', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval7', 'Ship 7', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval8', 'Ship 8', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval9', 'Ship 9', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'NavalTransport', 'Transport', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'ParaTrooper', 'ParaTrooper', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Partisan', 'Partisan', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Spy', 'Spy', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Submarine', 'Submarine', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Trade1', 'Caravan', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Trade2', 'Freight', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'CruiseMissile', 'Cruise Missile', 3);
insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'NuclearMissile', 'Nuclear Missile', 3);

insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air1', 'Bomber', 3);

-- -- Building types
-- insert into building_type (name) values ('Airport');
-- insert into building_type (name) values ('Aqueduct');
-- insert into building_type (name) values ('Bank');
-- insert into building_type (name) values ('Barracks');
-- insert into building_type (name) values ('Capitalization');
-- insert into building_type (name) values ('Cathedral');
-- insert into building_type (name) values ('City Walls');
-- insert into building_type (name) values ('Coastal Fortress');
-- insert into building_type (name) values ('Colosseum');
-- insert into building_type (name) values ('Courthouse');
-- insert into building_type (name) values ('Factory');
-- insert into building_type (name) values ('Granary');
-- insert into building_type (name) values ('Harbor');
-- insert into building_type (name) values ('Hydro Plant');
-- insert into building_type (name) values ('Library');
-- insert into building_type (name) values ('Marketplace');
-- insert into building_type (name) values ('Mass Transit');
-- insert into building_type (name) values ('Mfg. Plant');
-- insert into building_type (name) values ('Nuclear Plant');
-- insert into building_type (name) values ('Offshore Platform');
-- insert into building_type (name) values ('Palace');
-- insert into building_type (name) values ('Police Station');
-- insert into building_type (name) values ('Port Facility');
-- insert into building_type (name) values ('Power Plant');
-- insert into building_type (name) values ('Recycling Center');
-- insert into building_type (name) values ('Research Lab');
-- insert into building_type (name) values ('SAM Missile Battery');
-- insert into building_type (name) values ('SDI Defense');
-- insert into building_type (name) values ('Sewer System');
-- insert into building_type (name) values ('Solar Plant');
-- insert into building_type (name) values ('SS Component');
-- insert into building_type (name) values ('SS Module');
-- insert into building_type (name) values ('SS Structural');
-- insert into building_type (name) values ('Stock Exchange');
-- insert into building_type (name) values ('Superhighways');
-- insert into building_type (name) values ('Supermarket');
-- insert into building_type (name) values ('Temple');
-- insert into building_type (name) values ('University');
--
-- -- Techs
-- insert into tech values (1, NULL, 'Alphabet', 'alphabet');
--
-- Terrain
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (21, 'Desert', 0.0, 1.0, 0.0, 1.0, 1.0);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (1, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (47, 'Glacier', 0.0, 1.0, 0.0, 3.0, 3.0);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (0, 'Grass', 2.0, 0.0, 0.0, 1.0, 1.0);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (19, 'Hills', 1.0, 0.0, 0.0, 2.0, 2.0);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (22, 'Jungle', 1.0, 0.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (17, 'Mountain', 0.0, 1.0, 0.0, 3.0, 3.0);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (24, 'Water', 1.0, 0.0, 2.0, 1.0, 1.0);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (49, 'Plains', 1.0, 1.0, 0.0, 1.0, 1.0);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (99, 'River', 0.0, 0.0, 1.0, 0.33, 0.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (23, 'Swamp', 1.0, 0.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (99, 'Tundra', 1.0, 0.0, 0.0, 1.0, 1.0);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (3, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (4, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (5, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (6, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (7, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (8, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (9, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (10, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (11, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (12, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (13, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (14, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (15, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (16, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (2, 'Forest', 1.0, 2.0, 0.0, 2.0, 1.5);
insert into terrain
    (tiled_id, terrain_type, food, shields, trade, movement_cost, defensive_bonus) values
    (18, 'Mountain', 0.0, 1.0, 0.0, 3.0, 3.0);
