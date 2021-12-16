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
  first_name          VARCHAR(255)  ,
  last_name           VARCHAR(255)  ,
  email               VARCHAR(255)  ,
  mobile_number       VARCHAR(255)  ,

  CONSTRAINT [PK_owner_id] PRIMARY KEY (owner_id),
  CONSTRAINT [FK_owner_id] FOREIGN KEY (owner_id) REFERENCES [users] (user_id)
);

CREATE TABLE [employee] (
  employee_id         INT           NOT NULL,
  first_name          VARCHAR(255)  ,
  last_name           VARCHAR(255)  ,
  email               VARCHAR(255)  ,
  mobile_number       VARCHAR(255)  ,

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
  ('owner6','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Owner'),
  ('owner7','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Owner'),
  ('owner8','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Owner'),
  ('owner9','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Owner'),
  ('employee1','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Employee'),
  ('employee2','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Employee'),
  ('user1','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','User'),
  ('user2','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','User'),
  ('tenant1','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
  ('tenant2','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
  ('tenant3','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
  ('tenant4','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
  ('tenant5','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant'),
  ('tenant6','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','Tenant');


INSERT INTO [owner] 
  (owner_id, first_name, last_name, email, mobile_number)
VALUES	 
	(2, 'Bradley', 'Fisch', 'FischBradley@localhost.com', '5131234567'),
  (3, 'Bradley', 'Quinton', 'QuintonBradley@localhost.com', '5131234567'),
  (4, 'Dustin', 'Fox', 'FoxDustin@localhost.com', '5131234567'),
  (5, 'Matthew', 'Lawson', 'LawsonMatthew@localhost.com', '5131234567'),
  (6, 'Joe', 'Riggs', 'RiggsJoe@localhost.com', '5131234567'),
  (7, 'Philip', 'Harper', 'Harper@localhost.com', '5131234567'),
  (8, 'Lora', 'Chandler', 'Chandler@localhost.com', '5131234567'),
  (9, 'Edith', 'Parker', 'Parker@localhost.com', '5131234567'),
  (10, 'Jeanette', 'Klein', 'Klein@localhost.com', '5131234567');

INSERT INTO [employee] 
  (employee_id, first_name, last_name, email, mobile_number)
VALUES	 
	(11, 'Clark', 'Mercado', 'MercadoClark@localhost.com', '5131234567'),
  (12, 'Juan', 'Perez', 'PerezJuan@localhost.com', '5131234567');
  
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
  --House
	(
    'Simple House', 
    'Beautiful, Tranquil home with Game room near city, lake and skiing! Rare find!', 
    '7822 Rolling stone dr.', 
    'Hamilton', 
    'OH', 
    '56122',
    'https://hosting.photobucket.com/images/i/clarkjtm/1.jpg',  
    2
  ),
	(
    'The Cozy Cumberland', 
    'The Cozy Cumberland is a well-furnished 3 Bedroom 2 Bath “Entire House” with complete privacy', 
    '4321 Queens island ln', 
    'Cincinnati', 
    'OH', 
    '45999',
    'https://hosting.photobucket.com/images/i/clarkjtm/2.jpg',  
    3
  ),
  (
    'Corner House', 
    'Four bedroom House', 
    '176 StoneRidge Blvd', 
    'South Lebanon', 
    'OH', 
    '45065',
    'https://hosting.photobucket.com/images/i/clarkjtm/3.jpg',  
    4
  ),
  (
    'Beach House', 
    'Beach House, private beach access',  
    '627 Cherry Grove St', 
    'Casper', 
    'SC', 
    '78140', 
    'https://hosting.photobucket.com/images/i/clarkjtm/4.jpg',
    5
  ),
	(
    'Lake House', 
    ' House on the lake, access to a boat dock', 
    '436 Anchor BLVD', 
    'Alpena', 
    'MI', 
    '6754',
    'https://hosting.photobucket.com/images/i/clarkjtm/5.jpg', 
    6
  ),
  --Apartment
	(
    'Steeple Chase', 
    'Apartment complex that has nice ponds', 
    '3219 Steeple Chase Ln', 
    'Loveland', 
    'OH', 
    '45140',
    'https://hosting.photobucket.com/images/i/clarkjtm/6.jpg',  
    7
  ),
	(
    'Afordable Houseing', 
    'Apartment complex for the poor',  
    '983 Georgey Rows Ave', 
    'NY', 
    'NY', 
    '2341',
    'https://hosting.photobucket.com/images/i/clarkjtm/7.jpg', 
    8
  ),
  
  --Condo
	(
    'The Summit', 
    'The Summit 1BR 1.5BA Beautiful unit with great views!',  
    '711 S Thomas Dr', 
    'Casper', 
    'NY', 
    '54222',
    'https://hosting.photobucket.com/images/i/clarkjtm/8.jpg', 
    9
  ),
  (
    'Piece of Paradise', 
    'Your Piece of Paradise! Super 2B/2B Beachfront Condo At Island Winds, Heated Pool, Tennis, WiFi',  
    '12370 Estero Blvd', 
    'Alpena', 
    'MI', 
    '78442',
    'https://hosting.photobucket.com/images/i/clarkjtm/9.jpg', 
    10
  );

INSERT INTO [units] 
  (property_id, unit_type_id, rent_amount, is_rented, rent_due_date)
VALUES 
  (1, 1, 206, 1, 15),
  (2, 1, 151, 0, 15),
  (3, 1, 119, 0, 15),
  (4, 1, 280, 0, 15),
  (5, 1, 135, 0, 15),
--Apartment
  (6, 2, 199, 1, 15),
  (6, 2, 199, 0, 15),
--Apartment
  (7, 2, 185, 0, 15),
  (7, 2, 185, 0, 15),
--Condo
  (8, 3, 67, 0, 15),
  (8, 3, 67, 0, 15),
--Condo
  (9, 3, 100, 0, 15),
  (9, 3, 100, 0, 15);



INSERT INTO [amenities] 
  (unit_id, bedroom_count, bathroom_count, pet_allowed, smoking_allowed, pool_access, parking_spots)
VALUES 
  (1, 1, 1,   1, 1, 0, 1),
  (2, 4, 2.5, 1, 0, 0, 3),
  (3, 3, 2.5, 0, 0, 1, 2),
  (4, 2, 2,   1, 1, 0, 1),
  (5, 1, 1,   1, 1, 1, 1),

  (6, 1, 1, 1, 1, 1, 1),
  (7, 1, 1, 1, 1, 1, 1),

  (8, 2, 1, 0, 0, 1, 1),
  (9, 2, 1, 0, 0, 1, 1),

  (10, 2, 1, 0, 0, 1, 1),
  (11, 2, 1, 0, 0, 1, 1),

  (12, 1, 1, 1, 1, 1, 1),
  (13, 1, 1, 1, 1, 1, 1);

INSERT INTO [tenant] 
  (tenant_id, unit_rented_id, first_name, last_name, email, mobile_number)
VALUES	 
  (15, 1, 'Aubrie', 'Wall', 'WallAubrie@gmail.com', '5131234567'),
  (16, 6, 'Kiley', 'Coleman', 'KileyColeman@gmail.com', '5131234567');

INSERT INTO [tenant] 
  (tenant_id, first_name, last_name, email, mobile_number)
VALUES	 
  (17, 'Lorene', 'Hubbard', 'Hubbard@gmail.com', '5131234567'),
  (18, 'Edgar', 'French', 'French@gmail.com', '5131234567'),
  (19, 'Ted', 'Ortega', 'Ortega@gmail.com', '5131234567'),
  (20, 'Frank', 'Roberson', 'Roberson@gmail.com', '5131234567');

INSERT INTO [maintenance_requests] 
  (tenant_id, request_type_id, concern, request_status_id)
VALUES	 
  (15, 2, 'the quick brown fox jumps over the lazy dog', 1),
  (15, 3, 'leaky bathroom ceiling', 2),
  (15, 1, 'sample maintenance request description', 3),

  (16, 6, 'sample maintenance request description', 1);
	
INSERT INTO [maintenance_requests] 
  (tenant_id, request_type_id, concern, request_status_id, employee_assigned_id)
VALUES	 
	(16, 1, 'Toilet is loud', 3, 11);


INSERT INTO [unit_images] 
  (unit_id, image_url, image_caption)
VALUES 
	(1, 'https://images.unsplash.com/photo-1513584684374-8bab748fbf90?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2065&q=80', 'OH GOD WHAT IS THAT'),
	(2, 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80', 'Affordable housing img'),
  (3, 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80', 'OH GOD WHAT IS THAT'),
	(4, 'https://media.istockphoto.com/photos/modern-living-room-interior-3d-render-picture-id1293762741', 'Affordable housing img'),
  (5, 'https://media.istockphoto.com/photos/colonial-style-house-picture-id1284097677', 'OH GOD WHAT IS THAT'),
	(6, 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80', 'Affordable housing img'),
  (7, 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80', 'Affordable housing img'),
  (8, 'https://media.istockphoto.com/photos/exterior-view-of-modern-apartment-building-picture-id1273552068', 'OH GOD WHAT IS THAT'),
  (9, 'https://media.istockphoto.com/photos/exterior-view-of-modern-apartment-building-picture-id1273552068', 'OH GOD WHAT IS THAT'),
	(10, 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80', 'Affordable housing img'),
	(11, 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80', 'Affordable housing img'),
  (12, 'https://i.imgur.com/eyhMgSx.png', 'OH GOD WHAT IS THAT'),
  (13, 'https://i.imgur.com/eyhMgSx.png', 'OH GOD WHAT IS THAT');

INSERT INTO [unit_images] 
  (unit_id, image_caption)
VALUES 
	(1, 'blank default img url'),
	(2, 'blank default img url'),
	(3, 'blank default img url'),
	(4, 'blank default img url'),
  (5, 'blank default img url'),
	(6, 'blank default img url'),
	(7, 'blank default img url'),
	(8, 'blank default img url'),
  (9, 'blank default img url'),
  (10, 'blank default img url'),
  (11, 'blank default img url'),
  (12, 'blank default img url'),
  (13, 'blank default img url');

INSERT INTO [unit_location] 
  (unit_location_id, unit_building_number, unit_number, unit_street_address, unit_city, unit_state, unit_zip_code)
VALUES 
  (1,  0, '0', '7822 Rolling stone dr.', 'Hamilton', 'OH', '56122'),
  (2,  0, '0', '4321 Queens island ln', 'Cincinnati', 'OH', '45999'),
  (3,  0, '0', '176 StoneRidge Blvd', 'South Lebanon', 'OH', '45065'),
  (4,  0, '0', '627 Cherry Grove St', 'Casper', 'SC', '78140'),
  (5,  0, '0', '436 Anchor BLVD', 'Alpena', 'MI', '6754'),
  (6,  0, 'A1', '3219 Steeple Chase Ln', 'Loveland', 'OH', '45140'),
  (7,  0, 'A2', '3219 Steeple Chase Ln', 'Loveland', 'OH', '45140'),
  (8,  0, 'A1', '983 Georgey Rows Ave', 'NY', 'NY', '2341'),
  (9,  0, 'A2', '983 Georgey Rows Ave', 'NY', 'NY', '2341'),
  (10,  1, '301', '711 S Thomas Dr', 'Casper', 'NY', '54222'),
  (11,  1, '302', '711 S Thomas Dr', 'Casper', 'NY', '54222'),
  (12,  2, '606', '12370 Estero Blvd', 'Alpena', 'MI', '78442'),
  (13,  2, '406', '12370 Estero Blvd', 'Alpena', 'MI', '78442');