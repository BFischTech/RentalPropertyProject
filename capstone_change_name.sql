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

IF OBJECT_ID ('Users_Properties')					IS NOT NULL DROP TABLE Users_Properties
IF OBJECT_ID ('Users_MaintenanceRequests')			IS NOT NULL DROP TABLE Users_MaintenanceRequests
IF OBJECT_ID ('MaintenanceRequests')				IS NOT NULL DROP TABLE MaintenanceRequests
IF OBJECT_ID ('Users')								IS NOT NULL DROP TABLE Users
IF OBJECT_ID ('Properties')							IS NOT NULL DROP TABLE Properties
IF OBJECT_ID ('Images')								IS NOT NULL DROP TABLE Images

-- --------------------------------------------------------------------------------
--	Create tables
-- --------------------------------------------------------------------------------

--CREATE TABLE Images
--(
--	  imageID							INT IDENTITY(1,1)			NOT NULL
--	 ,description						VARCHAR(200)				NOT NULL
--	 ,CONSTRAINT propertyID             FOREIGN KEY(propertyID)                         NOT NULL
--	 ,CONSTRAINT Images_PK				PRIMARY KEY (imageID)
--)

CREATE TABLE properties
(
	 propertyID							INT IDENTITY(1,1)					NOT NULL
	,address							VARCHAR(200)			NOT NULL
	,city								VARCHAR(200)			NOT NULL
	,state								VARCHAR(200)			NOT NULL
	,zipCode							VARCHAR(200)			NOT NULL
	,unit								VARCHAR(200)			NOT NULL
	,rentAmount							DECIMAL					NOT NULL
	,isRented							BIT						NOT NULL
	,rentDueDate						DATE					NOT NULL
	,CONSTRAINT Properties_PK			PRIMARY KEY (propertyID)
)

CREATE TABLE users
(
	 userID								INT IDENTITY(1,1)					NOT NULL
	,username							VARCHAR(200)			NOT NULL
	,password_hash						VARCHAR(200)			NOT NULL
	,salt								VARCHAR(200)			NOT NULL
	,user_role							VARCHAR(50)				NOT NULL
	,account_number						VARCHAR(200)			
	,CONSTRAINT Users_PK				PRIMARY KEY (userID)
)

CREATE TABLE maintenance_requests
(
	  maintenanceRequestID						INT IDENTITY(1,1)					NOT NULL
	 ,propertyID								INTEGER					NOT NULL
	 ,description								VARCHAR(200)			NOT NULL
	 ,isCompleted								BIT						NOT NULL
	 ,requester_userID						    INTEGER					NOT NULL
	 ,maintenance_userID						INTEGER					NULL
	 ,CONSTRAINT MaintenanceRequests_PK			PRIMARY KEY (maintenanceRequestID)
)



CREATE TABLE Users_Properties
(
	 user_properties_id							INT IDENTITY(1,1)				NOT NULL
	,userID										INTEGER				NOT NULL
	,propertyID									INTEGER				NOT NULL
	,CONSTRAINT Users_Properties_PK				PRIMARY KEY (user_properties_id)
)

CREATE TABLE Users_MaintenanceRequests
(
	 users_MaintenanceRequestsID				INT IDENTITY(1,1)				NOT NULL
	,userID										INTEGER				NOT NULL
	,maintenanceRequestID						INTEGER				NOT NULL
	,CONSTRAINT Users_MaintenanceRequests_PK	PRIMARY KEY (users_MaintenanceRequestsID)
)

-- --------------------------------------------------------------------------------
--	Create relationships. Foreign Keys.
-- --------------------------------------------------------------------------------
--		Child						Parent					Column
--      -----						------					---------
--	1	Users_Properties			Users					userID
--  2   Users_Properties			Properties				propertyID
--  3   Users_MaintenanceRequests	Users					userID
--  4   Users_MaintenanceRequests	MaintenanceRequests		maintenanceRequestID
--  5   MaintenanceRequests			MaintenanceRequests		maintenanceRequestID

--DO NOT NEED
--  6   Images                      Properties              propertyID

--ALTER TABLE <Child Table> ADD CONSTRAINT <Child Table>_<Parent Table>_FK1
--FOREIGN KEY ( <Child column> ) REFERENCES <Parent Table> ( <Parent column> )


-- 1
ALTER TABLE Users_Properties ADD CONSTRAINT Users_Properties_Users_FK1
FOREIGN KEY (userID) REFERENCES Users (userID) ON DELETE CASCADE

-- 2
ALTER TABLE Users_Properties ADD CONSTRAINT Users_Properties_Properties_FK1
FOREIGN KEY (propertyID) REFERENCES Properties (propertyID) ON DELETE CASCADE

-- 3
ALTER TABLE Users_MaintenanceRequests ADD CONSTRAINT Users_MaintenanceRequests_Users_FK1
FOREIGN KEY (userID) REFERENCES Users (userID) ON DELETE CASCADE

-- 4
ALTER TABLE Users_MaintenanceRequests ADD CONSTRAINT Users_MaintenanceRequests_MaintenanceRequests_FK1
FOREIGN KEY (maintenanceRequestID) REFERENCES MaintenanceRequests (maintenanceRequestID) ON DELETE CASCADE

-- 5
ALTER TABLE MaintenanceRequests ADD CONSTRAINT MaintenanceRequests_Properties_FK1
FOREIGN KEY (propertyID) REFERENCES Properties (propertyID) ON DELETE CASCADE

---- 6
--ALTER TABLE Images  ADD CONSTRAINT Images_Properties_FK1
--FOREIGN KEY (propertyID) REFERENCES Properties (propertyID) ON DELETE CASCADE

-- --------------------------------------------------------------------------------
--	INSERTS
-- --------------------------------------------------------------------------------

--INSERT INTO Images (description, propertyID)
--VALUES				('sample image description', 1)


INSERT INTO Properties (address, city, state, zipCode, unit, rentAmount, isRented, rentDueDate)
VALUES				 ('sample addy', 'sample city', 'sample state', 'sample zip', 'sample unit', 1000.00, 1, '8-1-21')


INSERT INTO Users (username, password_hash, salt, user_role, account_number)
VALUES			 ('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','user', 'A352')
				,('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin', 'B365')


INSERT INTO MaintenanceRequests (propertyID, description, isCompleted, requester_userID	)
VALUES			 (1, 'sample maintenance request description', 0, 1)


INSERT INTO Users_Properties (userID, propertyID)
VALUES			 (1, 1)


INSERT INTO Users_MaintenanceRequests (userID, maintenanceRequestID)
VALUES			 (1, 1)

