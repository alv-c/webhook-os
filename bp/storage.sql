SET FOREIGN_KEY_CHECKS = 0;


DROP TABLE IF EXISTS `application_types`;
DROP TABLE IF EXISTS `authentication_types`;
DROP TABLE IF EXISTS `database_types`;
DROP TABLE IF EXISTS `method_types`;
DROP TABLE IF EXISTS `response_types`;
DROP TABLE IF EXISTS `role_types`;
DROP TABLE IF EXISTS `table_types`;


DROP TABLE IF EXISTS `apis`;
DROP TABLE IF EXISTS `databases`;
DROP TABLE IF EXISTS `queries`;
DROP TABLE IF EXISTS `users`;


DROP PROCEDURE IF EXISTS `validate_api`;
DROP PROCEDURE IF EXISTS `validate_database`;
DROP PROCEDURE IF EXISTS `validate_user`;


SET FOREIGN_KEY_CHECKS = 1;


CREATE TABLE `application_types` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `application_type` VARCHAR(255) NOT NULL UNIQUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   
	PRIMARY KEY (`id`),
    
    INDEX `idx_application_type` (`application_type`),
	INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `authentication_types` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `authentication_type` VARCHAR(255) NOT NULL UNIQUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   
	PRIMARY KEY (`id`),
    
    INDEX `idx_authentication_type` (`authentication_type`),
	INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `database_types` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `database_type` VARCHAR(255) NOT NULL UNIQUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (`id`),
    
    INDEX `idx_database_type` (`database_type`),
	INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `method_types` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `method_type` VARCHAR(255) NOT NULL UNIQUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (`id`),
    
    INDEX `idx_method_type` (`method_type`),
	INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `response_types` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `response_type` VARCHAR(255) NOT NULL UNIQUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   
	PRIMARY KEY (`id`),
    
    INDEX `idx_response_type` (`response_type`),
	INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `role_types` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `role_type` VARCHAR(255) NOT NULL UNIQUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   
	PRIMARY KEY (`id`),
    
    INDEX `idx_role_type` (`role_type`),
	INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `table_types` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `table_type` VARCHAR(255) NOT NULL UNIQUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (`id`),
    
    INDEX `idx_table_type` (`table_type`),
	INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `apis` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) UNIQUE NOT NULL,
	`request_authentication_type` VARCHAR(255),
	`request_target_method_type` VARCHAR(255) NOT NULL,
    `request_target_response_type` VARCHAR(255) NOT NULL,
    `basic_and_token_authentication_method_type` VARCHAR(255),
    `api_key_authentication_key` VARCHAR(255),
	`api_key_authentication_header_name` VARCHAR(255),
	`basic_authentication_username` VARCHAR(255),
    `basic_authentication_password` VARCHAR(255),
	`basic_and_token_authentication_url` VARCHAR(255),
    `basic_and_token_authentication_query_parameter_map` JSON,
    `basic_and_token_authentication_header_map` JSON,
    `basic_and_token_authentication_body` JSON,
    `basic_and_token_authentication_token_extractor_list` JSON,
	`basic_and_token_authentication_expiration_extractor_list` JSON,
	`basic_and_token_authentication_expiration_buffer` INT,
    `token_authentication_token` VARCHAR(255),
    `request_target_url` VARCHAR(255) NOT NULL,
	`request_target_query_parameter_map` JSON,
	`request_target_header_map` JSON,
    `request_target_body` JSON,
	`is_request_target_response_nested` BOOLEAN NOT NULL DEFAULT FALSE,
    `is_api_active` BOOLEAN NOT NULL DEFAULT TRUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT `basic_and_token_authentication_token_extractor_list` CHECK (JSON_TYPE(`basic_and_token_authentication_token_extractor_list`) = 'ARRAY'),
    CONSTRAINT `basic_and_token_authentication_expiration_extractor_list` CHECK (JSON_TYPE(`basic_and_token_authentication_expiration_extractor_list`) = 'ARRAY'),
    CONSTRAINT `basic_and_token_authentication_query_parameter_map` CHECK (JSON_TYPE(`basic_and_token_authentication_query_parameter_map`) = 'OBJECT'),
    CONSTRAINT `basic_and_token_authentication_header_map` CHECK (JSON_TYPE(`basic_and_token_authentication_header_map`) = 'OBJECT'),
	CONSTRAINT `request_target_query_parameter_map` CHECK (JSON_TYPE(`request_target_query_parameter_map`) = 'OBJECT'),
	CONSTRAINT `request_target_header_map` CHECK (JSON_TYPE(`request_target_header_map`) = 'OBJECT'),
    
    PRIMARY KEY (`id`),
    
    FOREIGN KEY (`request_authentication_type`) REFERENCES `authentication_types`(`authentication_type`) ON DELETE CASCADE,
    FOREIGN KEY (`request_target_method_type`) REFERENCES `method_types`(`method_type`) ON DELETE CASCADE,
    FOREIGN KEY (`request_target_response_type`) REFERENCES `response_types`(`response_type`) ON DELETE CASCADE,
    FOREIGN KEY (`basic_and_token_authentication_method_type`) REFERENCES `method_types`(`method_type`) ON DELETE CASCADE,
    
    INDEX `idx_name` (`name`),
    INDEX `idx_request_authentication_type` (`request_authentication_type`),
    INDEX `idx_request_target_method_type` (`request_target_method_type`),
    INDEX `idx_request_target_response_type` (`request_target_response_type`),
    INDEX `idx_basic_and_token_authentication_method_type` (`basic_and_token_authentication_method_type`),
    INDEX `idx_api_key_authentication_key` (`api_key_authentication_key`),
    INDEX `idx_api_key_authentication_header_name` (`api_key_authentication_header_name`),
    INDEX `idx_basic_authentication_username` (`basic_authentication_username`),
    INDEX `idx_basic_authentication_password` (`basic_authentication_password`),
    INDEX `idx_basic_and_token_authentication_url` (`basic_and_token_authentication_url`),
    INDEX `idx_basic_and_token_authentication_expiration_buffer` (`basic_and_token_authentication_expiration_buffer`),
    INDEX `idx_token_authentication_token` (`token_authentication_token`),
    INDEX `idx_request_target_url` (`request_target_url`),
    INDEX `idx_is_request_target_response_nested` (`is_request_target_response_nested`),
    INDEX `idx_is_api_active` (`is_api_active`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)  
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `databases` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) UNIQUE NOT NULL,
    `database_type` VARCHAR(255) NOT NULL,
    `host` VARCHAR(255),
    `database` VARCHAR(255),
	`username` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `connect_string` VARCHAR(255),
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (`id`),
    
    FOREIGN KEY (`database_type`) REFERENCES `database_types`(`database_type`) ON DELETE CASCADE,
    
    INDEX `idx_name` (`name`),
    INDEX `idx_database_type` (`database_type`),
    INDEX `idx_host` (`host`),
    INDEX `idx_database` (`database`),
    INDEX `idx_username` (`username`),
    INDEX `idx_password` (`password`),
    INDEX `idx_connect_string` (`connect_string`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `queries` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) UNIQUE NOT NULL,
	`request_target_database` VARCHAR(255) NOT NULL,
    `request_target_sql` LONGTEXT NOT NULL,
	`is_request_target_response_nested` BOOLEAN NOT NULL DEFAULT FALSE,
	`is_query_periodic` BOOLEAN NOT NULL DEFAULT FALSE,
    `is_query_active` BOOLEAN NOT NULL DEFAULT TRUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (`id`),
    
    INDEX `idx_name` (`name`),
    INDEX `idx_request_target_database` (`request_target_database`),
    INDEX `idx_is_request_target_response_nested` (`is_request_target_response_nested`),
    INDEX `idx_is_query_periodic` (`is_query_periodic`),
    INDEX `idx_is_query_active` (`is_query_active`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)      
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `users` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `application_type` VARCHAR(255) NOT NULL,
	`username` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `role_list` JSON NOT NULL,
    `is_user_active` BOOLEAN NOT NULL DEFAULT TRUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT `role_list` CHECK (JSON_TYPE(`role_list`) = 'ARRAY'),
    
    PRIMARY KEY (`id`),
    
    FOREIGN KEY (`application_type`) REFERENCES `application_types`(`application_type`) ON DELETE CASCADE,
    
    UNIQUE KEY `unique_application_type_username` (`application_type`, `username`), 
    
	INDEX `idx_application_type` (`application_type`),
	INDEX `idx_username` (`username`),
    INDEX `idx_password` (`password`),
	INDEX `idx_is_user_active` (`is_user_active`),
	INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DELIMITER //


