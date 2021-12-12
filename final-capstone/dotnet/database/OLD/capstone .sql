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

IF OBJECT_ID ('users_properties')				IS NOT NULL DROP TABLE users_properties
IF OBJECT_ID ('users_maintenance_requests')		IS NOT NULL DROP TABLE users_maintenance_requests
IF OBJECT_ID ('maintenance_requests')			IS NOT NULL DROP TABLE maintenance_requests
IF OBJECT_ID ('users')							IS NOT NULL DROP TABLE users
IF OBJECT_ID ('properties')					    IS NOT NULL DROP TABLE properties
IF OBJECT_ID ('images')						    IS NOT NULL DROP TABLE images
IF OBJECT_ID ('unit')                           IS NOT NULL DROP TABLE unit
IF OBJECT_ID ('users_units')                    IS NOT NULL DROP TABLE users_units

-- --------------------------------------------------------------------------------
--	Create tables
-- --------------------------------------------------------------------------------
CREATE TABLE unit_images
(
	 image_id			  INT IDENTITY(1,1)  NOT NULL,
	 image_url			  VARCHAR(1000)	     NOT NULL,
	 description		  VARCHAR(1000),
	 unit_id              INT,
	 CONSTRAINT images_PK PRIMARY KEY (image_id)
)

CREATE TABLE properties
(
--rating question mark

	property_id			      INT IDENTITY(1,1) NOT NULL,
	property_name             VARCHAR(300)      NOT NULL,
	property_description      VARCHAR(500)      NOT NULL,  
	property_img		      VARCHAR(1000)     NOT NULL,
	address				      VARCHAR(200)	    NOT NULL,
	city					  VARCHAR(200)	    NOT NULL,
	state					  VARCHAR(200)	    NOT NULL,
	zip_code				  VARCHAR(200)	    NOT NULL,
	CONSTRAINT properties_PK PRIMARY KEY (property_id)
	
)

CREATE TABLE unit
(
	unit_id                   INT IDENTITY(1,1)     NOT NULL,
	bedroom_count             INT                   NOT NULL,
	bathroom_count            DECIMAL               NOT NULL,
	pet_friendly              BIT                   NOT NULL,
	non_smoking               BIT                   NOT NULL,
	pool_access               BIT                   NOT NULL,
	parking_spots             DECIMAL               NOT NULL,
	rent_amount				  DECIMAL				NOT NULL,
	is_rented			      BIT				    NOT NULL,
	rent_due_date			  VARCHAR(50)			NOT NULL,
	property_id               INT                   NOT NULL,
	CONSTRAINT unit_PK PRIMARY KEY (unit_id),
	FOREIGN KEY (property_id) REFERENCES properties (property_id)
)

CREATE TABLE users
(
	 user_id			 INT IDENTITY(1,1) NOT NULL,
	 username			 VARCHAR(200)	   NOT NULL,
	 password_hash		 VARCHAR(200)	   NOT NULL,
	 salt				 VARCHAR(200)	   NOT NULL,
	 user_role			 VARCHAR(50)	   NOT NULL,
   --,account_number	 VARCHAR(200)			
	 CONSTRAINT users_PK PRIMARY KEY (user_id)
)

CREATE TABLE maintenance_requests
(
	  maintenance_request_id		     INT IDENTITY(1,1) NOT NULL,
	  unit_id							 INT		       NOT NULL,
	  description						 VARCHAR(1500),			
	  is_completed						 BIT			   NOT NULL,
	 --,user_id                          INT               NOT NULL,
	  requester_user_id					 INT		       NOT NULL,
	  maintenance_user_id				 INT					
	  CONSTRAINT maintenance_requests_PK PRIMARY KEY (maintenance_request_id),
	  FOREIGN KEY (unit_id) REFERENCES unit (unit_id),
	  FOREIGN KEY (requester_user_id) REFERENCES users (user_id),
	  FOREIGN KEY (maintenance_user_id) REFERENCES users (user_id) 
)

--CREATE TABLE users_maintenance_requests
--(
--	 users_maintenance_requests_id				INT IDENTITY(1,1)	NOT NULL
--	,user_id									INTEGER				NOT NULL
--	,maintenance_request_id						INTEGER				NOT NULL
--	,CONSTRAINT users_maintenance_requests_PK	PRIMARY KEY (users_maintenance_requests_id)
--)

CREATE TABLE users_properties
(
	 user_properties_id				INT IDENTITY(1,1) NOT NULL,
	 user_id						INT				  NOT NULL,
	 property_id					INT				  NOT NULL,
	 CONSTRAINT users_properties_PK PRIMARY KEY (user_properties_id)
)

