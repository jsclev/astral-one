DROP TABLE IF EXISTS skin;
DROP TABLE IF EXISTS city_name;
DROP TABLE IF EXISTS civilization;
DROP TABLE IF EXISTS tile;
DROP TABLE IF EXISTS create_city_command;
DROP TABLE IF EXISTS build_building_command;
DROP TABLE IF EXISTS move_unit_command;
DROP TABLE IF EXISTS next_turn_command;
DROP TABLE IF EXISTS game_setting;
DROP TABLE IF EXISTS unit;
DROP TABLE IF EXISTS building;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS command;
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS terrain;
DROP TABLE IF EXISTS tilemap;
DROP TABLE IF EXISTS game;
DROP TABLE IF EXISTS building_type;
DROP TABLE IF EXISTS unit_type;
DROP TABLE IF EXISTS advance;
DROP TABLE IF EXISTS turn;

CREATE TABLE language (
    language_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE civilization (
    civilization_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    language_id INTEGER NOT NULL,
    color TEXT NOT NULL,
    FOREIGN KEY (language_id) REFERENCES language (language_id)
);

CREATE UNIQUE INDEX civilization_idx1 ON civilization (name);

CREATE TABLE city_name (
    city_name_id INTEGER PRIMARY KEY,
    civilization_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    ordinal INTEGER NOT NULL CHECK (ordinal >= 0)
);

CREATE UNIQUE INDEX city_name_idx1 ON city_name (civilization_id, ordinal);

CREATE TABLE theme (
    theme_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    author TEXT,
    source INTEGER NOT NULL
);

CREATE UNIQUE INDEX theme_idx1 ON theme (name);

CREATE TABLE skin (
    skin_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE UNIQUE INDEX skin_idx1 ON skin (name);

CREATE TABLE turn (
    turn_id INTEGER PRIMARY KEY,
    theme_id INTEGER NOT NULL,
    ordinal INTEGER NOT NULL,
    year INTEGER NOT NULL,
    display_text TEXT NOT NULL,
    FOREIGN KEY (theme_id) REFERENCES theme (theme_id)
);

CREATE UNIQUE INDEX turn_idx1 ON turn (theme_id, ordinal);

CREATE TABLE unit_type (
    unit_type_id INTEGER PRIMARY KEY,
    tiled_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    display_name TEXT NOT NULL,
    theme_id INTEGER NOT NULL,
    skin_id INTEGER NOT NULL,
    notes TEXT,
    FOREIGN KEY (theme_id) REFERENCES theme (theme_id),
    FOREIGN KEY (skin_id) REFERENCES skin (skin_id)
);

CREATE TABLE building_type (
    building_type_id INTEGER PRIMARY KEY,
    theme_id INTEGER NOT NULL,
    core_name CHECK(core_name IN ('Airport',
                                  'Aqueduct',
                                  'Bank',
                                  'Barracks',
                                  'Capitalization',
                                  'Cathedral',
                                  'City Walls',
                                  'Coastal Fortress',
                                  'Colosseum',
                                  'Courthouse',
                                  'Factory',
                                  'Granary',
                                  'Harbor',
                                  'Hydro Plant',
                                  'Library',
                                  'Marketplace',
                                  'Mass Transit',
                                  'Manufacturing Plant',
                                  'Nuclear Plant',
                                  'Offshore Platform',
                                  'Palace',
                                  'Police Station',
                                  'Port Facility',
                                  'Power Plant',
                                  'Recycling Center',
                                  'Research Lab',
                                  'SAM Missile Battery',
                                  'SDI Defense',
                                  'Sewer System',
                                  'Solar Plant',
                                  'SS Component',
                                  'SS Module',
                                  'SS Structural',
                                  'Stock Exchange',
                                  'Superhighways',
                                  'Supermarket',
                                  'Temple',
                                  'University')) NOT NULL,
    name TEXT NOT NULL,
    FOREIGN KEY (theme_id) REFERENCES theme (theme_id)
);

CREATE UNIQUE INDEX building_type_idx1 ON building_type (theme_id, name);

CREATE TABLE advance (
    advance_id INTEGER PRIMARY KEY,
    parent_advance_id INTEGER,
    theme_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    FOREIGN KEY (parent_advance_id) REFERENCES advance (advance_id),
    FOREIGN KEY (theme_id) REFERENCES theme (theme_id)
);

CREATE UNIQUE INDEX advance_idx1 ON advance (theme_id, name);

CREATE TABLE game (
    game_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    theme_id INTEGER NOT NULL,
    created_at TEXT
);

CREATE TABLE game_setting (
    game_setting_id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL,
    FOREIGN KEY (game_id) REFERENCES game (game_id)
);

CREATE TABLE player (
    player_id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL,
    civilization_id INTEGER NOT NULL,
    ordinal INTEGER NOT NULL CHECK (ordinal IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)),
    name TEXT NOT NULL,
    type TEXT NOT NULL CHECK(type IN ('Human', 'AI')),
    skill_level INTEGER NOT NULL CHECK (skill_level IN (0, 1, 2, 3, 4, 5, 6, 7, 8)),
    FOREIGN KEY (game_id) REFERENCES game (game_id),
    FOREIGN KEY (civilization_id) REFERENCES civilization (civilization_id)
);

CREATE UNIQUE INDEX player_idx1 ON player (game_id, ordinal);
CREATE UNIQUE INDEX player_idx2 ON player (game_id, name);

CREATE TABLE tilemap (
    tilemap_id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL
);

CREATE TABLE terrain (
    terrain_id INTEGER PRIMARY KEY,
    tiled_id INTEGER NOT NULL,
    terrain_type TEXT CHECK(terrain_type IN ('Desert',
                                             'Forest',
                                             'Glacier',
                                             'Grass',
                                             'Hills',
                                             'Jungle',
                                             'Mountain',
                                             'Water',
                                             'Plains',
                                             'River',
                                             'Swamp',
                                             'Tundra')) NOT NULL,
    food REAL NOT NULL,
    shields REAL NOT NULL,
    trade REAL NOT NULL,
    movement_cost REAL NOT NULL,
    defensive_bonus REAL NOT NULL
);

CREATE TABLE tile (
    tile_id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL,
    map_id INTEGER NOT NULL,
    row INTEGER NOT NULL,
    col INTEGER NOT NULL,
    terrain_id INTEGER NOT NULL,
    has_river INTEGER NOT NULL,
    special_resource TEXT,
    FOREIGN KEY (game_id) REFERENCES game (game_id),
    FOREIGN KEY (terrain_id) REFERENCES terrain (terrain_id)
);

CREATE TABLE unit (
    unit_id INTEGER PRIMARY KEY,
    player_id INTEGER NOT NULL,
    unit_type_id INTEGER NOT NULL,
    tile_id INTEGER NOT NULL,
    skin_id INTEGER NOT NULL,
    FOREIGN KEY (player_id) REFERENCES player (player_id),
    -- FIXME Need to implement the unit type foreign key
--     FOREIGN KEY (unit_type_id) REFERENCES unit_type (unit_type_id)
    FOREIGN KEY (tile_id) REFERENCES tile (tile_id),
    FOREIGN KEY (skin_id) REFERENCES skin (skin_id)
);

CREATE TABLE city (
    city_id INTEGER PRIMARY KEY,
    player_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    tile_id INTEGER NOT NULL,
    FOREIGN KEY (player_id) REFERENCES player (player_id),
    FOREIGN KEY (tile_id) REFERENCES tile (tile_id)
);

CREATE TABLE building (
    building_id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL,
    player_id INTEGER NOT NULL,
    building_type_id INTEGER NOT NULL,
    FOREIGN KEY (game_id) REFERENCES game (game_id)
);

-------------------------------------------------------------------------------
-- Command tables
-------------------------------------------------------------------------------
CREATE TABLE command (
    command_id INTEGER PRIMARY KEY,
    player_id INTEGER NOT NULL,
    turn_id INTEGER NOT NULL,
    ordinal INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (player_id) REFERENCES player (player_id),
    FOREIGN KEY (turn_id) REFERENCES turn (turn_id)
);

CREATE UNIQUE INDEX command_idx1 ON command (player_id, turn_id, ordinal);

CREATE TABLE next_turn_command (
    command_id INTEGER NOT NULL,
    turn_id INTEGER NOT NULL,
    FOREIGN KEY (command_id) REFERENCES command (command_id),
    FOREIGN KEY (turn_id) REFERENCES turn (turn_id)
);

CREATE TABLE research_advance_command (
    command_id INTEGER NOT NULL,
    advance_id INTEGER NOT NULL,
    FOREIGN KEY (command_id) REFERENCES command (command_id),
    FOREIGN KEY (advance_id) REFERENCES advance (advance_id)
);

CREATE TABLE move_unit_command (
    command_id INTEGER NOT NULL,
    unit_id INTEGER NOT NULL,
    from_row INTEGER NOT NULL,
    from_col INTEGER NOT NULL,
    to_row INTEGER NOT NULL,
    to_col INTEGER NOT NULL,
    FOREIGN KEY (command_id) REFERENCES command (command_id),
    FOREIGN KEY (unit_id) REFERENCES unit (unit_id)
);

CREATE TABLE create_city_command (
    command_id INTEGER NOT NULL,
    unit_id INTEGER NOT NULL,
    city_id INTEGER NOT NULL,
    FOREIGN KEY (command_id) REFERENCES command (command_id),
    FOREIGN KEY (unit_id) REFERENCES unit (unit_id),
    FOREIGN KEY (city_id) REFERENCES city (city_id)
);

CREATE TABLE create_unit_command (
    command_id INTEGER NOT NULL,
    unit_id INTEGER NOT NULL,
    tile_id INTEGER NOT NULL,
    city_id INTEGER,
    FOREIGN KEY (command_id) REFERENCES command (command_id),
    FOREIGN KEY (unit_id) REFERENCES unit (unit_id),
    FOREIGN KEY (tile_id) REFERENCES tile (tile_id),
    FOREIGN KEY (city_id) REFERENCES city (city_id)
);

CREATE TABLE build_building_command (
    command_id INTEGER NOT NULL,
    city_id INTEGER NOT NULL,
    building_type_id INTEGER NOT NULL,
    FOREIGN KEY (city_id) REFERENCES city (city_id),
    FOREIGN KEY (building_type_id) REFERENCES building_type (building_type_id)
);