CREATE PROCEDURE `validate_api`(
    IN `request_authentication_type` VARCHAR(50),
    IN `basic_and_token_authentication_method_type` VARCHAR(255),
    IN `api_key_authentication_key` VARCHAR(255),
    IN `api_key_authentication_header_name` VARCHAR(255),
    IN `basic_authentication_username` VARCHAR(255),
    IN `basic_authentication_password` VARCHAR(255),
    IN `basic_and_token_authentication_url` VARCHAR(255),
    IN `token_authentication_token` VARCHAR(255),
    OUT `is_valid` BOOLEAN,
    OUT `error_message` VARCHAR(255)
)
BEGIN
    SET `is_valid` = TRUE;
    
    IF `request_authentication_type` = 'API Key' THEN
        IF `api_key_authentication_key` IS NULL OR `api_key_authentication_header_name` IS NULL THEN
            SET `is_valid` = FALSE;
            SET `error_message` = 'Invalid api_key_authentication fields: Must have a valid api_key_authentication_key and api_key_authentication_header_name';
        END IF;
    END IF;
    
    IF `request_authentication_type` = 'Basic' THEN
        IF `basic_authentication_username` IS NULL OR `basic_authentication_password` IS NULL THEN
            SET `is_valid` = FALSE;
            SET `error_message` = 'Invalid basic_authentication fields: Must have a valid basic_authentication_username and basic_authentication_password';
        END IF;
    END IF;
    
    IF `request_authentication_type` = 'Basic And Token' THEN
        IF 
            `basic_and_token_authentication_method_type` IS NULL
            OR `basic_authentication_username` IS NULL 
            OR `basic_authentication_password` IS NULL 
            OR `basic_and_token_authentication_url` IS NULL 
        THEN
            SET `is_valid` = FALSE;
            SET `error_message` = 'Invalid basic_and_token_authentication fields: Must have valid basic_and_token_authentication_method_type, basic_authentication_username, basic_authentication_password and basic_and_token_authentication_url';
        END IF;
    END IF;
    
    IF `request_authentication_type` = 'Token' THEN
        IF `token_authentication_token` IS NULL THEN
            SET `is_valid` = FALSE;
            SET `error_message` = 'Invalid token_authentication fields: Must have a valid token_authentication_token';
        END IF;
    END IF;
