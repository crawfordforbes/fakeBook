DROP TABLE IF EXISTS songs;
CREATE TABLE songs (
	id INTEGER PRIMARY KEY ASC,
	title text,
	artist text,
	album text,
	track int,
	tag text,
	score text,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE TRIGGER songs BEFORE UPDATE ON songs BEGIN
UPDATE songs SET updated_at = CURRENT_TIMESTAMP WHERE id = new.id;
END;