CREATE TABLE users_units
(
	--user_id references the renter attached to this unit
	user_unit_id            INT IDENTITY(1,1) NOT NULL,
	user_id                 INT               NOT NULL,
	unit_id                 INT               NOT NULL,
	CONSTRAINT user_unit_id PRIMARY KEY (user_unit_id),
	FOREIGN KEY (user_id) REFERENCES users (user_id),
	FOREIGN KEY (unit_id) REFERENCES unit (unit_id)
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

---- 3
--ALTER TABLE users_maintenance_requests ADD CONSTRAINT users_maintenanceRequests_users_FK1
--FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE

---- 4
--ALTER TABLE users_maintenance_requests ADD CONSTRAINT users_maintenanceRequests_maintenance_requests_FK1
--FOREIGN KEY (maintenance_request_id) REFERENCES maintenance_requests (maintenance_request_id) ON DELETE CASCADE

---- 5
--ALTER TABLE maintenance_requests ADD CONSTRAINT maintenance_requests_properties_FK1
--FOREIGN KEY (property_id) REFERENCES properties (property_id) ON DELETE CASCADE,
--FOREIGN KEY (requester_user_id) REFERENCES users (user_id) ON DELETE CASCADE,
--FOREIGN KEY (maintenance_user_id) REFERENCES users (user_id) ON DELETE CASCADE

-- 6
ALTER TABLE unit_images ADD CONSTRAINT images_unit_FK1
FOREIGN KEY (unit_id) REFERENCES unit (unit_id) ON DELETE CASCADE

-- --------------------------------------------------------------------------------
--	INSERTS
-- --------------------------------------------------------------------------------
INSERT INTO 
	properties (property_name, property_description, property_img,  address, city, state, zip_code)
VALUES 
	('sample name', 'sample description', 'https://www.cprealestate.com/shared/fs/0543/company/shutterstock_213290023%20%281%29.jpg', 'sample addy', 'sample city', 'sample state', 'sample zip'),
	('Steeple Chase', 'Apartment complex that has nice ponds', 'https://cdngeneralcf.rentcafe.com/dmslivecafe/3/50497/70590713_2557871087604384_3601364742377046016_o.jpg?&quality=85&width=956&height=717&mode=crop', '3219 Steeple Chase Ln', 'Loveland', 'OH', '45140'),
  ('Corner House', 'Four bedroom House', 'https://resources.stuff.co.nz/content/dam/images/1/z/i/f/b/u/image.related.StuffLandscapeThreeByTwo.1464x976.1xiv2f.png/1584385031980.jpg', '176 StoneRidge Blvd', 'South Lebanon', 'OH', '45065'),
	('Beach House', 'Beach House, private beach access', 'https://www.mymove.com/wp-content/uploads/2013/08/GettyImages-200181509-001-scaled.jpg', '627 Cherry Grove St', 'Casper', 'SC', '78140'),
	('Afordable Houseing', 'Apartment complex for the poor', 'https://blackthen.com/wp-content/uploads/2015/06/cabrini-green.jpg', '983 Georgey Rows Ave', 'NY', 'NY', '2341'),
	('Lake House', ' House on the lake, access to a boat dock', 'https://www.cprealestate.com/shared/fs/0543/company/shutterstock_213290023%20%281%29.jpg', '436 Anchor BLVD', 'Alpena', 'MI', '6754')

INSERT INTO 
	unit (bedroom_count, bathroom_count, pet_friendly, non_smoking, pool_access, parking_spots, rent_amount, is_rented, rent_due_date, property_id)
VALUES 
	(1, 1, 0, 1, 0, 0, 420, 0, '15th', 1),
    (2, 1.5, 1, 1, 1, 2, 920, 0, '25th', 2),
    (1, 1, 1, 1, 1, 1, 720, 1, '25th', 2),
    (4, 3.5, 1, 1, 0, 4, 2200, 0, '4th', 3),
    (3, 2, 0, 0, 0, 2, 2500, 1, '12', 4),
	(2, 1, 0, 1, 0, 0, 400, 0, '1st', 5),
    (2, 1, 0, 1, 0, 0, 400, 0, '1st', 5),
	(1, 1, 0, 1, 0, 0, 320, 0, '1st', 5),
	(1, 1, 0, 1, 0, 0, 320, 0, '1st', 5),
	(4, 2.5, 1, 1, 0, 3, 2600, 0, '25th', 6)

INSERT INTO 
	unit_images (image_url, description, unit_id)
VALUES 
	('https://i.imgur.com/eyhMgSx.png', 'OH GOD WHAT IS THAT', 1),
	('https://www.arkbh.com/wp-content/uploads/2021/01/crack_houses-1024x640.jpg', 'Affordable housing img', 5)

INSERT INTO 
	users (username, password_hash, salt, user_role)
VALUES 
	('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','User'),
	('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Admin'),
	('DFox96','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Renter'),
	('LawDog','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Renter'),
	('FISHIE','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Renter'),
	('BQ','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Employee'),
	('Mercado','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Employee')
				 
INSERT INTO 
	maintenance_requests (unit_id, description, is_completed, requester_user_id, maintenance_user_id)
VALUES	 
	(1, 'sample maintenance request description', 0, 1, 1),
	(2, 'leaky bathroom ceiling', 0, 3, 6),
	(3, 'Toilet is loud', 0, 3, 7),
	(3, 'Replace front door lock', 0, 4, 7)

INSERT INTO 
	users_properties (user_id, property_id)
VALUES
	(3, 3),
	(5, 4)

INSERT INTO 
	users_units (user_id, unit_id)
VALUES 
	(3, 2),
	(4, 2),
	(5, 4)
					
--INSERT INTO users_maintenance_requests (user_id, maintenance_request_id)
--VALUES			 (1, 1)

