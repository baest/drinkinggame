/*
use drinkinggame;
GRANT ALL ON drinkinggame.* TO drink@localhost IDENTIFIED BY 'temmelighemmelig';

/usr/local/bin/createdb drinkinggame
*/

DROP TABLE IF EXISTS game CASCADE;
CREATE TABLE game (
	id SERIAL NOT NULL,
	timestamp TIMESTAMP NOT NULL DEFAULT NOW(),
	players INTEGER[] NOT NULL
);

DROP TABLE IF EXISTS player CASCADE;
CREATE TABLE player (
	id SERIAL NOT NULL,
	name TEXT NOT NULL,
	colour TEXT NOT NULL,
	password TEXT
);

DROP TABLE IF EXISTS turn CASCADE;
CREATE TABLE turn (
	id SERIAL NOT NULL,
	game_id INTEGER NOT NULL,
	player_id INTEGER NOT NULL,
	timestamp INTEGER NOT NULL,
	name TEXT NOT NULL,
	sip INTEGER NOT NULL DEFAULT 0,
	push_ups INTEGER NOT NULL DEFAULT 0,
	turn_around INTEGER NOT NULL DEFAULT 0,
	piss_pass INTEGER NOT NULL DEFAULT 0
);

DROP TABLE IF EXISTS what_to_do CASCADE;
CREATE TABLE what_to_do (
	id SERIAL NOT NULL,
	what TEXT NOT NULL,
	sip INTEGER NOT NULL DEFAULT 0,
	push_ups INTEGER NOT NULL DEFAULT 0,
	turn_around INTEGER NOT NULL DEFAULT 0,
	piss_pass INTEGER NOT NULL DEFAULT 0
);

DROP VIEW IF EXISTS v_next_what_to_do CASCADE;
CREATE OR REPLACE VIEW v_next_what_to_do AS 
	SELECT *
	FROM what_to_do
	ORDER BY random()
	LIMIT 1;

DROP VIEW IF EXISTS v_players CASCADE;
CREATE OR REPLACE VIEW v_players AS 
	SELECT g.id as game_id, p.* 
	FROM player p
	JOIN game g ON (p.id =ANY (g.players))
	;

DROP FUNCTION IF EXISTS f_get_next_player(INT);
CREATE OR REPLACE FUNCTION f_get_next_player(p_game_id INTEGER) RETURNS player AS $$
	SELECT p.* 
	FROM player p
	JOIN game g USING (id)
	WHERE g.id = $1
	ORDER BY random() 
	LIMIT 1;
$$ LANGUAGE SQL;

/*
'#000099',
'#ff0000',
'#00ff00',
'#000000',
'#cccccc',
'#999900',
'#00cc99',
'#00ffff',
 */

INSERT INTO player (colour, name, password) VALUES('#000099','baest','');
INSERT INTO player (colour, name, password) VALUES('#ff0000','kansler','');
--INSERT INTO player (colour, name, password) VALUES('#00ff00','flænseren','');
--INSERT INTO player (colour, name, password) VALUES('#000000','kommisar','');
--INSERT INTO player (colour, name, password) VALUES('#EDB1E7','brøsti','');
INSERT INTO what_to_do (what, sip) VALUES('Drik 1 tår', 1);
INSERT INTO what_to_do (what, sip) VALUES('Drik 2 tåre', 2);
INSERT INTO what_to_do (what, sip) VALUES('Drik 4 tåre', 4);
INSERT INTO what_to_do (what, sip) VALUES('Drik 8 tåre', 8);
INSERT INTO what_to_do (what, sip) VALUES('Del 1 tår ud', 0);
INSERT INTO what_to_do (what, sip) VALUES('Del 2 tåre ud', 0);
INSERT INTO what_to_do (what, sip) VALUES('Del 4 tåre ud', 0);
INSERT INTO what_to_do (what, sip) VALUES('Del 8 tåre ud', 0);
INSERT INTO what_to_do (what, sip) VALUES('Bund øl', 14);
INSERT INTO what_to_do (what) VALUES('Støn en i en sms');
INSERT INTO what_to_do (what) VALUES('Find på en sang som alle skal synge');
INSERT INTO what_to_do (what) VALUES('Find på en vittighed inden 10 sek eller bund en øl');
INSERT INTO what_to_do (what, push_ups) VALUES('Lav 5 armbøjninger', 5);
INSERT INTO what_to_do (what, turn_around) VALUES('Snur 20 gange rundt', 20);
INSERT INTO what_to_do (what, piss_pass) VALUES('Pis nu!!', 1);

/*
1159034488*/
