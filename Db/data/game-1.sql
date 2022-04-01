insert into game
values (1, 'Rome Was Built In A Day', '2022-03-31');

insert into game_player
values (1, 1, 1, 'Mr. Ceasar', 'Player');
insert into game_player
values (2, 1, 1, 'Mr. Big Stuff', 'AI');

-- Turn 1: Settler builds city
insert into game_unit
values (1, 1, (select id from unit where name = 'Settlers'));
insert into game_city
values (1, 1, 1, 'Rome');
insert into game_log
values (1, 1, 1, 1, (select id from action where name = 'Build City'), 1);
insert into game_settle_action
values (1, 1, 1, 1, 1);

insert into game_log
values (2, 1, 1, 1, (select id from action where name = 'Build Building'), 2);

insert into game_log
values (3, 1, 1, 1, (select id from action where name = 'Research Tech'), 3);
insert into game_tech_action values (1, 3, (select id from tech where name = 'Alphabet'));

insert into game_unit
values (2, 1, (select id from unit where name = 'Warriors'));
insert into game_log
values (4, 1, 1, 1, (select id from action where name = 'Move Unit'), 4);
insert into game_movement_action
values (1, 4, 2, 1, 2);

--
-- insert into game_log values (1, 1, 1, (select action_id from action where name = 'Build New City'), 4);
-- insert into game_log values (1, 1, 1, (select action_id from action where name = 'Build New City'), 5);
-- insert into game_log values (1, 1, 1, (select action_id from action where name = 'Build New City'), 6);
-- insert into game_log values (1, 1, 1, (select action_id from action where name = 'Build New City'), 7);
-- insert into game_log values (1, 1, 1, (select action_id from action where name = 'Build New City'), 8);