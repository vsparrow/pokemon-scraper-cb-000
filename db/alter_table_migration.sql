ALTER TABLE pokemon ADD COLUMN hp INTEGER;
UPDATE pokemon set  hp = 60 WHERE hp = NULL;
