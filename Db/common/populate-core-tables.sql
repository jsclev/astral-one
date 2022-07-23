insert into language (name) values ('English');
insert into language (name) values ('Chinese');
insert into language (name) values ('Spanish');
insert into language (name) values ('French');
insert into language (name) values ('German');
insert into language (name) values ('Italian');

insert into civilization (name, language_id, color) values (
    'Romans', (select language_id from language where name = 'English'), 'White');
insert into civilization (name, language_id, color) values (
    'Russians', (select language_id from language where name = 'English'), 'White');
insert into civilization (name, language_id, color) values (
    'Celts', (select language_id from language where name = 'English'), 'White');
insert into civilization (name, language_id, color) values (
    'Babylonians', (select language_id from language where name = 'English'), 'Green');
insert into civilization (name, language_id, color) values (
    'Zulus', (select language_id from language where name = 'English'), 'Green');
insert into civilization (name, language_id, color) values (
    'Japanese', (select language_id from language where name = 'English'), 'Green');
insert into civilization (name, language_id, color) values (
    'Germans', (select language_id from language where name = 'English'), 'Blue');
insert into civilization (name, language_id, color) values (
    'French', (select language_id from language where name = 'English'), 'Blue');
insert into civilization (name, language_id, color) values (
    'Vikings', (select language_id from language where name = 'English'), 'Blue');
insert into civilization (name, language_id, color) values (
    'Egyptians', (select language_id from language where name = 'English'), 'Yellow');
insert into civilization (name, language_id, color) values (
    'Aztecs', (select language_id from language where name = 'English'), 'Yellow');
insert into civilization (name, language_id, color) values (
    'Spanish', (select language_id from language where name = 'English'), 'Yellow');
insert into civilization (name, language_id, color) values (
    'Americans', (select language_id from language where name = 'English'), 'Teal');
insert into civilization (name, language_id, color) values (
    'Chinese', (select language_id from language where name = 'English'), 'Teal');
insert into civilization (name, language_id, color) values (
    'Persians', (select language_id from language where name = 'English'), 'Teal');
insert into civilization (name, language_id, color) values (
    'Greeks', (select language_id from language where name = 'English'), 'Orange');
insert into civilization (name, language_id, color) values (
    'English', (select language_id from language where name = 'English'), 'Orange');
insert into civilization (name, language_id, color) values (
    'Carthaginians', (select language_id from language where name = 'English'), 'Orange');
insert into civilization (name, language_id, color) values (
    'Indians', (select language_id from language where name = 'English'), 'Purple');
insert into civilization (name, language_id, color) values (
    'Mongols', (select language_id from language where name = 'English'), 'Purple');
insert into civilization (name, language_id, color) values (
    'Sioux', (select language_id from language where name = 'English'), 'Purple');
