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
  unit_rented_id  INT,
  first_name      VARCHAR(255),
  last_name       VARCHAR(255),
  email           VARCHAR(255),
  mobile_number   VARCHAR(255),
  
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
	('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Admin'),
  ('owner1','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Owner'),
	('owner2','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Owner'),
	('owner3','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Owner'),
  ('owner4','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Owner'),
	('owner5','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Owner'),
  ('employee1','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Employee'),
  ('employee2','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Employee'),
	('employee3','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Employee'),
	('user1','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','User'),
  ('user2','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','User'),
  ('user3','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','User'),
  ('user4','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','User'),
	('tenant1','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
  ('tenant2','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
	('tenant3','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
  ('tenant4','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
  ('tenant5','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
	('tenant6','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
  ('tenant7','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
  ('tenant8','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
	('tenant9','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
  ('tenant10','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant');


INSERT INTO [owner] 
  (owner_id, first_name, last_name, email, mobile_number)
VALUES	 
	(2, 'Bradley', 'Fisch', 'FischBradley@localhost.com', '5131234567'),
  (3, 'Bradley', 'Quinton', 'QuintonBradley@localhost.com', '5131234567'),
  (4, 'Dustin', 'Fox', 'FoxDustin@localhost.com', '5131234567'),
  (5, 'Matthew', 'Lawson', 'LawsonMatthew@localhost.com', '5131234567'),
  (6, 'Joe', 'Riggs', 'RiggsJoe@localhost.com', '5131234567');

INSERT INTO [employee] 
  (employee_id, first_name, last_name, email, mobile_number)
VALUES	 
	(7, 'Clark', 'Mercado', 'MercadoClark@localhost.com', '5131234567'),
  (8, 'Jhorel', 'Mercado', 'JhorelMercado@localhost.com', '5131234567'),
  (9, 'Juan', 'Perez', 'PerezJuan@localhost.com', '5131234567');
  
INSERT INTO [unit_types] 
  (unit_type_id, unit_type_name)
VALUES	 
  (1, 'House'),
  (2, 'Apartment'),
  (3, 'Condo');

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
  ('BQ Real Estate', 'BQ Real Estate is a residential property management company...', '4025 Lakeside Drive', 'Cincinnati', 'OH', '45100', 'https://www.cprealestate.com/shared/fs/0543/company/shutterstock_213290023%20%281%29.jpg', 6),
  ('Fish Properties', 'Settle in somewhere new. Discover stays to live, work, or just relax', '3219 Steeple Chase Ln', 'Loveland', 'OH', '45140' , 'https://cdngeneralcf.rentcafe.com/dmslivecafe/3/50497/70590713_2557871087604384_3601364742377046016_o.jpg?&quality=85&width=956&height=717&mode=crop', 2),
  ('StateBarn Estate', 'THe quick brown fox jumps over the lazy dog', '176 StoneRidge Blvd', 'South Lebanon', 'OH', '45065', 'https://resources.stuff.co.nz/content/dam/images/1/z/i/f/b/u/image.related.StuffLandscapeThreeByTwo.1464x976.1xiv2f.png/1584385031980.jpg', 3),
  ('Zillow', 'Beach House, private beach access', '627 Cherry Grove St', 'Casper', 'SC', '78140', 'https://www.mymove.com/wp-content/uploads/2013/08/GettyImages-200181509-001-scaled.jpg', 4),
  ('Ayala Properties', 'Apartment complex for the poor', '983 Georgey Rows Ave', 'NY', 'NY', '2341', 'https://blackthen.com/wp-content/uploads/2015/06/cabrini-green.jpg', 5),
  ('Lake House', ' House on the lake, access to a boat dock', '436 Anchor BLVD', 'Alpena', 'MI', '6754', 'https://www.cprealestate.com/shared/fs/0543/company/shutterstock_213290023%20%281%29.jpg', 6);

INSERT INTO [units] 
  (property_id, unit_type_id, rent_amount, is_rented, rent_due_date)
VALUES 
  (1, 1, 420,  0, 15),
  (2, 1, 920,  0, 25),
  (2, 2, 720,  1, 25),
  (3, 3, 2200, 0, 4),
  (4, 1, 2500, 1, 12),
  (1, 2, 400,  0, 1),
  (1, 2, 400,  0, 1),
  (1, 1, 320,  0, 1),
  (2, 3, 320,  0, 1),
  (3, 2, 2600, 0, 25);

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
  (10, 1, 2.5, 1, 1, 0, 3)
  --(11, 1, 1,   0, 1, 0, 0),
  --(12, 2, 1.5, 1, 1, 1, 2),
  --(13, 1, 1,   1, 1, 1, 1),
  --(14, 4, 3.5, 1, 1, 0, 4),
  --(15, 3, 2,   0, 0, 0, 2),
  --(16, 2, 1,   0, 1, 0, 0),
  --(17, 2, 1,   0, 1, 0, 1),
  --(18, 1, 1,   0, 1, 0, 0),
  --(19, 1, 1,   0, 1, 0, 0),
  --(20, 1, 2.5, 1, 1, 0, 3);

INSERT INTO [tenant] 
  (tenant_id, unit_rented_id, first_name, last_name, email, mobile_number)
VALUES	 
  (14, 3, 'Aubrie', 'Wall', 'WallAubrie@gmail.com', '5131234567'),
  (15, 4, 'Kiley', 'Coleman', 'KileyColeman@gmail.com', '5131234567'),
  (16, 6, 'Jaxon', 'Archer', 'JaxonArcher@gmail.com', '5131234567'),
  (17, 8, 'Caitlin', 'Avery', 'CaitlinAvery@gmail.com', '5131234567'),
  (18, 9, 'Kimora', 'Long', 'KimoraLong@gmail.com', '5131234567'),
  (19, 10, 'Lorelei', 'May', 'LoreleiMay@gmail.com', '5131234567');
  --(20, 13, 'Angie', 'Tucker', 'AngieTucker@gmail.com', '5131234567'),
  --(21, 16, 'Kamari', 'Todd', 'KamariTodd@gmail.com', '5131234567'),
  --(22, 18, 'Peyton', 'Bradley', 'PeytonBradley@gmail.com', '5131234567'),
  --(23, 19, 'Cynthia', 'Kelly', 'CynthiaKelly@gmail.com', '5131234567');

INSERT INTO [maintenance_requests] 
  (tenant_id, request_type_id, concern, request_status_id)
VALUES	 
	(14, 2, 'the quick brown fox jumps over the lazy dog', 1),
	(16, 3, 'leaky bathroom ceiling', 2),
  (18, 1, 'sample maintenance request description', 3),
	--(20, 3, 'leaky bathroom ceiling', 2),
	--(23, 6, 'leaky bathroom ceiling', 1),
  (17, 2, 'sample maintenance request description', 1),
	(16, 4, 'leaky bathroom ceiling', 2);
 -- (20, 2, 'sample maintenance request description', 3),
	--(20, 3, 'leaky bathroom ceiling', 1),
	--(23, 6, 'leaky bathroom ceiling', 2);
	
INSERT INTO [maintenance_requests] 
  (tenant_id, request_type_id, concern, request_status_id, employee_assigned_id)
VALUES	 
	
	(16, 1, 'Toilet is loud', 3, 7),
	(18, 6, 'Replace front door lock', 1, 7);


INSERT INTO [unit_images] 
  (unit_id, image_url, image_caption)
VALUES 
	(1, 'https://i.imgur.com/eyhMgSx.png', 'OH GOD WHAT IS THAT'),
	(2, 'https://www.arkbh.com/wp-content/uploads/2021/01/crack_houses-1024x640.jpg', 'Affordable housing img'),
  (3, 'https://i.imgur.com/eyhMgSx.png', 'OH GOD WHAT IS THAT'),
	(4, 'https://www.arkbh.com/wp-content/uploads/2021/01/crack_houses-1024x640.jpg', 'Affordable housing img'),
  (5, 'https://i.imgur.com/eyhMgSx.png', 'OH GOD WHAT IS THAT'),
	(6, 'https://www.arkbh.com/wp-content/uploads/2021/01/crack_houses-1024x640.jpg', 'Affordable housing img'),
  (7, 'https://i.imgur.com/eyhMgSx.png', 'OH GOD WHAT IS THAT'),
	(8, 'https://www.arkbh.com/wp-content/uploads/2021/01/crack_houses-1024x640.jpg', 'Affordable housing img'),
  (9, 'https://i.imgur.com/eyhMgSx.png', 'OH GOD WHAT IS THAT'),
	(10, 'https://www.arkbh.com/wp-content/uploads/2021/01/crack_houses-1024x640.jpg', 'Affordable housing img');
 -- (11, 'https://i.imgur.com/eyhMgSx.png', 'OH GOD WHAT IS THAT'),
	--(12, 'https://www.arkbh.com/wp-content/uploads/2021/01/crack_houses-1024x640.jpg', 'Affordable housing img'),
 -- (13, 'https://i.imgur.com/eyhMgSx.png', 'OH GOD WHAT IS THAT'),
	--(14, 'https://www.arkbh.com/wp-content/uploads/2021/01/crack_houses-1024x640.jpg', 'Affordable housing img'),
 -- (15, 'https://i.imgur.com/eyhMgSx.png', 'OH GOD WHAT IS THAT'),
 -- (16, 'https://www.arkbh.com/wp-content/uploads/2021/01/crack_houses-1024x640.jpg', 'Affordable housing img'),
 -- (17, 'https://i.imgur.com/eyhMgSx.png', 'OH GOD WHAT IS THAT'),
	--(18, 'https://www.arkbh.com/wp-content/uploads/2021/01/crack_houses-1024x640.jpg', 'Affordable housing img'),
 -- (19, 'https://i.imgur.com/eyhMgSx.png', 'OH GOD WHAT IS THAT'),
	--(20, 'https://www.arkbh.com/wp-content/uploads/2021/01/crack_houses-1024x640.jpg', 'Affordable housing img');

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
  (1,  0, '0',   '6711 Fayetta Drive',         'Hamilton',      'OH', '45011'),
  (2,  0, '0',   '6989 Sleepy Chase Ln',       'Loveland',      'OH', '45140'),
  (3,  0, '101', '176 StoneRidge Blvd',        'South Lebanon', 'OH', '45065'),
  (4,  1, 'A1', '627 Cherry Grove St',        'Casper',        'SC', '78140'),
  (5,  1, 'A2',   '983 Georgey Rows Ave',       'NY',            'NY', '2341'),
  (6,  0, '0', '176 StoneRidge Blvd',        'Alpena',        'MI', '6754'),
  (7,  0, '0', '3219 Steeple Chase Ln',      'Loveland',      'OH', '45140'),
  (8,  0, '0',   '911 RollongStone Blvd',      'South Lebanon', 'OH', '45065'),
  (9,  2, '606', '627 Cherry Grove St',        'Casper',        'SC', '78140'),
  (10, 2, '101',   '983 Georgey Rows Ave',       'NY',            'NY', '2341');
  --(11,  1, 'A3',   '6711 Fayetta Drive',         'Hamilton',      'OH', '45011'),
  --(12,  1, 'C2',   '6989 Sleepy Chase Ln',       'Loveland',      'OH', '45140'),
  --(13,  1, 'B10', '176 StoneRidge Blvd',        'South Lebanon', 'OH', '45065'),
  --(14,  0, '0', '627 Cherry Grove St',        'Casper',        'SC', '78140'),
  --(15,  1, '0',   '983 Georgey Rows Ave',       'NY',            'NY', '2341'),
  --(16,  1, '102', '176 StoneRidge Blvd',        'Alpena',        'MI', '6754'),
  --(17,  0, '0', '3219 Steeple Chase Ln',      'Loveland',      'OH', '45140'),
  --(18,  1, 'A4',   '911 RollongStone Blvd',      'South Lebanon', 'OH', '45065'),
  --(19,  2, '301', '627 Cherry Grove St',        'Casper',        'SC', '78140'),
  --(20, 1, 'B6',   '983 Georgey Rows Ave',       'NY',            'NY', '2341');