END;
//

CREATE PROCEDURE `validate_database`(
    IN `database_type` VARCHAR(50),
    IN `host` VARCHAR(255),
    IN `database` VARCHAR(255),
    IN `connect_string` VARCHAR(255),
    OUT `is_valid` BOOLEAN,
    OUT `error_message` VARCHAR(255)
)
BEGIN
    SET `is_valid` = TRUE;
    
    IF `database_type` = 'Oracle' THEN
        IF `connect_string` IS NULL THEN
            SET `is_valid` = FALSE;
            SET `error_message` = 'Invalid connect_string: Must be a valid Oracle connect string';
        END IF;
    END IF;
    
    IF `database_type` = 'SQL Server' THEN
        IF `host` IS NULL OR `database` IS NULL THEN
            SET `is_valid` = FALSE;
            SET `error_message` = 'Invalid host or database: Must be a valid SQL Server host and database';
        END IF;
    END IF;
END;
//

CREATE PROCEDURE `validate_user`(
    IN `role_list` JSON,
    IN `index` INT,
    IN `array_size` INT,
    IN `current_type` VARCHAR(255),
    OUT `is_valid` BOOLEAN,
    OUT `error_message` VARCHAR(255)
)
BEGIN
    SET `is_valid` = TRUE;
  
    IF `is_valid` = TRUE THEN
        SET `array_size` = JSON_LENGTH(`role_list`);
      
        WHILE `index` < `array_size` AND `is_valid` = TRUE DO
            SET `current_type` = JSON_UNQUOTE(JSON_EXTRACT(`role_list`, CONCAT('$[', `index`, ']')));
          
            IF JSON_TYPE(JSON_EXTRACT(`role_list`, CONCAT('$[', `index`, ']'))) != 'STRING' THEN
                SET `is_valid` = FALSE;
                SET `error_message` = 'Invalid role_list: All elements must be strings';
            ELSE
                IF NOT EXISTS (SELECT 1 FROM `role_types` WHERE `role_type` COLLATE utf8mb4_unicode_ci = `current_type`) THEN
                    SET `is_valid` = FALSE;
                    SET `error_message` = 'Invalid role_list: All elements must be strings that exist in the `role_types` table';
                END IF;
            END IF;
          
            SET `index` = `index` + 1;
        END WHILE;
    END IF;
END;
//


