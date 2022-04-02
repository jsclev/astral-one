DROP TABLE IF EXISTS game_tech_action;
DROP TABLE IF EXISTS game_settle_action;
DROP TABLE IF EXISTS game_building_action;
DROP TABLE IF EXISTS game_movement_action;
DROP TABLE IF EXISTS game_settings;
DROP TABLE IF EXISTS game_action;
DROP TABLE IF EXISTS game_unit;
DROP TABLE IF EXISTS game_building;
DROP TABLE IF EXISTS game_city;
DROP TABLE IF EXISTS game_position;
DROP TABLE IF EXISTS game_player;
DROP TABLE IF EXISTS game;
DROP TABLE IF EXISTS action;
DROP TABLE IF EXISTS building;
DROP TABLE IF EXISTS unit;
DROP TABLE IF EXISTS tech;
DROP TABLE IF EXISTS turn;

CREATE TABLE turn (
    id INTEGER PRIMARY KEY,
    ordinal INTEGER NOT NULL,
    year INTEGER NOT NULL,
    display_text TEXT NOT NULL
);

CREATE TABLE action (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE unit (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE building (
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

CREATE TABLE game_player (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL,
    ordinal INTEGER NOT NULL,
    name TEXT NOT NULL,
    type TEXT NOT NULL
);

CREATE TABLE game_unit (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL,
    unit_id INTEGER NOT NULL
);

CREATE TABLE game_city (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL,
    game_player_id INTEGER NOT NULL,
    city TEXT NOT NULL
);

CREATE TABLE game_building (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL,
    game_player_id INTEGER NOT NULL,
    building_id INTEGER NOT NULL
);

CREATE TABLE game_action (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL,
    turn_id INTEGER NOT NULL,
    game_player_id INTEGER NOT NULL,
    action_id INTEGER NOT NULL,
    ordinal INTEGER NOT NULL
);

CREATE TABLE game_position (
    id INTEGER PRIMARY KEY,
    game_id INTEGER NOT NULL,
    row INTEGER NOT NULL,
    col INTEGER NOT NULL
);

CREATE TABLE game_tech_action (
    id INTEGER PRIMARY KEY,
    game_action_id INTEGER NOT NULL,
    tech_id INTEGER NOT NULL,
    FOREIGN KEY (game_action_id) REFERENCES game_action (id),
    FOREIGN KEY (tech_id) REFERENCES tech (id)
);

CREATE TABLE game_movement_action (
    id INTEGER PRIMARY KEY,
    game_action_id INTEGER NOT NULL,
    game_unit_id INTEGER NOT NULL,
    from_position INTEGER NOT NULL,
    to_position INTEGER NOT NULL
);

CREATE TABLE game_settle_action (
    id INTEGER PRIMARY KEY,
    game_action_id INTEGER NOT NULL,
    game_unit_id INTEGER NOT NULL,
    game_city_id INTEGER NOT NULL
);

CREATE TABLE game_building_action (
    id INTEGER PRIMARY KEY,
    game_action_id INTEGER NOT NULL,
    game_building_id INTEGER NOT NULL
);
