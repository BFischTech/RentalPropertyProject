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

IF OBJECT_ID ('properties')                 IS NOT NULL DROP TABLE properties
IF OBJECT_ID ('units')                      IS NOT NULL DROP TABLE units
IF OBJECT_ID ('amenities')                  IS NOT NULL DROP TABLE amenities
IF OBJECT_ID ('maintenance_requests')       IS NOT NULL DROP TABLE maintenance_requests
IF OBJECT_ID ('users')                      IS NOT NULL DROP TABLE users
IF OBJECT_ID ('tenant')                     IS NOT NULL DROP TABLE tenant
IF OBJECT_ID ('owner')                      IS NOT NULL DROP TABLE owner
IF OBJECT_ID ('employee')                   IS NOT NULL DROP TABLE employee
IF OBJECT_ID ('unit_images')                IS NOT NULL DROP TABLE unit_images
IF OBJECT_ID ('unit_types')                 IS NOT NULL DROP TABLE unit_types
IF OBJECT_ID ('maintenance_request_types')  IS NOT NULL DROP TABLE maintenance_request_types
IF OBJECT_ID ('maintenance_request_status') IS NOT NULL DROP TABLE maintenance_request_status

-- --------------------------------------------------------------------------------
--	Create tables
-- --------------------------------------------------------------------------------
CREATE TABLE [users] (
	user_id         INT IDENTITY(1,1) NOT NULL,
	username        VARCHAR(200)      NOT NULL,
	password_hash   VARCHAR(200)      NOT NULL,
	salt            VARCHAR(200)      NOT NULL,
	user_role       VARCHAR(50)       NOT NULL,	

	CONSTRAINT [users_PK] PRIMARY KEY (user_id)
);

CREATE TABLE [owner] (
  owner_id            INT           NOT NULL,
  first_name          VARCHAR(255)  NOT NULL,
  last_name           VARCHAR(255)  NOT NULL,
  email               VARCHAR(255)  NOT NULL,
  mobile_number       VARCHAR(255)  NOT NULL,

  CONSTRAINT [PK_owner_id] PRIMARY KEY (owner_id),
  CONSTRAINT [FK_owner_id] FOREIGN KEY (owner_id) REFERENCES [users] (user_id)
);

CREATE TABLE [employee] (
  employee_id         INT           NOT NULL,
  first_name          VARCHAR(255)  NOT NULL,
  last_name           VARCHAR(255)  NOT NULL,
  email               VARCHAR(255)  NOT NULL,
  mobile_number       VARCHAR(255)  NOT NULL,

  CONSTRAINT [PK_employee_id] PRIMARY KEY (employee_id),
  CONSTRAINT [FK_employee_id] FOREIGN KEY (employee_id) REFERENCES [users] (user_id)
);

CREATE TABLE [properties] (
  property_id     INT IDENTITY(1,1) NOT NULL,
  name            VARCHAR(255)      NOT NULL,
  description     VARCHAR(500)      NOT NULL,
  address         VARCHAR(255)      NOT NULL,
  city            VARCHAR(255)      NOT NULL,
  state           VARCHAR(255)      NOT NULL,
  zip_code        VARCHAR(255)      NOT NULL,
  image_url       VARCHAR(MAX)      NOT NULL DEFAULT 'https://www.pngfind.com/pngs/m/156-1568188_blank-house-cliparts-plain-house-clipart-hd-png.png',
  owner_id        INT               NOT NULL,
  CONSTRAINT [PK_property_id] PRIMARY KEY (property_id),
  CONSTRAINT [FK_properties_owner_id] FOREIGN KEY (owner_id) REFERENCES [owner] (owner_id)
);

-- 1: House, 
-- 2: Apartment, 
-- 3: Condo
CREATE TABLE [unit_types] (
  unit_type_id    INT          NOT NULL,
  unit_type_name  VARCHAR(255) NOT NULL,

  CONSTRAINT [PK_unit_type_id_unit_type_name] PRIMARY KEY (unit_type_id)
);

