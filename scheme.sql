DROP TABLE `test_dbd`;
CREATE TABLE `test_dbd` (
  `text` TEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE `test_text_blob`;
CREATE TABLE `test_text_blob` (
  `c_text` TEXT NOT NULL,
  `c_blob` BLOB NOT NULL,
  `c_char` VARCHAR(100) NOT NULL,
  `c_bina` VARBINARY(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
