CREATE TABLE judge (id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, gender VARCHAR(6), initials TEXT);
CREATE TABLE person (id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, gender VARCHAR(6), initials TEXT, user_roles TEXT);
CREATE TABLE contact_us (id INTEGER PRIMARY KEY, full_name TEXT, phone VARCHAR(20), to_email VARCHAR(30), best_email VARCHAR(30), event_website TEXT);
CREATE TABLE heat_info (id INTEGER PRIMARY KEY, judge_id INTEGER, heat_number VARCHAR(8), heat_title VARCHAR(20), assigned_couple VARCHAR(20), critique_sheet_type INTEGER, heat_order INTEGER);
CREATE TABLE heat_local (id INTEGER PRIMARY KEY, judge_id INTEGER, heat_number VARCHAR(8), heat_title VARCHAR(20), assigned_couple VARCHAR(20), critique_sheet_type INTEGER, heat_order INTEGER);
CREATE TABLE critique_sheet_1 (id INTEGER PRIMARY KEY, technique TEXT, musicality TEXT, partnering_skill TEXT, presentation TEXT, feedback TEXT);
CREATE TABLE critique_sheet_2 (id INTEGER PRIMARY KEY, wl_technical_components TEXT, wl_artistic_components TEXT, ki_technical_components TEXT, ki_artistic_components TEXT, feedback TEXT);

CREATE TABLE job_panel_data (id INTEGER PRIMARY KEY, panel_order INTEGER, heat_start INTEGER, heat_end INTEGER, time_start VARCHAR(20), time_end VARCHAR(20));
CREATE TABLE person_data (id INTEGER PRIMARY KEY, job_panel_data_id INTEGER, first_name TEXT, last_name TEXT, gender VARCHAR(6), initials TEXT, user_roles TEXT, FOREIGN KEY(job_panel_data_id) REFERENCES job_panel_data(id));
CREATE TABLE heat_data (id INTEGER PRIMARY KEY, job_panel_data_id INTEGER, heat_number VARCHAR(8), heat_title VARCHAR(20), time_start VARCHAR(20), critique_sheet_type INTEGER, heat_order INTEGER, is_started INTEGER, FOREIGN KEY(job_panel_data_id) REFERENCES job_panel_data(id));
CREATE TABLE sub_heat_data (id INTEGER PRIMARY KEY, heat_data_id INTEGER, sub_title VARCHAR(20), FOREIGN KEY(heat_data_id) REFERENCES heat_data(id));
CREATE TABLE heat_couple (id INTEGER PRIMARY KEY, sub_heat_id INTEGER, participant1 INTEGER, participant2 INTEGER, couple_tag VARCHAR(20), couple_level VARCHAR(20), age_category VARCHAR(20), studio VARCHAR(50), on_deck INTEGER, on_floor INTEGER, is_scratched INTEGER, FOREIGN KEY(participant1) REFERENCES couple_person(id), FOREIGN KEY(participant2) REFERENCES couple_person(id), FOREIGN KEY(sub_heat_id) REFERENCES sub_heat_data(id));
CREATE TABLE couple_person (id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, gender VARCHAR(6), level VARCHAR(20), age INTEGER);

INSERT INTO person (id, first_name, last_name, gender, user_roles) VALUES (1, 'Sammy', 'Field', 'Female', 'JUDGE');
INSERT INTO person (id, first_name, last_name, gender, user_roles) VALUES (2, 'John', 'Smith', 'Male', 'EMCEE');
INSERT INTO person (id, first_name, last_name, gender, user_roles) VALUES (3, 'Ken', 'Olson', 'Female', 'CHAIRMAN_OF_JUDGES');
INSERT INTO person (id, first_name, last_name, gender, user_roles) VALUES (4, 'John', 'Doe', 'Male', 'SCRUTINEER');
INSERT INTO person (id, first_name, last_name, gender, user_roles) VALUES (5, 'Maria', 'Folson', 'Male', 'DECK_CAPTAIN');

INSERT INTO job_panel_data (id, panel_order, heat_start, heat_end, time_start, time_end) VALUES (1, 1, 1, 5, '2019-1-20 10:20:00', '2019-1-20 15:20:00');
INSERT INTO job_panel_data (id, panel_order, heat_start, heat_end, time_start, time_end) VALUES (2, 2, 6, 9, '2019-1-20 15:20:00', '2019-1-20 18:20:00');

INSERT INTO person_data (id, job_panel_data_id, first_name, last_name, gender, user_roles) VALUES (1, 1, 'Sammy', 'Field', 'Female', 'JUDGE');
INSERT INTO person_data (id, job_panel_data_id, first_name, last_name, gender, user_roles) VALUES (2, 1, 'John', 'Smith', 'Male', 'EMCEE');
INSERT INTO person_data (id, job_panel_data_id, first_name, last_name, gender, user_roles) VALUES (3, 1, 'Ken', 'Olson', 'Female', 'CHAIRMAN_OF_JUDGES');
INSERT INTO person_data (id, job_panel_data_id, first_name, last_name, gender, user_roles) VALUES (4, 1, 'John', 'Doe', 'Male', 'SCRUTINEER');
INSERT INTO person_data (id, job_panel_data_id, first_name, last_name, gender, user_roles) VALUES (5, 1, 'Maria', 'Folson', 'Male', 'DECK_CAPTAIN');