CREATE TRIGGER `before_apis_insert`
BEFORE INSERT ON `apis`
FOR EACH ROW
BEGIN
    DECLARE `is_valid` BOOLEAN DEFAULT TRUE;
    DECLARE `error_message` VARCHAR(255);
    
    CALL `validate_api`(
        NEW.`request_authentication_type`,
        NEW.`basic_and_token_authentication_method_type`,
        NEW.`api_key_authentication_key`,
        NEW.`api_key_authentication_header_name`,
        NEW.`basic_authentication_username`,
        NEW.`basic_authentication_password`,
        NEW.`basic_and_token_authentication_url`,
        NEW.`token_authentication_token`,
        `is_valid`,
        `error_message`
    );
    
    IF NOT `is_valid` THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = `error_message`;
    END IF;
END;
//

CREATE TRIGGER `before_apis_update`
BEFORE UPDATE ON `apis`
FOR EACH ROW
BEGIN
    DECLARE `is_valid` BOOLEAN DEFAULT TRUE;
    DECLARE `error_message` VARCHAR(255);
    
    CALL `validate_api`(
        NEW.`request_authentication_type`,
        NEW.`basic_and_token_authentication_method_type`,
        NEW.`api_key_authentication_key`,
        NEW.`api_key_authentication_header_name`,
        NEW.`basic_authentication_username`,
        NEW.`basic_authentication_password`,
        NEW.`basic_and_token_authentication_url`,
        NEW.`token_authentication_token`,
        `is_valid`,
        `error_message`
    );
    
    IF NOT `is_valid` THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = `error_message`;
    END IF;
END;
//

CREATE TRIGGER `before_databases_insert`
BEFORE INSERT ON `databases`
FOR EACH ROW
BEGIN
    DECLARE `is_valid` BOOLEAN DEFAULT TRUE;
    DECLARE `error_message` VARCHAR(255);
    
    CALL `validate_database`(
        NEW.`database_type`,
        NEW.`host`,
        NEW.`database`,
        NEW.`connect_string`,
        `is_valid`,
        `error_message`
    );
    
    IF NOT `is_valid` THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = `error_message`;
    END IF;
END;

CREATE TRIGGER `before_databases_update`
BEFORE UPDATE ON `databases`
FOR EACH ROW
BEGIN
    DECLARE `is_valid` BOOLEAN DEFAULT TRUE;
    DECLARE `error_message` VARCHAR(255);
    
    CALL `validate_database`(
        NEW.`database_type`,
        NEW.`host`,
        NEW.`database`,
        NEW.`connect_string`,
        `is_valid`,
        `error_message`
    );
    
    IF NOT `is_valid` THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = `error_message`;
    END IF;
END;

CREATE TRIGGER `before_users_insert`
BEFORE INSERT ON `users`
FOR EACH ROW
BEGIN
    DECLARE `index` INT DEFAULT 0;
    DECLARE `array_size` INT;
    DECLARE `current_type` VARCHAR(255);
    DECLARE `is_valid` BOOLEAN DEFAULT TRUE;
    DECLARE `error_message` VARCHAR(255);

    CALL `validate_user`(
        NEW.`role_list`,
        `index`,
        `array_size`,
        `current_type`,
        `is_valid`,
        `error_message`
    );

    IF NOT `is_valid` THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = `error_message`;
    END IF;
END;
//

CREATE TRIGGER `before_users_update`
BEFORE UPDATE ON `users`
FOR EACH ROW
BEGIN
    DECLARE `index` INT DEFAULT 0;
    DECLARE `array_size` INT;
    DECLARE `current_type` VARCHAR(255);
    DECLARE `is_valid` BOOLEAN DEFAULT TRUE;
    DECLARE `error_message` VARCHAR(255);

    CALL `validate_user`(
        NEW.`role_list`,
        `index`,
        `array_size`,
        `current_type`,
        `is_valid`,
        `error_message`
    );

    IF NOT `is_valid` THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = `error_message`;
    END IF;
END;
//


DELIMITER ;


INSERT INTO `application_types` (`application_type`)
VALUES
    ('api-gateway'),
    ('query-gateway'),
    ('sigma-cloud-api'),
    ('chatpro-webhook');
    
INSERT INTO `authentication_types` (`authentication_type`)
VALUES
    ('API Key'),
    ('Basic'),
    ('Basic And Token'),
    ('Token');
    
INSERT INTO `database_types` (`database_type`)
VALUES
    ('Oracle'),
    ('SQL Server');
    
INSERT INTO `method_types` (`method_type`)
VALUES
    ('get'),
    ('delete'),
    ('head'),
    ('patch'),
    ('post'),
    ('put');

INSERT INTO `response_types` (`response_type`)
VALUES
    ('arraybuffer'),
    ('blob'),
    ('document'),
    ('formdata'),
    ('json'),
    ('stream'),
    ('text');

