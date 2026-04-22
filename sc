
CREATE TABLE student (
    sreg_no INTEGER PRIMARY KEY,
    name CHAR(30),
    class CHAR(10)
);

CREATE TABLE competition (
    c_no INTEGER PRIMARY KEY,
    name CHAR(20),
    c_type CHAR(15) NOT NULL
);

CREATE TABLE participates (
    sreg_no INTEGER REFERENCES student(sreg_no),
    c_no INTEGER REFERENCES competition(c_no),
    rank INTEGER,
    year INTEGER,
    prize INTEGER,
    PRIMARY KEY(sreg_no, c_no)
);

-- TRIGGER: before update on competition table
CREATE OR REPLACE FUNCTION comp_update_notice()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'competition record is being updated';
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_comp_update
BEFORE UPDATE ON competition
FOR EACH ROW
EXECUTE FUNCTION comp_update_notice();

-- FUNCTION with CURSOR: accept student name, return total prizes in 2020
CREATE OR REPLACE FUNCTION total_prizes(p_name CHAR)
RETURNS INTEGER AS $$
DECLARE
    total INTEGER := 0;
    r RECORD;
    cur CURSOR FOR
        SELECT p.prize FROM participates p
        JOIN student s ON s.sreg_no = p.sreg_no
        WHERE s.name = p_name AND p.year = 2020;
BEGIN
    OPEN cur;
    LOOP
        FETCH cur INTO r;
        EXIT WHEN NOT FOUND;
        total := total + r.prize;
    END LOOP;
    CLOSE cur;
    RETURN total;
END;
$$ LANGUAGE plpgsql;