INSERT INTO person_data (id, job_panel_data_id, first_name, last_name, gender, user_roles) VALUES (6, 2, 'Sammy', 'Field', 'Female', 'EMCEE');
INSERT INTO person_data (id, job_panel_data_id, first_name, last_name, gender, user_roles) VALUES (7, 2, 'John', 'Smith', 'Male', 'JUDGE');
INSERT INTO person_data (id, job_panel_data_id, first_name, last_name, gender, user_roles) VALUES (8, 2, 'Ken', 'Olson', 'Female', 'DECK_CAPTAIN');
INSERT INTO person_data (id, job_panel_data_id, first_name, last_name, gender, user_roles) VALUES (9, 2, 'John', 'Doe', 'Male', 'SCRUTINEER');
INSERT INTO person_data (id, job_panel_data_id, first_name, last_name, gender, user_roles) VALUES (10, 2, 'Maria', 'Folson', 'Male', 'CHAIRMAN_OF_JUDGES');

INSERT INTO heat_data (id, job_panel_data_id, heat_number, heat_order, heat_title, time_start, critique_sheet_type) VALUES (1, 1, '1', 1, 'Waltz', '2019-1-20 10:20:00', 2);
INSERT INTO heat_data (id, job_panel_data_id, heat_number, heat_order, heat_title, time_start, critique_sheet_type) VALUES (2, 1, '2', 2, 'Tango', '2019-1-20 11:50:00', 2);
INSERT INTO heat_data (id, job_panel_data_id, heat_number, heat_order, heat_title, time_start, critique_sheet_type) VALUES (3, 1, '3', 3, 'Cha-Cha', '2019-1-20 12:20:00', 2);
INSERT INTO heat_data (id, job_panel_data_id, heat_number, heat_order, heat_title, time_start, critique_sheet_type) VALUES (4, 1, '4', 4, 'Rumba', '2019-1-20 13:10:00', 2);
INSERT INTO heat_data (id, job_panel_data_id, heat_number, heat_order, heat_title, time_start, critique_sheet_type) VALUES (5, 1, '5', 5, 'Foxtrot', '2019-1-20 14:20:00', 2);
INSERT INTO heat_data (id, job_panel_data_id, heat_number, heat_order, heat_title, time_start, critique_sheet_type) VALUES (6, 2, '6', 6, 'Swing', '2019-1-20 15:20:00', 2);
INSERT INTO heat_data (id, job_panel_data_id, heat_number, heat_order, heat_title, time_start, critique_sheet_type) VALUES (7, 2, '7', 7, 'Cha-Cha', '2019-1-20 16:00:00', 2);
INSERT INTO heat_data (id, job_panel_data_id, heat_number, heat_order, heat_title, time_start, critique_sheet_type) VALUES (8, 2, '8', 8, 'Rumba', '2019-1-20 16:50:00', 2);
INSERT INTO heat_data (id, job_panel_data_id, heat_number, heat_order, heat_title, time_start, critique_sheet_type) VALUES (9, 2, '9', 9, 'Tango', '2019-1-20 17:30:00', 2);