INSERT INTO `role_types` (`role_type`)
VALUES
    ('admin'),
    ('user');
 
INSERT INTO `table_types` (`table_type`)
VALUES
    ('application_types'),
    ('authentication_types'),
    ('database_types'),
    ('method_types'),
    ('response_types'),
    ('role_types'),
    ('table_types'),
    ('apis'),
    ('databases'),
    ('queries'),
    ('users');
    
   
/* INSERT INTO `apis`
    (
        `name`, 
        `request_authentication_type`, 
        `request_target_method_type`, 
        `request_target_response_type`, 
        `basic_and_token_authentication_method_type`,
        `api_key_authentication_key`,
        `api_key_authentication_header_name`,
        `basic_authentication_username`,
        `basic_authentication_password`,
        `basic_and_token_authentication_url`,
        `basic_and_token_authentication_query_parameter_map`,
        `basic_and_token_authentication_header_map`,
        `basic_and_token_authentication_body`,
        `basic_and_token_authentication_token_extractor_list`,
        `basic_and_token_authentication_expiration_extractor_list`,
        `basic_and_token_authentication_expiration_buffer`,
        `token_authentication_token`,
        `request_target_url`,
        `request_target_query_parameter_map`,
        `request_target_header_map`,
        `request_target_body`
    ) 
VALUES
    (); */

INSERT INTO `databases`
    (
        `name`, 
        `database_type`, 
        `host`, 
        `database`, 
        `username`, 
        `password`, 
        `connect_string`
    )
VALUES
    ('Sankhya', 'Oracle', NULL, NULL, 'c8ee46cd57d998f228979924744c3a2a', '3e6f4f21281f420d4d5e51954a7bac55', '38c5f332e0f02eb275d320d2677ac2aca2432b252fdf28ba02e5bbae785c858a'),
    ('Sigma Desktop', 'SQL Server', 'd40ae8cd27f5a44bd94f606a69853079', '11775b52e950c9226672e3c5d9e20dd8', '78b0e0eb23613c315dd6df5fac5db257', '6a1b0e2e2038d877327bf213eae4173f97fa7e9532b18bfba84f9626eb97a6ad', NULL),
    ('Three Mod', 'SQL Server', '9083a7a426c3a84f5ed1e4c8a658830d', '92e42f5940badb00352e7e1801d98f7b8c4d869b3d90f572ce274f09d4d753b7', '73c1e50b3424ca16cabd9a93132e9348', '4f60709cac7977807304ddf7def283a0', NULL);

/* INSERT INTO `queries`
    (
        `name`, 
        `request_target_database`, 
        `request_target_sql`, 
        `is_request_target_response_nested`, 
        `is_query_periodic`, 
        `is_query_active`
    ) 
VALUES
    (); */
        
INSERT INTO `users` (`application_type`, `username`, `password`, `role_list`, `is_user_active`)
VALUES
    ('api-gateway', 'admin', '$2a$10$mwm596weoEp3WcyIgz1Gc.v/X4ahJmg/hsV6reNr6VLeEGcUhoQ/6', '["admin", "user"]', TRUE),
    ('api-gateway', 'user', '$2a$10$HB/w4Q8IonMozeujZguvE.fJX.pL28lw6sZcIesIYvdAY16HXMgMW', '["user"]', TRUE),
    ('query-gateway', 'admin', '$2a$10$mwm596weoEp3WcyIgz1Gc.v/X4ahJmg/hsV6reNr6VLeEGcUhoQ/6', '["admin", "user"]', TRUE),
    ('query-gateway', 'user', '$2a$10$HB/w4Q8IonMozeujZguvE.fJX.pL28lw6sZcIesIYvdAY16HXMgMW', '["user"]', TRUE),
    ('sigma-cloud-api', 'admin', '$2a$10$mwm596weoEp3WcyIgz1Gc.v/X4ahJmg/hsV6reNr6VLeEGcUhoQ/6', '["admin", "user"]', TRUE),
    ('sigma-cloud-api', 'user', '$2a$10$HB/w4Q8IonMozeujZguvE.fJX.pL28lw6sZcIesIYvdAY16HXMgMW', '["user"]', TRUE),
    ('chatpro-webhook', 'admin', '$2a$10$mwm596weoEp3WcyIgz1Gc.v/X4ahJmg/hsV6reNr6VLeEGcUhoQ/6', '["admin", "user"]', TRUE),
    ('chatpro-webhook', 'user', '$2a$10$HB/w4Q8IonMozeujZguvE.fJX.pL28lw6sZcIesIYvdAY16HXMgMW', '["user"]', TRUE);

