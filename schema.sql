DROP TABLE IF EXISTS crimes;
DROP TABLE IF EXISTS perps;

CREATE TABLE perps(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT,
    last_name TEXT,
    date_of_birth TEXT
);

CREATE TABLE crimes(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    kind TEXT,
    solved BOOLEAN,
    perp_id INTEGER,
    CONSTRAINT perp_key FOREIGN KEY (perp_id) REFERENCES perps (id)
);
