insert into game values (1, 'Rome Was Built In A Day', '2022-03-31');

insert into player values (1, 1, 1, 'Mr. Ceasar', 'Human');
insert into player values (2, 1, 1, 'Mr. Big Stuff', 'AI');

-- Turn 1: Build city
insert into unit values (1, 1, (select id from unit_type where name = 'Settlers'));
insert into city values (1, 1, 1, 'Rome');
insert into command values (1, 1, 1, 1, (select id from command_type where name = 'Build City'), 1);
insert into settle_command values (1, 1, 1, 1);

-- Turn 1: Create barracks
insert into building values (1, 1, 1, (select id from building_type where name = 'Barracks'));
insert into command values (2, 1, 1, 1, (select id from command_type where name = 'Build Building'), 2);
insert into building_command values (1, 2, 1);

-- Turn 1: Research Alphabet
insert into command values (3, 1, 1, 1, (select id from command_type where name = 'Research Tech'), 3);
insert into tech_command values (1, 3, (select id from tech where name = 'Alphabet'));

-- Turn 1: Move Warriors
insert into unit values (2, 1, (select id from unit_type where name = 'Warriors'));
insert into command values (4, 1, 1, 1, (select id from command_type where name = 'Move Unit'), 4);
insert into movement_command values (1, 4, 2, 1, 2);