INSERT INTO sub_heat_data (id, heat_data_id, sub_title) VALUES (1, 1, 'New Comer');
INSERT INTO sub_heat_data (id, heat_data_id, sub_title) VALUES (2, 2, 'New Comer');
INSERT INTO sub_heat_data (id, heat_data_id, sub_title) VALUES (3, 2, 'Advanced');
INSERT INTO sub_heat_data (id, heat_data_id, sub_title) VALUES (4, 3, 'New Comer');
INSERT INTO sub_heat_data (id, heat_data_id, sub_title) VALUES (5, 4, 'New Comer');
INSERT INTO sub_heat_data (id, heat_data_id, sub_title) VALUES (6, 5, 'New Comer');
INSERT INTO sub_heat_data (id, heat_data_id, sub_title) VALUES (7, 6, 'New Comer');
INSERT INTO sub_heat_data (id, heat_data_id, sub_title) VALUES (8, 6, 'Advanced');
INSERT INTO sub_heat_data (id, heat_data_id, sub_title) VALUES (9, 7, 'New Comer');
INSERT INTO sub_heat_data (id, heat_data_id, sub_title) VALUES (10, 8, 'New Comer');
INSERT INTO sub_heat_data (id, heat_data_id, sub_title) VALUES (11, 9, 'New Comer');

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (1, 'Cindy', 'Brown', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (2, 'Mitchel', 'Kibel', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (1, 1, 1, 2, 'L-B1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (3, 'Anabel', 'Greene', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (4, 'Sebastien', 'Frame', 'MALE', 17, 'AM');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (2, 1, 3, 4, 'L-B1', 'AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (5, 'Sue', 'Smith', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (6, 'Ryan', 'Wells', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (3, 1, 5, 6, 'G-A1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (7, 'Lillie', 'Barnard', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (8, 'Austin', 'Drummond', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (4, 1, 7, 8, 'G-C3', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (9, 'Eliana', 'Rutledge', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (10, 'Ernest', 'Terrell', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (5, 1, 9, 10, 'L-B1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (11, 'Mila', 'Stern', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (12, 'David', 'Borrow', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (6, 2, 11, 12, 'L-B1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (13, 'Dianne', 'Kelly', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (14, 'Jack', 'Osmend', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (7, 2, 13, 14, 'L-B1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (15, 'Rowena', 'Puckett', 'FEMALE', 18, 'PRO');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (16, 'Norman', 'Hughes', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (8, 3, 15, 16, 'L-B1', 'PRO', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (17, 'Margot', 'Nicholson', 'FEMALE', 18, 'PRO');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (18, 'Agustus', 'Mcdaniel', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (9, 3, 17, 18, 'L-B1', 'PRO', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (19, 'Pola', 'Walters', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (20, 'Darren', 'Rhodes', 'MALE', 17, 'AM');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (10, 4, 19, 20, 'L-B1', 'AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (21, 'Willa', 'Cohen', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (22, 'Kenny', 'Richards', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (11, 4, 21, 22, 'L-B1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (23, 'Rachael', 'Cousins', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (24, 'Brandon', 'Rees', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (12, 5, 23, 24, 'L-B1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (25, 'Christina', 'Lacey', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (26, 'Brandon', 'Trevino', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (13, 5, 25, 26, 'L-B1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (27, 'Aubrey', 'Merritt', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (28, 'Thomas', 'Bowden', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (14, 6, 27, 28, 'L-B1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (29, 'Alyssa', 'Robins', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (30, 'Jared', 'Spence', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (15, 6, 29, 30, 'L-B1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (31, 'Sandra', 'Merill', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (32, 'Otis', 'Moyer', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (16, 7, 31, 32, 'L-B1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (33, 'Leia', 'Blanchard', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (34, 'Theo', 'Cunningham', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (17, 7, 33, 34, 'L-B1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (35, 'Amelia', 'Rosa', 'FEMALE', 18, 'PRO');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (36, 'Jacob', 'Mckee', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (18, 8, 35, 36, 'G-A1', 'PRO', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (37, 'Lily-Ann', 'Schroeder', 'FEMALE', 18, 'PRO');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (38, 'Zakk', 'Stone', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (19, 8, 37, 38, 'G-A1', 'PRO', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (39, 'Tracey', 'Hodge', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (40, 'Borys', 'Slater', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (20, 9, 39, 40, 'L-B1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (41, 'Cassandra', 'Haynes', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (42, 'Nicolas', 'Ryder', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (21, 9, 41, 42, 'L-B1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (43, 'Josie', 'Deacon', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (44, 'Jordan', 'Mcfadden', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (22, 10, 43, 44, 'L-B1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (45, 'Maegan', 'Alexander', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (46, 'Ronan', 'Emerson', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (23, 10, 45, 46, 'L-B1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (47, 'Corey', 'Frazier', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (48, 'Pablo', 'Dunn', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (24, 11, 47, 48, 'L-B1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (49, 'Brooklyn', 'Goff', 'FEMALE', 18, 'AM');
INSERT INTO couple_person (id, first_name, last_name, gender, age, level) VALUES (50, 'Francis', 'Meyers', 'MALE', 17, 'PRO');
INSERT INTO heat_couple (id, sub_heat_id, participant1, participant2, couple_tag, couple_level, age_category, studio, is_scratched) VALUES (25, 11, 49, 50, 'L-B1', 'PRO-AM', 'C3', 'Universal Studios', 0);

INSERT INTO heat_info (judge_id, heat_number, heat_order, heat_title, assigned_couple, critique_sheet_type) VALUES (1, '351', 1, 'Waltz', '256|327', 2);

INSERT INTO heat_info (judge_id, heat_number, heat_order, heat_title, assigned_couple, critique_sheet_type) VALUES (1, '352', 2, 'Foxtrot', '316|308', 1);

INSERT INTO heat_info (judge_id, heat_number, heat_order, heat_title, assigned_couple, critique_sheet_type) VALUES (1, '353', 3, 'Waltz', '216|208', 2);

INSERT INTO heat_info (judge_id, heat_number, heat_order, heat_title, assigned_couple, critique_sheet_type) VALUES (1, '354', 4, 'Tango', '112|222', 1);