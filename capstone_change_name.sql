-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE master;
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
--						 
-- --------------------------------------------------------------------------------
IF DB_ID('final_capstone') IS NOT NULL
BEGIN
	ALTER DATABASE final_capstone SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE final_capstone;
END

CREATE DATABASE final_capstone
GO

USE final_capstone
GO

-- --------------------------------------------------------------------------------
--						 
-- --------------------------------------------------------------------------------

-- Drop Table Statements (drop children first)

IF OBJECT_ID ('users_properties')					IS NOT NULL DROP TABLE users_properties
IF OBJECT_ID ('users_maintenance_requests')			IS NOT NULL DROP TABLE users_maintenance_requests
IF OBJECT_ID ('maintenance_requests')				IS NOT NULL DROP TABLE maintenance_requests
IF OBJECT_ID ('users')								IS NOT NULL DROP TABLE users
IF OBJECT_ID ('properties')							IS NOT NULL DROP TABLE properties
IF OBJECT_ID ('images')								IS NOT NULL DROP TABLE images

-- --------------------------------------------------------------------------------
--	Create tables
-- --------------------------------------------------------------------------------

CREATE TABLE images
(
	  image_id							INT IDENTITY(1,1)			NOT NULL
	 ,image_url						    VARCHAR(1000)				NOT NULL
	 ,description						VARCHAR(1000)               
	 ,property_id                       int                         NOT NULL
	 ,CONSTRAINT images_PK				PRIMARY KEY (image_id)
)



CREATE TABLE properties
(
	 property_id						INT IDENTITY(1,1)		NOT NULL
	,address							VARCHAR(200)			NOT NULL
	,city								VARCHAR(200)			NOT NULL
	,state								VARCHAR(200)			NOT NULL
	,zip_code							VARCHAR(200)			NOT NULL
	,unit								VARCHAR(200)			NOT NULL
	,rent_amount						DECIMAL				    NOT NULL
	,is_rented							BIT						NOT NULL
	,rent_due_date						VARCHAR(50)				NOT NULL
	,CONSTRAINT properties_PK			PRIMARY KEY (property_id)
)

CREATE TABLE users
(
	 user_id							INT IDENTITY(1,1)		NOT NULL
	,username							VARCHAR(200)			NOT NULL
	,password_hash						VARCHAR(200)			NOT NULL
	,salt								VARCHAR(200)			NOT NULL
	,user_role							VARCHAR(50)				NOT NULL
  --,account_number						VARCHAR(200)			
	,CONSTRAINT users_PK				PRIMARY KEY (user_id)
)

CREATE TABLE maintenance_requests
(
	  maintenance_request_id					INT IDENTITY(1,1)		NOT NULL
	 ,property_id								INTEGER					NOT NULL
	 ,description								VARCHAR(1500)			
	 ,is_completed								BIT						NOT NULL
	 ,user_id                                   INT                     NOT NULL
	 --,requester_user_id						INTEGER					NOT NULL
	 --,maintenance_user_id						INTEGER					
	 ,CONSTRAINT maintenance_requests_PK		PRIMARY KEY (maintenance_request_id)
)


CREATE TABLE users_maintenance_requests
(
	 users_maintenance_requests_id				INT IDENTITY(1,1)	NOT NULL
	,user_id									INTEGER				NOT NULL
	,maintenance_request_id						INTEGER				NOT NULL
	,CONSTRAINT users_maintenance_requests_PK	PRIMARY KEY (users_maintenance_requests_id)
)

CREATE TABLE users_properties
(
	 user_properties_id							INT IDENTITY(1,1)	NOT NULL
	,user_id									INTEGER				NOT NULL
	,property_id								INTEGER				NOT NULL
	,CONSTRAINT users_properties_PK				PRIMARY KEY (user_properties_id)
)


-- --------------------------------------------------------------------------------
--	Create relationships. Foreign Keys.
-- --------------------------------------------------------------------------------
--		Child						Parent					Column
--      -----						------					---------
--	1	users_properties			users					user_id
--  2   users_properties			properties				property_id
--  3   users_maintenance_requests	users					user_id
--  4   users_maintenance_requests	maintenance_requests	maintenance_requestID
--  5   maintenance_requests		maintenance_requests	maintenance_requestID


--  6   Images                      Properties              propertyID

--ALTER TABLE <Child Table> ADD CONSTRAINT <Child Table>_<Parent Table>_FK1
--FOREIGN KEY ( <Child column> ) REFERENCES <Parent Table> ( <Parent column> )


-- 1
ALTER TABLE users_properties ADD CONSTRAINT users_properties_users_FK1
FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE

-- 2
ALTER TABLE users_properties ADD CONSTRAINT users_properties_properties_FK1
FOREIGN KEY (property_id) REFERENCES properties (property_id) ON DELETE CASCADE

-- 3
ALTER TABLE users_maintenance_requests ADD CONSTRAINT users_maintenanceRequests_users_FK1
FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE

-- 4
ALTER TABLE users_maintenance_requests ADD CONSTRAINT users_maintenanceRequests_maintenance_requests_FK1
FOREIGN KEY (maintenance_request_id) REFERENCES maintenance_requests (maintenance_request_id) ON DELETE CASCADE

-- 5
ALTER TABLE maintenance_requests ADD CONSTRAINT maintenance_requests_properties_FK1
FOREIGN KEY (property_id) REFERENCES properties (property_id) ON DELETE CASCADE

-- 6
ALTER TABLE images ADD CONSTRAINT images_properties_FK1
FOREIGN KEY (property_id) REFERENCES properties (property_id) ON DELETE CASCADE

-- --------------------------------------------------------------------------------
--	INSERTS
-- --------------------------------------------------------------------------------



INSERT INTO properties (address, city, state, zip_code, unit, rent_amount, is_rented, rent_due_date)
VALUES				 ('sample addy', 'sample city', 'sample state', 'sample zip', 'sample unit', 1000.00, 1, '15th')


INSERT INTO images (image_url, description, property_id)
VALUES			   ('https://i.imgur.com/eyhMgSx.png', 'OH GOD WHAT IS THAT', 1)


INSERT INTO users (username, password_hash, salt, user_role)
VALUES			 ('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','user')
				,('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin')


INSERT INTO maintenance_requests (property_id, description, is_completed, user_id)
VALUES			 (1, 'sample maintenance request description', 0, 1)


INSERT INTO users_properties (user_id, property_id)
VALUES			 (1, 1)


INSERT INTO users_maintenance_requests (user_id, maintenance_request_id)
VALUES			 (1, 1)

