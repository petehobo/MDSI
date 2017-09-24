-- *** Change password from xxxxxxxx as required before running

drop user if exists 'nasa'@'localhost';
create user 'nasa'@'localhost' identified by 'xxxxxxxx';

drop database if exists nasa;
CREATE DATABASE `nasa` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

grant all privileges on nasa.* to nasa@localhost;

use nasa;

create table programs (
    id         int         not null auto_increment primary key,
    name       varchar(20) not null,
	UNIQUE INDEX program_name(name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into programs (name) values
	("Mercury"),
	("Gemini"),
	("Apollo");


create table missions (
    id                  int            not null auto_increment primary key,
	name                varchar(20)    not null,
	program_id          int            not null,
	class               varchar(20)    null,
	command_module      varchar(20)    null,
	lunar_module        varchar(20)    null,
	launch_date         datetime       null,
	splashdown_date     datetime       null,
	lunar_landing_date  datetime       null,
	lunar_liftoff_date  datetime       null,
	UNIQUE INDEX mission_name(name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


insert into missions (name, program_id, class, command_module, lunar_module, launch_date, splashdown_date, lunar_landing_date, lunar_liftoff_date) values
    ("Mercury-Redstone 3", (select id from programs where name = "Mercury"), NULL,      "Freedom 7",      NULL,         "1961-05-05 14:34:13", "1961-05-05 14:49:35", NULL,                  NULL),
    ("Mercury-Redstone 4", (select id from programs where name = "Mercury"), NULL,      "Liberty Bell 7", NULL,         "1961-07-21 12:20:36", "1961-07-21 12:36:13", NULL,                  NULL),
    ("Mercury-Atlas 6",    (select id from programs where name = "Mercury"), NULL,      "Friendship 7",   NULL,         "1962-02-20 14:47:39", "1962-02-20 19:43:02", NULL,                  NULL),
    ("Mercury-Atlas 7",    (select id from programs where name = "Mercury"), NULL,      "Aurora 7",       NULL,         "1962-05-24 12:45:16", "1962-05-24 17:41:21", NULL,                  NULL),
    ("Mercury-Atlas 8",    (select id from programs where name = "Mercury"), NULL,      "Sigma 7"    ,    NULL,         "1962-10-03 12:15:12", "1962-10-03 21:28:22", NULL,                  NULL),
    ("Mercury-Atlas 9",    (select id from programs where name = "Mercury"), NULL,      "Faith 7"    ,    NULL,         "1963-05-15 13:04:13", "1963-05-16 23:24:02", NULL,                  NULL),
    ("Gemini 3",           (select id from programs where name = "Gemini"),  NULL,      "Molly Brown",    NULL,         "1965-03-23 14:24:00", "1965-03-23 19:16:31", NULL,                  NULL),
    ("Gemini 4",           (select id from programs where name = "Gemini"),  NULL,      NULL,             NULL,         "1965-06-03 15:15:59", "1965-06-07 17:12:11", NULL,                  NULL),
    ("Gemini 5",           (select id from programs where name = "Gemini"),  NULL,      NULL,             NULL,         "1965-08-21 13:59:59", "1965-08-29 12:55:13", NULL,                  NULL),
    ("Gemini 6A",          (select id from programs where name = "Gemini"),  NULL,      NULL,             NULL,         "1965-12-15 13:37:26", "1965-12-16 15:28:50", NULL,                  NULL),
    ("Gemini 7",           (select id from programs where name = "Gemini"),  NULL,      NULL,             NULL,         "1965-12-04 19:30:03", "1965-12-18 14:05:04", NULL,                  NULL),
    ("Gemini 8",           (select id from programs where name = "Gemini"),  NULL,      NULL,             NULL,         "1966-03-16 16:41:02", "1966-03-17 03:22:28", NULL,                  NULL),
    ("Gemini 9A",          (select id from programs where name = "Gemini"),  NULL,      NULL,             NULL,         "1966-06-03 13:39:33", "1966-06-06 14:00:23", NULL,                  NULL),
    ("Gemini 10",          (select id from programs where name = "Gemini"),  NULL,      NULL,             NULL,         "1966-07-18 22:20:26", "1966-07-21 21:07:05", NULL,                  NULL),
    ("Gemini 11",          (select id from programs where name = "Gemini"),  NULL,      NULL,             NULL,         "1966-09-12 14:42:26", "1966-09-15 13:59:35", NULL,                  NULL),
    ("Gemini 12",          (select id from programs where name = "Gemini"),  NULL,      NULL,             NULL,         "1966-11-11 20:46:33", "1966-11-15 19:21:04", NULL,                  NULL),
    ("Apollo 1",           (select id from programs where name = "Apollo"),  NULL,      NULL,             NULL,         NULL,                  NULL,                  NULL,                  NULL),
    ("Apollo 7",           (select id from programs where name = "Apollo"),  "C",       NULL,             NULL,         "1968-10-11 15:02:45", "1968-10-22 11:11:48", NULL,                  NULL),
    ("Apollo 8",           (select id from programs where name = "Apollo"),  "C prime", NULL,             NULL,         "1968-12-21 12:51:00", "1968-12-27 15:51:42", NULL,                  NULL),
    ("Apollo 9",           (select id from programs where name = "Apollo"),  "D",       "Gumdrop",        "Spider",     "1969-03-03 16:00:00", "1969-03-13 17:00:54", NULL,                  NULL),
    ("Apollo 10",          (select id from programs where name = "Apollo"),  "F",       "Charlie Brown",  "Snoopy",     "1969-05-18 16:49:00", "1969-05-26 16:52:23", NULL,                  NULL),
    ("Apollo 11",          (select id from programs where name = "Apollo"),  "G",       "Columbia",       "Eagle",      "1969-07-16 13:32:00", "1969-07-24 16:50:35", "1969-07-20 20:18:04", "1969-07-21 17:54:00"),
    ("Apollo 12",          (select id from programs where name = "Apollo"),  "H",       "Yankee Clipper", "Intrepid",   "1969-11-14 16:22:00", "1969-11-24 20:58:24", "1969-11-19 06:54:35", "1969-11-20 14:25:47"),
    ("Apollo 13",          (select id from programs where name = "Apollo"),  "H",       "Odyssey",        "Aquarius",   "1970-04-11 19:13:00", "1970-04-17 18:07:41", NULL,                  NULL),
    ("Apollo 14",          (select id from programs where name = "Apollo"),  "H",       "Kitty Hawk",     "Antares",    "1971-01-31 21:03:02", "1971-02-09 21:05:00", "1971-02-05 09:18:11", "1971-02-06 18:48:42"),
    ("Apollo 15",          (select id from programs where name = "Apollo"),  "J",       "Endeavor",       "Falcon",     "1971-07-26 13:34:00", "1971-08-07 20:45:53", "1971-07-30 22:16:29", "1971-08-02 17:11:23"),
    ("Apollo 16",          (select id from programs where name = "Apollo"),  "J",       "Casper",         "Orion",      "1972-04-16 17:54:00", "1972-04-27 19:45:05", "1972-04-21 02:23:35", "1972-04-24 01:25:47"),
    ("Apollo 17",          (select id from programs where name = "Apollo"),  "J",       "America",        "Challenger", "1972-12-07 05:33:00", "1972-12-19 19:24:59", "1972-12-11 19:54:57", "1972-12-14 22:54:37");

create table astronauts (
    id         int         not null auto_increment primary key,
    surname    varchar(20) not null,
    first_name varchar(20) not null,
	UNIQUE INDEX astronaut_name(surname, first_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into astronauts (first_name, surname) values
    ("Alan",    "Shepard"),
    ("Gus",     "Grissom"),
    ("John",    "Glenn"),
    ("Scott",   "Carpenter"),
    ("Wally",   "Schirra"),
    ("Gordo",   "Cooper"),
    ("John",    "Young"),
    ("Jim",     "McDivitt"),
    ("Ed",      "White"),
    ("Pete",    "Conrad"),
    ("Tom",     "Stafford"),
    ("Frank",   "Borman"),
    ("Jim",     "Lovell"),
    ("Neil",    "Armstrong"),
    ("David",   "Scott"),
    ("Eugene",  "Cernan"),
    ("Michael", "Collins"),
    ("Dick",    "Gordon"),
    ("Buzz",    "Aldrin"),
    ("Roger",   "Chaffee"),
    ("Donn",    "Eisele"),
    ("Walt",    "Cunningham"),
    ("Bill",    "Anders"),
    ("Rusty",   "Schweickart"),
    ("Alan",    "Bean"),
    ("Jack",    "Swigert"),
    ("Fred",    "Haise"),
    ("Stu",     "Roosa"),
    ("Edgar",   "Mitchell"),
    ("Al",      "Worden"),
    ("James",   "Irwin"),
    ("Ken",     "Mattingly"),
    ("Charles", "Duke"),
    ("Ron",     "Evans"),
    ("Harrison","Schmitt");


create table roles (
    id         int         not null auto_increment primary key,
    name       varchar(20) not null,
	UNIQUE INDEX role_name(name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into roles (name) values
    ("Commander"),
    ("Pilot"),
    ("Senior Pilot"),
    ("Command Module Pilot"),
    ("Lunar Module Pilot"),
    ("Command Pilot");


create table astronaut_missions (
	mission_id    int  not null,
	role_id       int  not null,
	astronaut_id  int  not null,
	FOREIGN KEY astronaut_missions_astronauts (astronaut_id) REFERENCES astronauts(id),
	FOREIGN KEY astronaut_missions_missions   (mission_id)   REFERENCES missions(id),
	FOREIGN KEY astronaut_missions_roles      (role_id)      REFERENCES roles(id),
	UNIQUE INDEX mission_role (mission_id, role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



insert into astronaut_missions (mission_id, role_id, astronaut_id) values
    ((select id from missions where name = "Mercury-Redstone 3"), (select id from roles where name = "Commander"),            (select id from astronauts where surname = "Shepard")),
    ((select id from missions where name = "Mercury-Redstone 4"), (select id from roles where name = "Commander"),            (select id from astronauts where surname = "Grissom")),
    ((select id from missions where name = "Mercury-Atlas 6"),    (select id from roles where name = "Commander"),            (select id from astronauts where surname = "Glenn")),
    ((select id from missions where name = "Mercury-Atlas 7"),    (select id from roles where name = "Commander"),            (select id from astronauts where surname = "Carpenter")),
    ((select id from missions where name = "Mercury-Atlas 8"),    (select id from roles where name = "Commander"),            (select id from astronauts where surname = "Schirra")),
    ((select id from missions where name = "Mercury-Atlas 9"),    (select id from roles where name = "Commander"),            (select id from astronauts where surname = "Cooper")),
    ((select id from missions where name = "Gemini 3"),           (select id from roles where name = "Command Pilot"),        (select id from astronauts where surname = "Grissom")),
    ((select id from missions where name = "Gemini 3"),           (select id from roles where name = "Pilot"),                (select id from astronauts where surname = "Young")),
    ((select id from missions where name = "Gemini 4"),           (select id from roles where name = "Command Pilot"),        (select id from astronauts where surname = "McDivitt")),
    ((select id from missions where name = "Gemini 4"),           (select id from roles where name = "Pilot"),                (select id from astronauts where surname = "White")),
    ((select id from missions where name = "Gemini 5"),           (select id from roles where name = "Command Pilot"),        (select id from astronauts where surname = "Cooper")),
    ((select id from missions where name = "Gemini 5"),           (select id from roles where name = "Pilot"),                (select id from astronauts where surname = "Conrad")),
    ((select id from missions where name = "Gemini 6A"),          (select id from roles where name = "Command Pilot"),        (select id from astronauts where surname = "Schirra")),
    ((select id from missions where name = "Gemini 6A"),          (select id from roles where name = "Pilot"),                (select id from astronauts where surname = "Stafford")),
    ((select id from missions where name = "Gemini 7"),           (select id from roles where name = "Command Pilot"),        (select id from astronauts where surname = "Borman")),
    ((select id from missions where name = "Gemini 7"),           (select id from roles where name = "Pilot"),                (select id from astronauts where surname = "Lovell")),
    ((select id from missions where name = "Gemini 8"),           (select id from roles where name = "Command Pilot"),        (select id from astronauts where surname = "Armstrong")),
    ((select id from missions where name = "Gemini 8"),           (select id from roles where name = "Pilot"),                (select id from astronauts where surname = "Scott")),
    ((select id from missions where name = "Gemini 9A"),          (select id from roles where name = "Command Pilot"),        (select id from astronauts where surname = "Stafford")),
    ((select id from missions where name = "Gemini 9A"),          (select id from roles where name = "Pilot"),                (select id from astronauts where surname = "Cernan")),
    ((select id from missions where name = "Gemini 10"),          (select id from roles where name = "Command Pilot"),        (select id from astronauts where surname = "Young")),
    ((select id from missions where name = "Gemini 10"),          (select id from roles where name = "Pilot"),                (select id from astronauts where surname = "Collins")),
    ((select id from missions where name = "Gemini 11"),          (select id from roles where name = "Command Pilot"),        (select id from astronauts where surname = "Conrad")),
    ((select id from missions where name = "Gemini 11"),          (select id from roles where name = "Pilot"),                (select id from astronauts where surname = "Gordon")),
    ((select id from missions where name = "Gemini 12"),          (select id from roles where name = "Command Pilot"),        (select id from astronauts where surname = "Lovell")),
    ((select id from missions where name = "Gemini 12"),          (select id from roles where name = "Pilot"),                (select id from astronauts where surname = "Aldrin")),
    ((select id from missions where name = "Apollo 1"),           (select id from roles where name = "Commander"),            (select id from astronauts where surname = "Grissom")),
    ((select id from missions where name = "Apollo 1"),           (select id from roles where name = "Senior Pilot"),         (select id from astronauts where surname = "White")),
    ((select id from missions where name = "Apollo 1"),           (select id from roles where name = "Pilot"),                (select id from astronauts where surname = "Chaffee")),
    ((select id from missions where name = "Apollo 7"),           (select id from roles where name = "Commander"),            (select id from astronauts where surname = "Schirra")),
    ((select id from missions where name = "Apollo 7"),           (select id from roles where name = "Command Module Pilot"), (select id from astronauts where surname = "Eisele")),
    ((select id from missions where name = "Apollo 7"),           (select id from roles where name = "Lunar Module Pilot"),   (select id from astronauts where surname = "Cunningham")),
    ((select id from missions where name = "Apollo 8"),           (select id from roles where name = "Commander"),            (select id from astronauts where surname = "Borman")),
    ((select id from missions where name = "Apollo 8"),           (select id from roles where name = "Command Module Pilot"), (select id from astronauts where surname = "Lovell")),
    ((select id from missions where name = "Apollo 8"),           (select id from roles where name = "Lunar Module Pilot"),   (select id from astronauts where surname = "Anders")),
    ((select id from missions where name = "Apollo 9"),           (select id from roles where name = "Commander"),            (select id from astronauts where surname = "McDivitt")),
    ((select id from missions where name = "Apollo 9"),           (select id from roles where name = "Command Module Pilot"), (select id from astronauts where surname = "Scott")),
    ((select id from missions where name = "Apollo 9"),           (select id from roles where name = "Lunar Module Pilot"),   (select id from astronauts where surname = "Schweickart")),
    ((select id from missions where name = "Apollo 10"),          (select id from roles where name = "Commander"),            (select id from astronauts where surname = "Stafford")),
    ((select id from missions where name = "Apollo 10"),          (select id from roles where name = "Command Module Pilot"), (select id from astronauts where surname = "Young")),
    ((select id from missions where name = "Apollo 10"),          (select id from roles where name = "Lunar Module Pilot"),   (select id from astronauts where surname = "Cernan")),
    ((select id from missions where name = "Apollo 11"),          (select id from roles where name = "Commander"),            (select id from astronauts where surname = "Armstrong")),
    ((select id from missions where name = "Apollo 11"),          (select id from roles where name = "Command Module Pilot"), (select id from astronauts where surname = "Collins")),
    ((select id from missions where name = "Apollo 11"),          (select id from roles where name = "Lunar Module Pilot"),   (select id from astronauts where surname = "Aldrin")),
    ((select id from missions where name = "Apollo 12"),          (select id from roles where name = "Commander"),            (select id from astronauts where surname = "Conrad")),
    ((select id from missions where name = "Apollo 12"),          (select id from roles where name = "Command Module Pilot"), (select id from astronauts where surname = "Gordon")),
    ((select id from missions where name = "Apollo 12"),          (select id from roles where name = "Lunar Module Pilot"),   (select id from astronauts where surname = "Bean")),
    ((select id from missions where name = "Apollo 13"),          (select id from roles where name = "Commander"),            (select id from astronauts where surname = "Lovell")),
    ((select id from missions where name = "Apollo 13"),          (select id from roles where name = "Command Module Pilot"), (select id from astronauts where surname = "Swigert")),
    ((select id from missions where name = "Apollo 13"),          (select id from roles where name = "Lunar Module Pilot"),   (select id from astronauts where surname = "Haise")),
    ((select id from missions where name = "Apollo 14"),          (select id from roles where name = "Commander"),            (select id from astronauts where surname = "Shepard")),
    ((select id from missions where name = "Apollo 14"),          (select id from roles where name = "Command Module Pilot"), (select id from astronauts where surname = "Roosa")),
    ((select id from missions where name = "Apollo 14"),          (select id from roles where name = "Lunar Module Pilot"),   (select id from astronauts where surname = "Mitchell")),
    ((select id from missions where name = "Apollo 15"),          (select id from roles where name = "Commander"),            (select id from astronauts where surname = "Scott")),
    ((select id from missions where name = "Apollo 15"),          (select id from roles where name = "Command Module Pilot"), (select id from astronauts where surname = "Worden")),
    ((select id from missions where name = "Apollo 15"),          (select id from roles where name = "Lunar Module Pilot"),   (select id from astronauts where surname = "Irwin")),
    ((select id from missions where name = "Apollo 16"),          (select id from roles where name = "Commander"),            (select id from astronauts where surname = "Young")),
    ((select id from missions where name = "Apollo 16"),          (select id from roles where name = "Command Module Pilot"), (select id from astronauts where surname = "Mattingly")),
    ((select id from missions where name = "Apollo 16"),          (select id from roles where name = "Lunar Module Pilot"),   (select id from astronauts where surname = "Duke")),
    ((select id from missions where name = "Apollo 17"),          (select id from roles where name = "Commander"),            (select id from astronauts where surname = "Cernan")),
    ((select id from missions where name = "Apollo 17"),          (select id from roles where name = "Command Module Pilot"), (select id from astronauts where surname = "Evans")),
    ((select id from missions where name = "Apollo 17"),          (select id from roles where name = "Lunar Module Pilot"),   (select id from astronauts where surname = "Schmitt"));
