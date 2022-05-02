insert into game values (1, 'Rome Was Built In A Day', '2022-03-31');

insert into player values (1, 1, 1, 'Mr. Caesar', 'Human');
insert into player values (2, 1, 1, 'Mr. Big Stuff', 'AI');

-- Turn 1: Build city
insert into unit values (1, 1, 1, (select unit_type_id from unit_type where name = 'City Creator'), 1);
insert into city values (1, 1, 1, 'Rome');
insert into command values (1, 1, 1, 1, (select command_type_id from command_type where name = 'Build City'), 1);
insert into settle_command values (1, 1, 1);

-- Turn 1: Create barracks
insert into building values (1, 1, 1, (select building_type_id from building_type where name = 'Barracks'));
insert into command values (2, 1, 1, 1, (select command_type_id from command_type where name = 'Build Building'), 2);
insert into building_command values (2, 1);

-- Turn 1: Research Alphabet
insert into command values (3, 1, 1, 1, (select command_type_id from command_type where name = 'Research Tech'), 3);
insert into tech_command values (3, (select tech_id from tech where name = 'Alphabet'));

-- Turn 1: Move Warriors
insert into unit values (2, 1, 1, (select unit_type_id from unit_type where name = 'Infantry1'), 2);
insert into command values (4, 1, 1, 1, (select command_type_id from command_type where name = 'Move Unit'), 4);
insert into move_command values (4, 2, 1, 2);
