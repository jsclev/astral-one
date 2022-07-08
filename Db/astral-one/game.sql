insert into game (name, theme_id, created_at)
    values ('Astral One', (select theme_id from theme where name = 'Astral One'), '2022-03-31');



insert into player (game_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'Astral One'), 1, 'Abe Lincoln', 'AI', 8);
insert into player (game_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'Astral One'), 2, 'Cleopatra', 'AI', 1);
insert into player (game_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'Astral One'), 3, 'Genghis Khan', 'AI', 1);
insert into player (game_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'Astral One'), 4, 'Caesar', 'AI', 1);
insert into player (game_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'Astral One'), 5, 'Isabella', 'AI', 1);
insert into player (game_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'Astral One'), 6, 'Henry VIII', 'AI', 1);
