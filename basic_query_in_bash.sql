--comments , single line --, multi line /* */

--log in to sql 
mysql -h127.0.0.1 -uroot -ppassward

--send query to sql
mysql -h127.0.0.1 -uroot -ppassward db_name -e "SHOW TABLES"



/*
SELECT
*/
--오름차순
SELECT * FROM `db_name`.`table_name` ORDER BY `column_name` ASC LIMIT 1000;
--내림차순
SELECT * FROM `test`.`student` ORDER BY `name` DESC LIMIT 1000;

/*
INSERT
*/
INSERT INTO `table_name` (column_name_1, column_name_3, column_name_3) VALUES ('test_1.ivf', '/nstream/av1/test/', '8')
 
 
 /*
 DELETE
 */
DELETE FROM `DB`.`av1_conformance` WHERE  `name`='test_1.ivf' AND `path`='/nstream/av1/test/' AND `bit_depth`=008 LIMIT 1;


/*
UPDATE
*/
UPDATE `streams`.`av1_conformance` SET `path`='/nstream/av1/test', `bit_depth`='8' WHERE  `name`='test_3.ivf' AND `path`='INVALID' AND `bit_depth`=000 LIMIT 1;