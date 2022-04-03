DROP TABLE IF EXISTS tech_command;
DROP TABLE IF EXISTS settle_command;
DROP TABLE IF EXISTS building_command;
DROP TABLE IF EXISTS movement_command;
DROP TABLE IF EXISTS game_settings;
DROP TABLE IF EXISTS unit;
DROP TABLE IF EXISTS building;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS command;
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS tile;
DROP TABLE IF EXISTS tilemap;
DROP TABLE IF EXISTS game;
DROP TABLE IF EXISTS command_type;
DROP TABLE IF EXISTS building_type;
DROP TABLE IF EXISTS unit_type;
DROP TABLE IF EXISTS tech;
DROP TABLE IF EXISTS turn;

CREATE TABLE turn (
    id INTEGER PRIMARY KEY,
    ordinal INTEGER NOT NULL,
    year INTEGER NOT NULL,
    display_text TEXT NOT NULL
);

CREATE TABLE command_type (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE unit_type (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE building_type (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE tech (
    id INTEGER PRIMARY KEY,
    parent_id INTEGER,
    name TEXT NOT NULL,
    key TEXT NOT NULL
);

CREATE TABLE game (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TEXT
);

CREATE TABLE game_settings (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL
);

CREATE TABLE player (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL,
    ordinal INTEGER NOT NULL,
    name TEXT NOT NULL,
    type TEXT NOT NULL
);

CREATE TABLE tilemap (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL
);

CREATE TABLE tile (
    id INTEGER PRIMARY KEY,
    tilemap_id INTEGER NOT NULL,
    x INTEGER NOT NULL,
    y INTEGER NOT NULL,
    type TEXT NOT NULL,
    layer INTEGER NOT NULL
);

CREATE TABLE unit (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL,
    unit_type_id INTEGER NOT NULL
);

CREATE TABLE city (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL,
    player_id INTEGER NOT NULL,
    name TEXT NOT NULL
);

CREATE TABLE building (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL,
    player_id INTEGER NOT NULL,
    building_type_id INTEGER NOT NULL
);

CREATE TABLE command (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL,
    turn_id INTEGER NOT NULL,
    player_id INTEGER NOT NULL,
    command_type_id INTEGER NOT NULL,
    ordinal INTEGER NOT NULL
);

CREATE TABLE tech_command (
    id INTEGER PRIMARY KEY,
    command_id INTEGER NOT NULL,
    tech_id INTEGER NOT NULL,
    FOREIGN KEY (command_id) REFERENCES command (id),
    FOREIGN KEY (tech_id) REFERENCES tech (id)
);

CREATE TABLE movement_command (
    id INTEGER PRIMARY KEY,
    command_id INTEGER NOT NULL,
    unit_id INTEGER NOT NULL,
    from_position INTEGER NOT NULL,
    to_position INTEGER NOT NULL
);

CREATE TABLE settle_command (
    id INTEGER PRIMARY KEY,
    command_id INTEGER NOT NULL,
    unit_type_id INTEGER NOT NULL,
    city_id INTEGER NOT NULL
);

CREATE TABLE building_command (
    id INTEGER PRIMARY KEY,
    command_id INTEGER NOT NULL,
    building_id INTEGER NOT NULL
);