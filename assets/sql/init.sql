CREATE TABLE judge (id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, gender VARCHAR(6), initials TEXT);
CREATE TABLE heat_info (id INTEGER PRIMARY KEY, judge_id INTEGER, heat_number VARCHAR(8), heat_title VARCHAR(20), assigned_couple VARCHAR(20), critique_sheet_type INTEGER, heat_order INTEGER);
CREATE TABLE heat_local (id INTEGER PRIMARY KEY, judge_id INTEGER, heat_number VARCHAR(8), heat_title VARCHAR(20), assigned_couple VARCHAR(20), critique_sheet_type INTEGER, heat_order INTEGER);
CREATE TABLE critique_sheet_1 (id INTEGER PRIMARY KEY, technique TEXT, musicality TEXT, partnering_skill TEXT, presentation TEXT, feedback TEXT);
CREATE TABLE critique_sheet_2 (id INTEGER PRIMARY KEY, wl_technical_components TEXT, wl_artistic_components TEXT, ki_technical_components TEXT, ki_artistic_components TEXT, feedback TEXT);

INSERT INTO heat_info (judge_id, heat_number, heat_order, heat_title, assigned_couple, critique_sheet_type) VALUES (1, '351', 1, 'Waltz', '256|327', 2);

INSERT INTO heat_info (judge_id, heat_number, heat_order, heat_title, assigned_couple, critique_sheet_type) VALUES (1, '352', 2, 'Foxtrot', '316|308', 1);

INSERT INTO heat_info (judge_id, heat_number, heat_order, heat_title, assigned_couple, critique_sheet_type) VALUES (1, '353', 3, 'Waltz', '216|208', 2);

INSERT INTO heat_info (judge_id, heat_number, heat_order, heat_title, assigned_couple, critique_sheet_type) VALUES (1, '354', 4, 'Tango', '112|222', 1);