CREATE TABLE [units] (
  unit_id                  INT IDENTITY(1,1) NOT NULL,
  property_id              INT               NOT NULL,
  unit_type_id             INT               NOT NULL,
  rent_amount              DECIMAL           NOT NULL,
  is_rented                BIT               NOT NULL DEFAULT 0,
  rent_due_date            INT               NOT NULL DEFAULT 15,
  
  CONSTRAINT [PK_unit_id] PRIMARY KEY (unit_id),
  CONSTRAINT [FK_property_id] FOREIGN KEY (property_id) REFERENCES [properties] (property_id),
  CONSTRAINT [FK_unit_type_id] FOREIGN KEY (unit_type_id) REFERENCES [unit_types] (unit_type_id)
);

CREATE TABLE [unit_location] (
  unit_location_id      INT NOT NULL,
  unit_building_number  INT NOT NULL DEFAULT 0,
  unit_number           VARCHAR(255) ,
  unit_street_address   VARCHAR(255) NOT NULL,
  unit_city             VARCHAR(255) NOT NULL,
  unit_state            VARCHAR(255) NOT NULL,
  unit_zip_code         VARCHAR(255) NOT NULL, 

  CONSTRAINT [PK_unit_location_id] PRIMARY KEY (unit_location_id),
  CONSTRAINT [FK_unit_location_id] FOREIGN KEY (unit_location_id) REFERENCES [units] (unit_id),           
);

CREATE TABLE [unit_images] (
  image_id        INT IDENTITY(1,1) NOT NULL,
  unit_id         INT               NOT NULL,
  image_url       VARCHAR(MAX)      NOT NULL CHECK (image_url=null) DEFAULT 'https://www.pngfind.com/pngs/m/156-1568188_blank-house-cliparts-plain-house-clipart-hd-png.png',
  image_caption   VARCHAR(255)      DEFAULT 'Insert Image Please!',

  CONSTRAINT [PK_image_id] PRIMARY KEY (image_id),
  CONSTRAINT [FK_unit_images_unit_id] FOREIGN KEY (unit_id) REFERENCES [units] (unit_id),
);


CREATE TABLE [amenities] (
  amenities_id      INT IDENTITY(1,1) NOT NULL,
  unit_id           INT               NOT NULL,
  bedroom_count     INT               NOT NULL,
  bathroom_count    DECIMAL           NOT NULL,
  pet_allowed       BIT               NOT NULL DEFAULT 0,
  smoking_allowed   BIT               NOT NULL DEFAULT 0,
  pool_access       BIT               NOT NULL DEFAULT 0,
  parking_spots     INT               NOT NULL,

  CONSTRAINT [PK_amenities_id] PRIMARY KEY (amenities_id),
  CONSTRAINT [FK_amenities_unit_id] FOREIGN KEY (unit_id) REFERENCES [units] (unit_id)
);

CREATE TABLE [tenant] (
  tenant_id       INT           NOT NULL,
  unit_rented_id  INT           NOT NULL,
  first_name      VARCHAR(255)  NOT NULL,
  last_name       VARCHAR(255)  NOT NULL,
  email           VARCHAR(255)  NOT NULL,
  mobile_number   VARCHAR(255)  NOT NULL,
  
  CONSTRAINT [PK_tenant_id] PRIMARY KEY (tenant_id),
  CONSTRAINT [FK_tenant_id] FOREIGN KEY (tenant_id) REFERENCES [users] (user_id),
  CONSTRAINT [FK_unit_rented_id] FOREIGN KEY (unit_rented_id) REFERENCES [units] (unit_id)
);

-- Tiles, Drywall, Electrical, Fences, Painting, Plumbing, etc..., Others
CREATE TABLE [maintenance_request_types] (
  maintenance_request_type_id     INT          NOT NULL,
  maintenance_request_type_name   VARCHAR(255) NOT NULL,

  CONSTRAINT [PK_maintenance_request_type_id] PRIMARY KEY (maintenance_request_type_id)
);

-- Pending, Cancel, Completed
CREATE TABLE [maintenance_request_status] (
  maintenance_request_status_id     INT          NOT NULL,
  maintenance_request_status_name   VARCHAR(255) NOT NULL,

  CONSTRAINT [PK_maintenance_request_status_id] PRIMARY KEY (maintenance_request_status_id)
);

