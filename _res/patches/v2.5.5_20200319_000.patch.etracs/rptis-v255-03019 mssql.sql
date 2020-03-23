if exists(select * from sysobjects where id = OBJECT_ID('sync_data_forprocess'))
begin 
  drop table sync_data_forprocess
end 
go 

if exists(select * from sysobjects where id = OBJECT_ID('sync_data_pending'))
begin 
  drop table sync_data_pending
end 
go 


if exists(select * from sysobjects where id = OBJECT_ID('sync_data'))
begin 
  drop table sync_data
end 
go 



if exists(select * from sysobjects where id = OBJECT_ID('syncdata_pending'))
begin 
  drop table syncdata_pending
end 
go 

if exists(select * from sysobjects where id = OBJECT_ID('syncdata_forprocess'))
begin 
  drop table syncdata_forprocess
end 
go 

if exists(select * from sysobjects where id = OBJECT_ID('syncdata_item'))
begin 
  drop table syncdata_item
end 
go 

if exists(select * from sysobjects where id = OBJECT_ID('syncdata'))
begin 
  drop table syncdata
end 
go 

if exists(select * from sysobjects where id = OBJECT_ID('syncdata_forsync'))
begin 
  drop table syncdata_forsync
end 
go 



CREATE TABLE syncdata_forsync (
  objid varchar(50) NOT NULL,
  reftype varchar(100) NOT NULL,
  refno varchar(50) NOT NULL,
  action varchar(100) NOT NULL,
  orgid varchar(25) NOT NULL,
  dtfiled datetime NOT NULL,
  createdby_objid varchar(50) DEFAULT NULL,
  createdby_name varchar(255) DEFAULT NULL,
  createdby_title varchar(100) DEFAULT NULL,
  info text,
  PRIMARY KEY (objid)
) 
go

CREATE INDEX ix_dtfiled ON syncdata_forsync (dtfiled)
go
CREATE INDEX ix_createdbyid ON syncdata_forsync (createdby_objid)
go
CREATE INDEX ix_reftype ON syncdata_forsync (reftype) 
go
CREATE INDEX ix_refno ON syncdata_forsync (refno)
go


CREATE TABLE syncdata (
  objid varchar(50) NOT NULL,
  state varchar(50) NOT NULL,
  refid varchar(50) NOT NULL,
  reftype varchar(50) NOT NULL,
  refno varchar(50) DEFAULT NULL,
  action varchar(50) NOT NULL,
  dtfiled datetime NOT NULL,
  orgid varchar(50) DEFAULT NULL,
  remote_orgid varchar(50) DEFAULT NULL,
  remote_orgcode varchar(20) DEFAULT NULL,
  remote_orgclass varchar(20) DEFAULT NULL,
  sender_objid varchar(50) DEFAULT NULL,
  sender_name varchar(150) DEFAULT NULL,
  fileid varchar(255) DEFAULT NULL,
  PRIMARY KEY (objid)
)
go

CREATE INDEX ix_reftype on syncdata (reftype)
go
CREATE INDEX ix_refno on syncdata (refno)
go
CREATE INDEX ix_orgid on syncdata (orgid)
go
CREATE INDEX ix_dtfiled on syncdata (dtfiled)
go
CREATE INDEX ix_fileid on syncdata (fileid)
go
CREATE INDEX ix_refid on syncdata (refid)
go


CREATE TABLE syncdata_item (
  objid varchar(50) NOT NULL,
  parentid varchar(50) NOT NULL,
  state varchar(50) NOT NULL,
  refid varchar(50) NOT NULL,
  reftype varchar(255) NOT NULL,
  refno varchar(50) DEFAULT NULL,
  action varchar(100) NOT NULL,
  error text,
  idx int NOT NULL,
  info text,
  PRIMARY KEY (objid)
)
go

CREATE INDEX ix_parentid ON syncdata_item(parentid)
go
CREATE INDEX ix_refid ON syncdata_item(refid)
go
CREATE INDEX ix_refno ON syncdata_item(refno)
go


ALTER TABLE syncdata_item 
ADD CONSTRAINT fk_syncdataitem_syncdata 
FOREIGN KEY (parentid) REFERENCES syncdata (objid)
GO 



CREATE TABLE syncdata_forprocess (
  objid varchar(50) NOT NULL,
  parentid varchar(50) NOT NULL,
  PRIMARY KEY (objid)
) 
go

CREATE INDEX ix_parentid ON syncdata_forprocess (parentid)
go 

ALTER TABLE syncdata_forprocess 
ADD CONSTRAINT fk_syncdata_forprocess_syncdata_item 
FOREIGN KEY (objid) REFERENCES syncdata_item (objid)
go


CREATE TABLE syncdata_pending (
  objid varchar(50) NOT NULL,
  error text,
  expirydate datetime DEFAULT NULL,
  PRIMARY KEY (objid)
) 
go

CREATE INDEX ix_expirydate ON syncdata_pending(expirydate)
go 

ALTER TABLE syncdata_pending 
ADD CONSTRAINT fk_syncdata_pending_syncdata 
FOREIGN KEY (objid) REFERENCES syncdata (objid)
go



/* PREVTAXABILITY */
alter table faas_previous add prevtaxability varchar(10)
go

