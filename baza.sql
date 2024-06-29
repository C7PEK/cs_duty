CREATE TABLE `czaspracy` (
  `identifier` mediumtext DEFAULT NULL,
  `job` mediumtext DEFAULT NULL,
  `time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `jobs` (name, label) VALUES
  ('offpolice','Po Służbie'),
  ('offambulance','Po Służbie'),
  ('offmechanic','Po Służbie')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('offpolice',0,'recruit','Recruit',12,'{}','{}'),
  ('offpolice',1,'officer','Officer',24,'{}','{}'),
  ('offpolice',2,'sergeant','Sergeant',36,'{}','{}'),
  ('offpolice',3,'lieutenant','Lieutenant',48,'{}','{}'),
  ('offpolice',4,'boss','Boss',0,'{}','{}'),
  ('offambulance',0,'ambulance','Ambulance',12,'{}','{}'),
  ('offambulance',1,'doctor','Doctor',24,'{}','{}'),
  ('offambulance',2,'chief_doctor','Chef',36,'{}','{}'),
  ('offambulance',3,'boss','Boss',48,'{}','{}'),
  ('offmechanic',0,'recrue','Recruit',12,'{}','{}'),
  ('offmechanic',1,'novice','Officer',24,'{}','{}'),
  ('offmechanic',2,'experimente','Sergeant',36,'{}','{}'),
  ('offmechanic',3,'chief','Lieutenant',48,'{}','{}'),
  ('offmechanic',4,'boss','Boss',0,'{}','{}'),
;