CREATE TABLE [maintenance_requests] (
  maintenance_request_id    INT IDENTITY(1,1) NOT NULL,
  tenant_id                 INT               NOT NULL,
  request_type_id           INT               NOT NULL,
  concern                   VARCHAR(MAX)      NOT NULL,
  request_date_time         DATETIME          NOT NULL DEFAULT GETDATE(),
  request_status_id         INT               NOT NULL,
  employee_assigned_id		  INT	,			  		

  CONSTRAINT [PK_maintenance_request_id] PRIMARY KEY (maintenance_request_id),
  CONSTRAINT [FK_maintenance_request_tenant_id] FOREIGN KEY (tenant_id) REFERENCES [tenant] (tenant_id),
  CONSTRAINT [FK_request_type_id] FOREIGN KEY (request_type_id) REFERENCES [maintenance_request_types] (maintenance_request_type_id),
  CONSTRAINT [FK_request_status_id] FOREIGN KEY (request_status_id) REFERENCES [maintenance_request_status] (maintenance_request_status_id),
  CONSTRAINT [FK_maintenance_request_employee_id] FOREIGN KEY (employee_assigned_id) REFERENCES [employee] (employee_id),

);

-- --------------------------------------------------------------------------------
--	INSERTS
-- --------------------------------------------------------------------------------
INSERT INTO [users] 
  (username, password_hash, salt, user_role)
