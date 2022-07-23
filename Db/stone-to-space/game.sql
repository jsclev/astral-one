insert into game
    (name, theme_id, created_at) values
    ('New Rome', (select theme_id from theme where name = 'Stone to Space'), '2022-03-31');

insert into player (game_id, civilization_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'New Rome'),
            (select civilization_id from civilization where name = 'Americans'),
            0, 'Abe Lincoln', 'AI', 8);
insert into player (game_id, civilization_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'New Rome'),
            (select civilization_id from civilization where name = 'Egyptians'),
            1, 'Cleopatra', 'AI', 1);
insert into player (game_id, civilization_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'New Rome'),
            (select civilization_id from civilization where name = 'Mongols'),
            2, 'Genghis Khan', 'AI', 1);
insert into player (game_id, civilization_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'New Rome'),
            (select civilization_id from civilization where name = 'Romans'),
            3, 'Caesar', 'AI', 1);
insert into player (game_id, civilization_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'New Rome'),
            (select civilization_id from civilization where name = 'Spanish'),
            4, 'Isabella', 'AI', 1);
insert into player (game_id, civilization_id, ordinal, name, type, skill_level)
    values ((select game_id from game where name = 'New Rome'),
            (select civilization_id from civilization where name = 'English'),
            5, 'Henry VIII', 'AI', 1);
