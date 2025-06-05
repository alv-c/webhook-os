SET FOREIGN_KEY_CHECKS = 0;


DROP TABLE IF EXISTS `application_types`;
DROP TABLE IF EXISTS `authentication_types`;
DROP TABLE IF EXISTS `database_types`;
DROP TABLE IF EXISTS `grant_types`;
DROP TABLE IF EXISTS `method_types`;
DROP TABLE IF EXISTS `response_types`;
DROP TABLE IF EXISTS `role_types`;
DROP TABLE IF EXISTS `table_types`;


DROP TABLE IF EXISTS `apis`;
DROP TABLE IF EXISTS `applications`;
DROP TABLE IF EXISTS `databases`;
DROP TABLE IF EXISTS `d_guard_servers`;
DROP TABLE IF EXISTS `d_guard_layouts`;
DROP TABLE IF EXISTS `d_guard_workstations`;
DROP TABLE IF EXISTS `neppo_satisfaction_surveys`;
DROP TABLE IF EXISTS `queries`;
DROP TABLE IF EXISTS `users`;


DROP PROCEDURE IF EXISTS `validate_api`;
DROP PROCEDURE IF EXISTS `validate_database`;
DROP PROCEDURE IF EXISTS `validate_query`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `authentication_types` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `authentication_type` VARCHAR(255) NOT NULL UNIQUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),

    INDEX `idx_authentication_type` (`authentication_type`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `database_types` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `database_type` VARCHAR(255) NOT NULL UNIQUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),

    INDEX `idx_database_type` (`database_type`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `grant_types` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `grant_type` VARCHAR(255) NOT NULL UNIQUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),

    INDEX `idx_grant_type` (`grant_type`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `method_types` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `method_type` VARCHAR(255) NOT NULL UNIQUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),

    INDEX `idx_method_type` (`method_type`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `response_types` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `response_type` VARCHAR(255) NOT NULL UNIQUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),

    INDEX `idx_response_type` (`response_type`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `role_types` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `role_type` VARCHAR(255) NOT NULL UNIQUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),

    INDEX `idx_role_type` (`role_type`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `table_types` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `table_type` VARCHAR(255) NOT NULL UNIQUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),

    INDEX `idx_table_type` (`table_type`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `apis` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) UNIQUE NOT NULL,
    `group_name` VARCHAR(255),
    `authentication_type` VARCHAR(255),
    `basic_and_bearer_authentication_method_type` VARCHAR(255),
    `oauth_authentication_grant_type` VARCHAR(255),
    `method_type` VARCHAR(255) NOT NULL,
    `response_type` VARCHAR(255) NOT NULL,
    `api_key_authentication_key` LONGBLOB,
    `api_key_authentication_header_name` VARCHAR(255),
    `basic_authentication_username` LONGBLOB,
    `basic_authentication_password` LONGBLOB,
    `basic_and_bearer_authentication_url` VARCHAR(255),
    `basic_and_bearer_authentication_query_parameter_map` JSON,
    `basic_and_bearer_authentication_header_map` JSON,
    `basic_and_bearer_authentication_body` JSON,
    `basic_and_bearer_authentication_token_extractor_list` JSON,
    `basic_and_bearer_authentication_expiration_extractor_list` JSON,
    `basic_and_bearer_authentication_expiration_buffer` INT,
    `bearer_authentication_token` LONGBLOB,
    `oauth_authentication_client_id` LONGBLOB,
    `oauth_authentication_client_secret` LONGBLOB,
    `oauth_authentication_token_url` VARCHAR(255),
    `oauth_authentication_authorization_url` VARCHAR(255),
    `oauth_authentication_redirect_url` VARCHAR(255),
    `oauth_authentication_scope` VARCHAR(255),
    `oauth_authentication_access_token_extractor_list` JSON,
    `oauth_authentication_refresh_token_extractor_list` JSON,
    `oauth_authentication_expiration_extractor_list` JSON,
    `oauth_authentication_expiration_buffer` INT,
    `oauth_authentication_pkce_enabled` BOOLEAN,
    `oauth_authentication_additional_parameter_map` JSON,
    `url` VARCHAR(255) NOT NULL,
    `query_parameter_map` JSON,
    `header_map` JSON,
    `body` JSON,
    `is_api_active` BOOLEAN NOT NULL DEFAULT TRUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT `basic_and_bearer_authentication_query_parameter_map` CHECK (JSON_TYPE(`basic_and_bearer_authentication_query_parameter_map`) = 'OBJECT'),
    CONSTRAINT `basic_and_bearer_authentication_header_map` CHECK (JSON_TYPE(`basic_and_bearer_authentication_header_map`) = 'OBJECT'),
    CONSTRAINT `basic_and_bearer_authentication_token_extractor_list` CHECK (JSON_TYPE(`basic_and_bearer_authentication_token_extractor_list`) = 'ARRAY'),
    CONSTRAINT `basic_and_bearer_authentication_expiration_extractor_list` CHECK (JSON_TYPE(`basic_and_bearer_authentication_expiration_extractor_list`) = 'ARRAY'),
    CONSTRAINT `oauth_authentication_access_token_extractor_list` CHECK (JSON_TYPE(`oauth_authentication_access_token_extractor_list`) = 'ARRAY'),
    CONSTRAINT `oauth_authentication_refresh_token_extractor_list` CHECK (JSON_TYPE(`oauth_authentication_refresh_token_extractor_list`) = 'ARRAY'),
    CONSTRAINT `oauth_authentication_expiration_extractor_list` CHECK (JSON_TYPE(`oauth_authentication_expiration_extractor_list`) = 'ARRAY'),
    CONSTRAINT `oauth_authentication_additional_parameter_map` CHECK (JSON_TYPE(`oauth_authentication_additional_parameter_map`) = 'OBJECT'),
	CONSTRAINT `query_parameter_map` CHECK (JSON_TYPE(`query_parameter_map`) = 'OBJECT'),
	CONSTRAINT `header_map` CHECK (JSON_TYPE(`header_map`) = 'OBJECT'),
    
    PRIMARY KEY (`id`),
    
    FOREIGN KEY (`authentication_type`) REFERENCES `authentication_types`(`authentication_type`) ON DELETE CASCADE,
    FOREIGN KEY (`basic_and_bearer_authentication_method_type`) REFERENCES `method_types`(`method_type`) ON DELETE CASCADE,
    FOREIGN KEY (`oauth_authentication_grant_type`) REFERENCES `grant_types`(`grant_type`) ON DELETE CASCADE,
    FOREIGN KEY (`method_type`) REFERENCES `method_types`(`method_type`) ON DELETE CASCADE,
    FOREIGN KEY (`response_type`) REFERENCES `response_types`(`response_type`) ON DELETE CASCADE,
    
    INDEX `idx_name` (`name`),
    INDEX `idx_group_name` (`group_name`),
    INDEX `idx_authentication_type` (`authentication_type`),
    INDEX `idx_basic_and_bearer_authentication_method_type` (`basic_and_bearer_authentication_method_type`),
    INDEX `idx_oauth_authentication_grant_type` (`oauth_authentication_grant_type`),
    INDEX `idx_method_type` (`method_type`),
    INDEX `idx_response_type` (`response_type`),
    INDEX `idx_api_key_authentication_header_name` (`api_key_authentication_header_name`),
    INDEX `idx_basic_and_bearer_authentication_url` (`basic_and_bearer_authentication_url`),
    INDEX `idx_basic_and_bearer_authentication_expiration_buffer` (`basic_and_bearer_authentication_expiration_buffer`),
    INDEX `idx_oauth_authentication_token_url` (`oauth_authentication_token_url`),
    INDEX `idx_oauth_authentication_authorization_url` (`oauth_authentication_authorization_url`),
    INDEX `idx_oauth_authentication_redirect_url` (`oauth_authentication_redirect_url`),
    INDEX `idx_oauth_authentication_scope` (`oauth_authentication_scope`),
    INDEX `idx_oauth_authentication_expiration_buffer` (`oauth_authentication_expiration_buffer`),
    INDEX `idx_oauth_authentication_pkce_enabled` (`oauth_authentication_pkce_enabled`),
    INDEX `idx_url` (`url`),
    INDEX `idx_is_api_active` (`is_api_active`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `applications` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `application_type` VARCHAR(255) NOT NULL UNIQUE,
    `apis_name_health` VARCHAR(255) NOT NULL,
    `is_status_transition_notified_by_monitor` BOOLEAN NOT NULL DEFAULT FALSE,
    `is_application_active` BOOLEAN NOT NULL DEFAULT FALSE,
    `status_transition_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),

    FOREIGN KEY (`application_type`) REFERENCES `application_types`(`application_type`) ON DELETE CASCADE,
    FOREIGN KEY (`apis_name_health`) REFERENCES `apis`(`name`) ON DELETE CASCADE,

    INDEX `idx_application_type` (`application_type`),
    INDEX `idx_apis_name_health` (`apis_name_health`),
    INDEX `idx_is_status_transition_notified_by_monitor` (`is_status_transition_notified_by_monitor`),
    INDEX `idx_is_application_active` (`is_application_active`),
    INDEX `idx_status_transition_at` (`status_transition_at`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `databases` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) UNIQUE NOT NULL,
    `database_type` VARCHAR(255) NOT NULL,
    `host` LONGBLOB,
    `port` INT,
    `database` LONGBLOB,
    `username` LONGBLOB NOT NULL,
    `password` LONGBLOB NOT NULL,
    `connect_string` LONGBLOB,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),

    FOREIGN KEY (`database_type`) REFERENCES `database_types`(`database_type`) ON DELETE CASCADE,

    INDEX `idx_name` (`name`),
    INDEX `idx_database_type` (`database_type`),
    INDEX `idx_port` (`port`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `d_guard_servers` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `ip` VARCHAR(255) NOT NULL UNIQUE,
    `port` INT NOT NULL,
    `username` LONGBLOB NOT NULL,
    `password` LONGBLOB NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),

    INDEX `idx_ip` (`ip`),
    INDEX `idx_port` (`port`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `d_guard_layouts` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `guid` VARCHAR(255) NOT NULL,
    `server_id` INT NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),

    FOREIGN KEY (`server_id`) REFERENCES `d_guard_servers`(`id`) ON DELETE CASCADE,

    UNIQUE KEY `unique_guid_server_id` (`guid`, `server_id`),

    INDEX `idx_guid` (`guid`),
    INDEX `idx_server_id` (`server_id`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `d_guard_workstations` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `guid` VARCHAR(255) NOT NULL,
    `server_id` INT NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),

    FOREIGN KEY (`server_id`) REFERENCES `d_guard_servers`(`id`) ON DELETE CASCADE,

    UNIQUE KEY `unique_guid_server_id` (`guid`, `server_id`),

    INDEX `idx_guid` (`guid`),
    INDEX `idx_server_id` (`server_id`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `neppo_satisfaction_surveys` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `service_order_number` INT NOT NULL UNIQUE,
    `csid` INT NOT NULL,
    `phone` INT NOT NULL,
    `status` VARCHAR(255) NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CHECK (`status` IN ('failed', 'pending', 'sent')),

    PRIMARY KEY (`id`),

    INDEX `idx_service_order_number` (`service_order_number`),
    INDEX `idx_csid` (`csid`),
    INDEX `idx_phone` (`phone`),
    INDEX `idx_status` (`status`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `queries` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) UNIQUE NOT NULL,
    `group_name` VARCHAR(255),
    `databases_id` INT NOT NULL,
    `sql` LONGTEXT NOT NULL,
    `parameter_map` JSON,
    `is_query_active` BOOLEAN NOT NULL DEFAULT TRUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT `parameter_map` CHECK (JSON_TYPE(`parameter_map`) = 'OBJECT'),

    PRIMARY KEY (`id`),

    FOREIGN KEY (`databases_id`) REFERENCES `databases`(`id`) ON DELETE CASCADE,

    INDEX `idx_name` (`name`),
    INDEX `idx_group_name` (`group_name`),
    INDEX `idx_databases_id` (`databases_id`),
    INDEX `idx_is_query_active` (`is_query_active`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `users` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `application_type` VARCHAR(255) NOT NULL,
    `role_list` JSON NOT NULL,
    `username` VARCHAR(255) NOT NULL,
    `password` LONGBLOB NOT NULL,
    `is_user_active` BOOLEAN NOT NULL DEFAULT TRUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT `role_list` CHECK (JSON_TYPE(`role_list`) = 'ARRAY'),

    PRIMARY KEY (`id`),

    FOREIGN KEY (`application_type`) REFERENCES `application_types`(`application_type`) ON DELETE CASCADE,

    UNIQUE KEY `unique_application_type_username` (`application_type`, `username`),

    INDEX `idx_application_type` (`application_type`),
    INDEX `idx_username` (`username`),
    INDEX `idx_is_user_active` (`is_user_active`),
    INDEX `idx_created_at` (`created_at`),
    INDEX `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DELIMITER //


CREATE PROCEDURE `validate_api`(
    IN `name` VARCHAR(255),
    IN `authentication_type` VARCHAR(255),
    IN `basic_and_bearer_authentication_method_type` VARCHAR(255),
    IN `api_key_authentication_key` LONGBLOB,
    IN `api_key_authentication_header_name` VARCHAR(255),
    IN `basic_authentication_username` LONGBLOB,
    IN `basic_authentication_password` LONGBLOB,
    IN `basic_and_bearer_authentication_url` VARCHAR(255),
    IN `bearer_authentication_token` LONGBLOB,
    IN `oauth_authentication_client_id` LONGBLOB,
    OUT `is_valid` BOOLEAN,
    OUT `error_message` VARCHAR(255)
)
BEGIN
    SET `is_valid` = TRUE;
    SET `error_message` = NULL;
    
    IF `name` IN ('filterMap', 'globalReplacementMap') THEN
        SET `is_valid` = FALSE;
        SET `error_message` = 'Invalid name: Cannot be filterMap or globalReplacementMap';
    ELSE
        CASE `authentication_type`
            WHEN 'API Key' THEN
                IF `api_key_authentication_key` IS NULL OR `api_key_authentication_header_name` IS NULL THEN
                    SET `is_valid` = FALSE;
                    SET `error_message` = 'Invalid API Key authentication: Both key and header name are required';
                END IF;
            
            WHEN 'Basic' THEN
                IF `basic_authentication_username` IS NULL OR `basic_authentication_password` IS NULL THEN
                    SET `is_valid` = FALSE;
                    SET `error_message` = 'Invalid Basic authentication: Both username and password are required';
                END IF;
            
            WHEN 'Basic And Bearer' THEN
                IF `basic_and_bearer_authentication_method_type` IS NULL OR `basic_and_bearer_authentication_url` IS NULL THEN
                    SET `is_valid` = FALSE;
                    SET `error_message` = 'Invalid Basic And Bearer authentication: Both method type and URL are required';
                END IF;
            
            WHEN 'Bearer' THEN
                IF `bearer_authentication_token` IS NULL THEN
                    SET `is_valid` = FALSE;
                    SET `error_message` = 'Invalid Bearer authentication: Token is required';
                END IF;
            
            WHEN 'OAuth' THEN
                IF `oauth_authentication_client_id` IS NULL THEN
                    SET `is_valid` = FALSE;
                    SET `error_message` = 'Invalid OAuth authentication: Client ID is required';
                END IF;
        END CASE;
    END IF;
END;
//

CREATE PROCEDURE `validate_database`(
    IN `database_type` VARCHAR(50),
    IN `host` LONGBLOB,
    IN `database` LONGBLOB,
    IN `connect_string` LONGBLOB,
    OUT `is_valid` BOOLEAN,
    OUT `error_message` VARCHAR(255)
)
BEGIN
    SET `is_valid` = TRUE;
    SET `error_message` = NULL;
    
    CASE `database_type`
        WHEN 'Oracle' THEN
            IF `connect_string` IS NULL THEN
                SET `is_valid` = FALSE;
                SET `error_message` = 'Invalid database configuration: Connect string is required';
            END IF;
        
        WHEN 'MySQL' THEN
            IF `host` IS NULL OR `database` IS NULL THEN
                SET `is_valid` = FALSE;
                SET `error_message` = 'Invalid database configuration: Both host and database are required';
            END IF;
            
        WHEN 'SQL Server' THEN
            IF `host` IS NULL OR `database` IS NULL THEN
                SET `is_valid` = FALSE;
                SET `error_message` = 'Invalid database configuration: Both host and database are required';
            END IF;
    END CASE;
END;
//

CREATE PROCEDURE `validate_query`(
    IN `name` VARCHAR(255),
    OUT `is_valid` BOOLEAN,
    OUT `error_message` VARCHAR(255)
)
BEGIN
    SET `is_valid` = TRUE;
    SET `error_message` = NULL;
    
    IF `name` IN ('filterMap', 'globalReplacementMap') THEN
        SET `is_valid` = FALSE;
        SET `error_message` = 'Invalid name: Cannot be filterMap or globalReplacementMap';
    END IF;
END;
//

CREATE PROCEDURE `validate_user`(
    IN `role_list` JSON,
    OUT `is_valid` BOOLEAN,
    OUT `error_message` VARCHAR(255)
)
BEGIN
    DECLARE `index` INT DEFAULT 0;
    DECLARE `array_size` INT;
    DECLARE `current_role` VARCHAR(255);
    
    SET `is_valid` = TRUE;
    SET `error_message` = NULL;
    SET `array_size` = JSON_LENGTH(`role_list`);
      
    role_validation_loop: WHILE `index` < `array_size` DO
        SET `current_role` = JSON_UNQUOTE(JSON_EXTRACT(`role_list`, CONCAT('$[', `index`, ']')));

        IF NOT EXISTS (SELECT 1 FROM `role_types` WHERE `role_type` COLLATE utf8mb4_unicode_ci = `current_role`) THEN
            SET `is_valid` = FALSE;
            SET `error_message` = CONCAT('Invalid role_list: Role "', `current_role`, '" does not exist in the role_types table');
            
            LEAVE role_validation_loop;
        END IF;
        
        SET `index` = `index` + 1;
    END WHILE role_validation_loop;
END;
//


CREATE TRIGGER `before_apis_insert`
BEFORE INSERT ON `apis`
FOR EACH ROW
BEGIN
    DECLARE `is_valid` BOOLEAN DEFAULT TRUE;
    DECLARE `error_message` VARCHAR(255);
    
    CALL `validate_api`(
        NEW.`name`,
        NEW.`authentication_type`,
        NEW.`basic_and_bearer_authentication_method_type`,
        NEW.`api_key_authentication_key`,
        NEW.`api_key_authentication_header_name`,
        NEW.`basic_authentication_username`,
        NEW.`basic_authentication_password`,
        NEW.`basic_and_bearer_authentication_url`,
        NEW.`bearer_authentication_token`,
        NEW.`oauth_authentication_client_id`,
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
        NEW.`name`,
        NEW.`authentication_type`,
        NEW.`basic_and_bearer_authentication_method_type`,
        NEW.`api_key_authentication_key`,
        NEW.`api_key_authentication_header_name`,
        NEW.`basic_authentication_username`,
        NEW.`basic_authentication_password`,
        NEW.`basic_and_bearer_authentication_url`,
        NEW.`bearer_authentication_token`,
        NEW.`oauth_authentication_client_id`,
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

CREATE TRIGGER `before_queries_insert`
BEFORE INSERT ON `queries`
FOR EACH ROW
BEGIN
    DECLARE `is_valid` BOOLEAN DEFAULT TRUE;
    DECLARE `error_message` VARCHAR(255);

    CALL `validate_query`(
        NEW.`name`,
        `is_valid`,
        `error_message`
    );

    IF NOT `is_valid` THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = `error_message`;
    END IF;
END;
//

CREATE TRIGGER `before_queries_update`
BEFORE UPDATE ON `queries`
FOR EACH ROW
BEGIN
    DECLARE `is_valid` BOOLEAN DEFAULT TRUE;
    DECLARE `error_message` VARCHAR(255);

    CALL `validate_query`(
        NEW.`name`,
        `is_valid`,
        `error_message`
    );

    IF NOT `is_valid` THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = `error_message`;
    END IF;
END;
//

CREATE TRIGGER `before_users_insert`
BEFORE INSERT ON `users`
FOR EACH ROW
BEGIN
    DECLARE `is_valid` BOOLEAN DEFAULT TRUE;
    DECLARE `error_message` VARCHAR(255);

    CALL `validate_user`(
        NEW.`role_list`,
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
    DECLARE `is_valid` BOOLEAN DEFAULT TRUE;
    DECLARE `error_message` VARCHAR(255);

    CALL `validate_user`(
        NEW.`role_list`,
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
    ('sigma-cloud'),
    ('sigma-cloud-d-guard-integration');
    
INSERT INTO `authentication_types` (`authentication_type`)
VALUES
    ('API Key'),
    ('Basic'),
    ('Basic And Bearer'),
    ('Bearer'),
    ('OAuth');
    
INSERT INTO `database_types` (`database_type`)
VALUES
    ('MySQL'),
    ('Oracle'),
    ('SQL Server');

INSERT INTO `grant_types` (`grant_type`)
VALUES
    ('authorization_code'),
    ('client_credentials'),
    ('implicit'),
    ('password');

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
    ('authentication_types'),
    ('application_types'),
    ('database_types'),
    ('grant_types'),
    ('method_types'),
    ('response_types'),
    ('role_types'),
    ('table_types'),
    ('apis'),
    ('applications'),
    ('databases'),
    ('d_guard_servers'),
    ('d_guard_layouts'),
    ('d_guard_workstations'),
    ('neppo_satisfaction_surveys'),
    ('queries'),
    ('users');
    
   
INSERT INTO `apis`
    (
        `name`,
        `authentication_type`, 
        `basic_and_bearer_authentication_method_type`,
        `method_type`, 
        `response_type`, 
        `basic_authentication_username`,
        `basic_authentication_password`,
        `basic_and_bearer_authentication_url`,
        `basic_and_bearer_authentication_body`,
        `basic_and_bearer_authentication_token_extractor_list`,
        `basic_and_bearer_authentication_expiration_extractor_list`,
        `bearer_authentication_token`,
        `url`,
        `query_parameter_map`
    ) 
VALUES
    ('api-gateway-1', 'Basic And Bearer', 'get', 'get', 'json', 'ca2c1d83fa1607a35fdfa474cdc9bef3', 'a85186e0ea4ba06792c6b35314891f29', 'http://localhost:3043/api/v1/get/authentication', NULL, '["data", "data", "token"]', '["data", "data", "expiresIn"]', NULL, 'http://localhost:3043/api/v1/get/health', NULL),
    ('query-gateway-1', 'Basic And Bearer', 'get', 'get', 'json', 'ca2c1d83fa1607a35fdfa474cdc9bef3', 'a85186e0ea4ba06792c6b35314891f29', 'http://localhost:3042/api/v1/get/authentication', NULL, '["data", "data", "token"]', '["data", "data", "expiresIn"]', NULL, 'http://localhost:3042/api/v1/get/health', NULL),
    ('sigma-cloud-1', 'Basic And Bearer', 'get', 'get', 'json', 'ca2c1d83fa1607a35fdfa474cdc9bef3', 'a85186e0ea4ba06792c6b35314891f29', 'http://localhost:3120/api/v1/get/authentication', NULL, '["data", "data", "token"]', '["data", "data", "expiresIn"]', NULL, 'http://localhost:3120/api/v1/get/health', NULL),
    ('sigma-cloud-d-guard-integration-1', 'Basic And Bearer', 'get', 'get', 'json', 'ca2c1d83fa1607a35fdfa474cdc9bef3', 'a85186e0ea4ba06792c6b35314891f29', 'http://localhost:40001/api/v1/get/authentication', NULL, '["data", "data", "token"]', '["data", "data", "expiresIn"]', NULL, 'http://localhost:40001/api/v1/get/health', NULL);

INSERT INTO `applications` 
    (
        `application_type`,
        `apis_name_health`
    )
VALUES
    ('api-gateway', 'api-gateway-1'),
    ('query-gateway', 'query-gateway-1'),
    ('sigma-cloud', 'sigma-cloud-1'),
    ('sigma-cloud-d-guard-integration', 'sigma-cloud-d-guard-integration-1');

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
    ('ACS Acesso 1', 'SQL Server', 'b32965529d4f29f1920bb385b5aba1d7', 'a5b19cee9cd8139dfb5f4820aebbf6f5', '47f66a9e2bf5811d5473675825516017', 'ec750fd09a7ed9a921ce61a1a2f03062', NULL),
    ('ACS Acesso 2', 'SQL Server', '5f439e30a19d7a6dcad8b75414b41760', 'a5b19cee9cd8139dfb5f4820aebbf6f5', '47f66a9e2bf5811d5473675825516017', 'ec750fd09a7ed9a921ce61a1a2f03062', NULL),
    ('Sankhya', 'Oracle', NULL, NULL, '0e21567d4b80974b2d471d54affdb70f', 'e1e4af5bf201777f5550a2020ff49a23', '0fa78f3e627ac6bb731fd892920bf97320184a90c37b2ef7c51a5f892e70289f'),
    ('Sigma Desktop', 'SQL Server', '708efd977d452fd92c46a188b5a989b2', '6e2001fe8297b302d9f5ffa96f1ee9d1', '16f275e0b53e9257633dfd7e4bcdffb3', 'a9c893c42183c8c13bab11ebb91f9213e282d04bc3277d490b7e4b39106f2bc3', NULL),
    ('Three Mod', 'SQL Server', 'beb3b9160eeff099d03447343b7f4ab8', 'ba554a78b25e183bbea23deff2803145e50d5f57df882e0210b5080196b951aa', '47f66a9e2bf5811d5473675825516017', '62bbc23abfbb6ecf822043feb31c0f80', NULL);
    
INSERT INTO `d_guard_servers` 
    (
        `ip`, 
        `port`, 
        `username`, 
        `password`
    )
VALUES
    ('192.168.2.213', 8081, 'c84179ee093b1dae3c3a9af45a868c3e', '82fad325468a706b86066d0e989402fc'),
    ('192.168.2.214', 8081, 'c84179ee093b1dae3c3a9af45a868c3e', '82fad325468a706b86066d0e989402fc'),
    ('192.168.2.215', 8081, 'c84179ee093b1dae3c3a9af45a868c3e', '82fad325468a706b86066d0e989402fc'),
    ('192.168.2.216', 8081, 'c84179ee093b1dae3c3a9af45a868c3e', '82fad325468a706b86066d0e989402fc'),
    ('192.168.2.218', 8081, 'c84179ee093b1dae3c3a9af45a868c3e', '82fad325468a706b86066d0e989402fc'),
    ('192.168.2.219', 8081, 'c84179ee093b1dae3c3a9af45a868c3e', '82fad325468a706b86066d0e989402fc');

INSERT INTO `queries`
    (
        `name`, 
        `databases_id`, 
        `sql`,
        `is_query_active`
    ) 
VALUES
    ('acs_acesso_evento_1', 2, 'SELECT TOP 1000 * FROM dbo.EventoTransmitido WHERE CodigoAlarme = 417 AND csid = 0496 AND idEvento > (SELECT lastId FROM [dbo].[lastId] WHERE id = (SELECT MAX(id) FROM [dbo].[lastId]));', TRUE),
    ('acs_acesso_evento_2', 2, 'SELECT * FROM [dbo].[lastId];', TRUE),
    ('acs_acesso_evento_3', 2, 'UPDATE lastId SET lastId = @newId WHERE id = (SELECT MAX(id) FROM [dbo].[lastId]);', TRUE),
    ('acs_acesso_evento_4', 2, 'SELECT TOP 1000 * FROM dbo.EventoTransmitido et INNER JOIN ( SELECT TOP 1 lastOldId FROM dbo.oldEvents )  oe ON et.idEvento > oe.lastOldId WHERE et.DataRecepcao BETWEEN CONVERT(DATE,\'01-04-2025\', 105) AND CONVERT(DATE, \'13-05-2025\', 105) AND et.CodigoAlarme = 417 AND et.csid = 0496 ORDER BY et.idEvento DESC;', TRUE),
    ('acs_acesso_evento_5', 2, 'SELECT * FROM [dbo].[oldEvents];', TRUE),
    ('acs_acesso_evento_6', 2, 'UPDATE oldEvents SET lastOldId = @newId WHERE id = (SELECT MAX(id) FROM dbo.oldEvents);', TRUE),
    ('acs_acesso_evento_7', 2, 'SELECT TOP 1000 idEvento, Tipo, ClientId, StrEvento, csid, qualificador, CodigoAlarme, particao, usuarioZona, csidEnviado, CodigoAlarmeEnviado, ParticaoEnviada, UsuarioZonaEnviado, DataRecepcao, Bloqueado, Canal, Via, Linha, DataEnvio FROM [dbo].[EventoTransmitido] WHERE CodigoAlarme = 417 AND idEvento > (SELECT lastId FROM [dbo].[lastId] WHERE id = (SELECT MAX(id) FROM [dbo].[lastId]));', TRUE),
    ('acs_acesso_evento_8', 2, 'SELECT * FROM [dbo].[lastId];', TRUE),
    ('acs_acesso_evento_9', 2, 'UPDATE lastId SET lastId = @newId WHERE id = (SELECT MAX(id) FROM [dbo].[lastId]);', TRUE);

INSERT INTO `users`
    (
        `application_type`, 
        `role_list`, 
        `username`, 
        `password`, 
        `is_user_active`
    )
VALUES
    ('api-gateway', '["admin", "user"]', 'admin', '$2a$10$mwm596weoEp3WcyIgz1Gc.v/X4ahJmg/hsV6reNr6VLeEGcUhoQ/6', TRUE),
    ('api-gateway', '["user"]', 'user', '$2a$10$HB/w4Q8IonMozeujZguvE.fJX.pL28lw6sZcIesIYvdAY16HXMgMW', TRUE),
    ('query-gateway', '["admin", "user"]', 'admin', '$2a$10$mwm596weoEp3WcyIgz1Gc.v/X4ahJmg/hsV6reNr6VLeEGcUhoQ/6', TRUE),
    ('query-gateway', '["user"]', 'user', '$2a$10$HB/w4Q8IonMozeujZguvE.fJX.pL28lw6sZcIesIYvdAY16HXMgMW', TRUE),
    ('sigma-cloud', '["admin", "user"]', 'admin', '$2a$10$mwm596weoEp3WcyIgz1Gc.v/X4ahJmg/hsV6reNr6VLeEGcUhoQ/6', TRUE),
    ('sigma-cloud', '["user"]', 'user', '$2a$10$HB/w4Q8IonMozeujZguvE.fJX.pL28lw6sZcIesIYvdAY16HXMgMW', TRUE),
    ('sigma-cloud-d-guard-integration', '["admin", "user"]', 'admin', '$2a$10$mwm596weoEp3WcyIgz1Gc.v/X4ahJmg/hsV6reNr6VLeEGcUhoQ/6', TRUE),
    ('sigma-cloud-d-guard-integration', '["user"]', 'user', '$2a$10$HB/w4Q8IonMozeujZguvE.fJX.pL28lw6sZcIesIYvdAY16HXMgMW', TRUE);
    