SET @job_name = 'unicorn';
SET @society_name = 'society_unicorn';
SET @job_Name_Caps = 'Unicorn';



INSERT INTO `addon_account` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1),
  ('society_unicorn_fridge', 'Unicorn (frigo)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
  (@job_name, @job_Name_Caps, 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  (@job_name, 0, 'barman', 'Barman', 300, '{}', '{}'),
  (@job_name, 1, 'dancer', 'Dancer', 300, '{}', '{}'),
  (@job_name, 2, 'viceboss', 'Co-Owner', 500, '{}', '{}'),
  (@job_name, 3, 'boss', 'Ceo', 600, '{}', '{}')
;

INSERT INTO `items` (`name`, `label`, `limit`) VALUES  
    ('jager', 'Jägermeister', 5),
    ('vodka', 'Vodka', 5),
    ('rum', 'Rum', 5),
    ('whisky', 'Whisky', 5),
    ('tequila', 'Tequila', 5),
    ('martini', 'Martini ', 5),
    ('soda', 'Soda', 5),
    ('jusfruit', 'just fruit', 5),
    ('icetea', 'Ice Tea', 5),
    ('energy', 'Energy Drink', 5),
    ('drpepper', 'Dr. Pepper', 5),
    ('limonade', 'Lemonade', 5),
    ('bolcacahuetes', 'Bol de cacahuètes', 5),
    ('bolnoixcajou', 'Bowl Of nachos', 5),
    ('bolpistache', 'Bowl of pistaches', 5),
    ('bolchips', 'Bowl of chips', 5),
    ('saucisson', 'Saucisson', 5),
    ('grapperaisin', 'Grappe de raisin', 5),
    ('jagerbomb', 'Jägerbomb', 5),
    ('golem', 'Golem', 5),
    ('whiskycoca', 'Whisky-cola', 5),
    ('vodkaenergy', 'Vodka-energy', 5),
    ('vodkafruit', 'Vodka and fruits', 5),
    ('rhumfruit', 'Rum and Fruit', 5),
    ('teqpaf', "Teq'paf", 5),
    ('rhumcoca', 'Rum-coca', 5),
    ('mojito', 'Mojito', 5),
    ('ice', 'Glaçon', 5),
    ('mixapero', 'Mix Apéritif', 3),
    ('metreshooter', 'Mètre de shooter', 3),
    ('jagercerbere', 'Jäger Cerbère', 3),
    ('menthe', 'Feuille de menthe', 10)
;