VALUES 
	('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','User'),
	('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Admin'),
	('DFox96','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
	('LawDog','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
	('FISHIE','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
	('BQ','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
	('Mercado','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Employee');


INSERT INTO [owner] 
  (owner_id, first_name, last_name, email, mobile_number)
VALUES	 
	(2, 'Joe', 'Riggs', 'jr@gmail.com', '5132341234'),
  (1, 'Mike', 'Jordan', 'mj@gmail.com', '5132341234');

INSERT INTO [employee] 
  (employee_id, first_name, last_name, email, mobile_number)
VALUES	 
	(7, 'Clark', 'Mercado', 'cm@gmail.com', '5132341234');
  

INSERT INTO [unit_types] 
  (unit_type_id, unit_type_name)
VALUES	 
  (1, 'House'),
  (2, 'Apartment'),
  (3, 'Condominium');

INSERT INTO [maintenance_request_types] 
  (maintenance_request_type_id, maintenance_request_type_name)
VALUES 
  (1, 'Electrical'),
  (2, 'Fences'),
  (3, 'Painting'),
  (4, 'Plumbing'),
  (5, 'Drywall'),
  (6, 'Others');

INSERT INTO [maintenance_request_status] 
  (maintenance_request_status_id, maintenance_request_status_name)
VALUES	 
	(1, 'Pending'),
	(2, 'Cancelled'),
	(3, 'Completed');

INSERT INTO [properties] 
  (name, description, address, city, state, zip_code, image_url, owner_id)
VALUES 
  ('sample name', 'sample description', 'sample addy', 'sample city', 'sample state', 'sample zip', 'https://www.cprealestate.com/shared/fs/0543/company/shutterstock_213290023%20%281%29.jpg', 1),
  ('Steeple Chase', 'Apartment complex that has nice ponds', '3219 Steeple Chase Ln', 'Loveland', 'OH', '45140' , 'https://cdngeneralcf.rentcafe.com/dmslivecafe/3/50497/70590713_2557871087604384_3601364742377046016_o.jpg?&quality=85&width=956&height=717&mode=crop', 2),
  ('Corner House', 'Four bedroom House', '176 StoneRidge Blvd', 'South Lebanon', 'OH', '45065', 'https://resources.stuff.co.nz/content/dam/images/1/z/i/f/b/u/image.related.StuffLandscapeThreeByTwo.1464x976.1xiv2f.png/1584385031980.jpg', 2),
  ('Beach House', 'Beach House, private beach access', '627 Cherry Grove St', 'Casper', 'SC', '78140', 'https://www.mymove.com/wp-content/uploads/2013/08/GettyImages-200181509-001-scaled.jpg', 1),
  ('Afordable Houseing', 'Apartment complex for the poor', '983 Georgey Rows Ave', 'NY', 'NY', '2341', 'https://blackthen.com/wp-content/uploads/2015/06/cabrini-green.jpg', 2),
  ('Lake House', ' House on the lake, access to a boat dock', '436 Anchor BLVD', 'Alpena', 'MI', '6754', 'https://www.cprealestate.com/shared/fs/0543/company/shutterstock_213290023%20%281%29.jpg', 2);

INSERT INTO [units] 
  (property_id, unit_type_id, rent_amount, is_rented, rent_due_date)
VALUES 
  (1, 1, 420,  0, '15th'),
  (2, 1, 920,  0, '25th'),
  (2, 2, 720,  1, '25th'),
  (3, 3, 2200, 0, '4th'),
  (4, 1, 2500, 1, '12'),
  (1, 2, 400,  0, '1st'),
  (1, 2, 400,  0, '1st'),
  (1, 1, 320,  0, '1st'),
  (2, 3, 320,  0, '1st'),
  (3, 2, 2600, 0, '25th');

INSERT INTO [amenities] 
  (unit_id, bedroom_count, bathroom_count, pet_allowed, smoking_allowed, pool_access, parking_spots)
VALUES 
  (1,  1, 1,   0, 1, 0, 0),
  (2,  2, 1.5, 1, 1, 1, 2),
  (3,  1, 1,   1, 1, 1, 1),
  (4,  4, 3.5, 1, 1, 0, 4),
  (5,  3, 2,   0, 0, 0, 2),
  (6,  2, 1,   0, 1, 0, 0),
  (7,  2, 1,   0, 1, 0, 1),
  (8,  1, 1,   0, 1, 0, 0),
  (9,  1, 1,   0, 1, 0, 0),
  (10, 1, 2.5, 1, 1, 0, 3);

INSERT INTO [tenant] 
  (tenant_id, unit_rented_id, first_name, last_name, email, mobile_number)
VALUES	 
  (6, 2, 'Dustin', 'Fox', 'dustin@gmail.com', '5132341234'),
  (5, 4, 'Bradley', 'Fisch', 'fish@gmail.com', '513233434'),
  (3, 3, 'Matthew', 'Lawson', 'Matt.L@gmail.com', '5132341234'),
  (4, 6, 'Bradley', 'Quinton', 'BQ@gmail.com', '5132341234');

INSERT INTO [maintenance_requests] 
  (tenant_id, request_type_id, concern, request_status_id)
VALUES	 
	(6, 2, 'sample maintenance request description', 1),
	(5, 3, 'leaky bathroom ceiling', 2);
	
INSERT INTO [maintenance_requests] 
  (tenant_id, request_type_id, concern, request_status_id, employee_assigned_id)
VALUES	 
	
	(3, 1, 'Toilet is loud', 3, 7),
	(3, 6, 'Replace front door lock', 1, 7);


INSERT INTO [unit_images] 
  (unit_id, image_url, image_caption)
VALUES 
	(2, 'https://i.imgur.com/eyhMgSx.png', 'OH GOD WHAT IS THAT'),
	(9, 'https://www.arkbh.com/wp-content/uploads/2021/01/crack_houses-1024x640.jpg', 'Affordable housing img');

INSERT INTO [unit_images] 
  (unit_id, image_caption)
VALUES 
	(1, 'blank default img url'),
	(3, 'blank default img url'),
	(4, 'blank default img url'),
	(5, 'blank default img url');

INSERT INTO [unit_location] 
  (unit_location_id, unit_building_number, unit_number, unit_street_address, unit_city, unit_state, unit_zip_code)
VALUES 
  (1,  '0', '0',   '6711 Fayetta Drive',         'Hamilton',      'OH', '45011'),
  (2,  '0', '0',   '6989 Sleepy Chase Ln',       'Loveland',      'OH', '45140'),
  (3,  '2', '101', '176 StoneRidge Blvd',        'South Lebanon', 'OH', '45065'),
  (4,  '1', '305', '627 Cherry Grove St',        'Casper',        'SC', '78140'),
  (5,  '0', '0',   '983 Georgey Rows Ave',       'NY',            'NY', '2341'),
  (6,  '2', '102', '176 StoneRidge Blvd',        'Alpena',        'MI', '6754'),
  (7,  '3', '101', '3219 Steeple Chase Ln',      'Loveland',      'OH', '45140'),
  (8,  '0', '0',   '911 RollongStone Blvd',      'South Lebanon', 'OH', '45065'),
  (9,  '3', '606', '627 Cherry Grove St',        'Casper',        'SC', '78140'),
  (10, '0', '6',   '983 Georgey Rows Ave',       'NY',            'NY', '2341');