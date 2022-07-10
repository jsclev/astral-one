-- Themes
insert into theme (name, description, source) values ('Astral One', 'Sci-fi theme', 0);

-- Turns
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 1, 2079, '2079');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 2, 2080, '2080');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 3, 2081, '2081');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 4, 2082, '2082');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 5, 2083, '2083');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 6, 2084, '2084');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 7, 2085, '2085');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 8, 2086, '2086');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 9, 2087, '2087');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 10, 2088, '2088');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 11, 2089, '2089');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 12, 2090, '2090');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 13, 2091, '2091');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 14, 2092, '2092');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 15, 2093, '2093');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 16, 2094, '2094');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 17, 2095, '2095');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 18, 2096, '2096');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 19, 2097, '2097');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 20, 2098, '2098');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 21, 2099, '2099');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 22, 2100, '2100');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 23, 2101, '2101');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 24, 2102, '2102');
insert into turn (theme_id, ordinal, year, display_text) values (
    (select theme_id from theme where name ='Astral One'), 25, 2103, '2103');

-- Unit types
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry1', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry2', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry3', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry4', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry5', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry6', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry7', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry8', 'Mechanized Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry1', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry2', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry3', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry4', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry5', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry6', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry7', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry8', 'Mechanized Tank', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery1', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery2', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery3', 'Cannon', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery4', 'Howitzer', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air1', 'Bomber', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air2', 'Fighter', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air3', 'Stealth Bomber', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air4', 'Stealth Fighter', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air5', 'Helicopter', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval1', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval2', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval3', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval4', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval5', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval6', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval7', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval8', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval9', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'NavalTransport', 'Transport', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Submarine', 'Submarine', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'AircraftCarrier', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'CityCreator', 'MCV', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Explorer', 'Basic Infantry', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Marine', 'Marine', 1);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'ParaTrooper', 'ParaTrooper', 1);
--
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air1', 'Bomber', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air2', 'Fighter', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air3', 'Stealth Bomber', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air4', 'Stealth Fighter', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air5', 'Helicopter', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'AircraftCarrier', 'Carrier', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'AlpineTroop', 'Alpine Troop', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery1', 'Light Cannon', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery2', 'Cannon', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery3', 'Heavy Cannon', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery4', 'Howitzer', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry1', 'Tank 1', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry2', 'Tank 2', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry3', 'Tank 3', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry4', 'Tank 4', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry5', 'Tank 5', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry6', 'Tank 6', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry7', 'Tank 7', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry8', 'Mechanized Tank', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'CityCreator', 'MCV', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Crusader', 'Crusader', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Diplomat', 'Diplomat', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Engineer', 'Engineer', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Explorer', 'Explorer Drone', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Fanatic', 'Fanatic', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry1', 'Infantry 1', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry2', 'Infantry 2', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry3', 'Infantry 3', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry4', 'Infantry 4', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry5', 'Infantry 5', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry6', 'Infantry 6', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry7', 'Infantry 7', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry8', 'Mechanized Infantry', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Marine', 'Marine', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval1', 'Ship 1', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval2', 'Ship 2', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval3', 'Ship 3', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval4', 'Ship 4', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval5', 'Ship 5', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval6', 'Ship 6', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval7', 'Ship 7', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval8', 'Ship 8', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval9', 'Ship 9', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'NavalTransport', 'Transport', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'ParaTrooper', 'ParaTrooper', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Partisan', 'Partisan', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Spy', 'Spy', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Submarine', 'Submarine', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Trade1', 'Caravan', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Trade2', 'Freight', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'CruiseMissile', 'Cruise Missile', 2);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'NuclearMissile', 'Nuclear Missile', 2);
--
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air1', 'Bomber', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air2', 'Fighter', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air3', 'Stealth Bomber', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air4', 'Stealth Fighter', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air5', 'Helicopter', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'AircraftCarrier', 'Carrier', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'AlpineTroop', 'Alpine Troop', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery1', 'Light Cannon', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery2', 'Cannon', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery3', 'Heavy Cannon', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Artillery4', 'Howitzer', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry1', 'Tank 1', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry2', 'Tank 2', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry3', 'Tank 3', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry4', 'Tank 4', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry5', 'Tank 5', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry6', 'Tank 6', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry7', 'Tank 7', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Cavalry8', 'Mechanized Tank', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'CityCreator', 'MCV', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Crusader', 'Crusader', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Diplomat', 'Diplomat', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Engineer', 'Engineer', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Explorer', 'Explorer Drone', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Fanatic', 'Fanatic', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry1', 'Infantry 1', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry2', 'Infantry 2', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry3', 'Infantry 3', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry4', 'Infantry 4', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry5', 'Infantry 5', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry6', 'Infantry 6', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry7', 'Infantry 7', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Infantry8', 'Mechanized Infantry', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Marine', 'Marine', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval1', 'Ship 1', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval2', 'Ship 2', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval3', 'Ship 3', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval4', 'Ship 4', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval5', 'Ship 5', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval6', 'Ship 6', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval7', 'Ship 7', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval8', 'Ship 8', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Naval9', 'Ship 9', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'NavalTransport', 'Transport', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'ParaTrooper', 'ParaTrooper', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Partisan', 'Partisan', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Spy', 'Spy', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Submarine', 'Submarine', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Trade1', 'Caravan', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Trade2', 'Freight', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'CruiseMissile', 'Cruise Missile', 3);
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'NuclearMissile', 'Nuclear Missile', 3);
--
-- insert into unit_type (tiled_id, name, display_name, theme_id) values (-1, 'Air1', 'Bomber', 3);

-- Building types
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Airport');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Aqueduct');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Bank');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Barracks');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Capitalization');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Cathedral');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'City Walls');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Coastal Fortress');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Colosseum');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Courthouse');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Factory');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Granary');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Harbor');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Hydro Plant');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Library');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Marketplace');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Mass Transit');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Mfg. Plant');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Nuclear Plant');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Offshore Platform');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Palace');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Police Station');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Port Facility');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Power Plant');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Recycling Center');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Research Lab');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'SAM Missile Battery');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'SDI Defense');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Sewer System');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Solar Plant');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'SS Component');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'SS Module');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'SS Structural');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Stock Exchange');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Superhighways');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Supermarket');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'Temple');
insert into building_type (theme_id, name) values ((select theme_id from theme where name = 'Astral One'), 'University');

-- -- Techs
-- insert into tech values (1, NULL, 'Alphabet', 'alphabet');
--
-- -- Terrain
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
