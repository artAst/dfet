CREATE TABLE judge (id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, gender VARCHAR(6), initials TEXT);
CREATE TABLE heat_info (id INTEGER PRIMARY KEY, judge_id INTEGER, heat_number VARCHAR(8), heat_title VARCHAR(20), assigned_couple VARCHAR(20), critique_sheet_type INTEGER);

INSERT INTO heat_info (judge_id, heat_number, heat_title, assigned_couple, critique_sheet_type)
VALUES (1, '345', 'Foxtrot', '256,327', 1);

INSERT INTO heat_info (judge_id, heat_number, heat_title, assigned_couple)
VALUES (1, '351', 'Waltz', '316,308', 2);