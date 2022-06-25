insert into game (name, theme_id, created_at) values ('New Earth', (select theme_id from theme where name = 'Astral One'), '2022-03-31');
