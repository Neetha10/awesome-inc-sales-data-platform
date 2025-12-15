-- ============================================================================
-- AWESOME INC. - OLTP CONSTRAINTS (MySQL)
-- ============================================================================
-- Primary Keys, Foreign Keys, and Indexes
-- Author: Neethu Satravada (NS6411)
-- Course: ECE-GY-9941 Advanced Projects
-- ============================================================================

USE awesome_inc_oltp;

-- ============================================================================
-- PRIMARY KEY CONSTRAINTS
-- (Already defined in CREATE TABLE, but listed here for documentation)
-- ============================================================================

-- NS_SEGMENT: ROW_ID is Primary Key
-- NS_CATEGORY: ROW_ID is Primary Key
-- NS_SUB_CATEGORY: ROW_ID is Primary Key
-- NS_PRODUCT: ROW_ID is Primary Key
-- NS_CUSTOMER: ROW_ID is Primary Key
-- NS_ORDER: ROW_ID is Primary Key
-- NS_ORDER_DETAIL: ROW_ID is Primary Key
-- NS_RETURN: ROW_ID is Primary Key
-- NS_RETURN_DETAIL: ROW_ID is Primary Key

-- ============================================================================
-- FOREIGN KEY CONSTRAINTS
-- ============================================================================

-- -----------------------------------------------------------------------------
-- FK 1: NS_SUB_CATEGORY → NS_CATEGORY
-- One category has MANY sub-categories
-- -----------------------------------------------------------------------------
ALTER TABLE NS_SUB_CATEGORY
ADD CONSTRAINT NS_SUB_CATEGORY_CATEGORY_FK
FOREIGN KEY (CATEGORY_ROW_ID) 
REFERENCES NS_CATEGORY(ROW_ID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- -----------------------------------------------------------------------------
-- FK 2: NS_PRODUCT → NS_SUB_CATEGORY
-- One sub-category has MANY products
-- -----------------------------------------------------------------------------
ALTER TABLE NS_PRODUCT
ADD CONSTRAINT NS_PRODUCT_SUB_CATEGORY_FK
FOREIGN KEY (SUB_CATEGORY_ROW_ID) 
REFERENCES NS_SUB_CATEGORY(ROW_ID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- -----------------------------------------------------------------------------
-- FK 3: NS_CUSTOMER → NS_SEGMENT
-- One segment has MANY customers
-- -----------------------------------------------------------------------------
ALTER TABLE NS_CUSTOMER
ADD CONSTRAINT NS_CUSTOMER_SEGMENT_FK
FOREIGN KEY (SEGMENT_ROW_ID) 
REFERENCES NS_SEGMENT(ROW_ID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- -----------------------------------------------------------------------------
-- FK 4: NS_ORDER → NS_CUSTOMER
-- One customer has MANY orders
-- -----------------------------------------------------------------------------
ALTER TABLE NS_ORDER
ADD CONSTRAINT NS_ORDER_CUSTOMER_FK
FOREIGN KEY (CUSTOMER_ROW_ID) 
REFERENCES NS_CUSTOMER(ROW_ID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- -----------------------------------------------------------------------------
-- FK 5: NS_ORDER_DETAIL → NS_ORDER
-- One order has MANY order details (line items)
-- -----------------------------------------------------------------------------
ALTER TABLE NS_ORDER_DETAIL
ADD CONSTRAINT NS_ORDER_DETAIL_ORDER_FK
FOREIGN KEY (ORDER_ROW_ID) 
REFERENCES NS_ORDER(ROW_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- -----------------------------------------------------------------------------
-- FK 6: NS_ORDER_DETAIL → NS_PRODUCT
-- One product appears in MANY order details
-- -----------------------------------------------------------------------------
ALTER TABLE NS_ORDER_DETAIL
ADD CONSTRAINT NS_ORDER_DETAIL_PRODUCT_FK
FOREIGN KEY (PRODUCT_ROW_ID) 
REFERENCES NS_PRODUCT(ROW_ID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- -----------------------------------------------------------------------------
-- FK 7: NS_RETURN → NS_ORDER
-- One order can have MANY returns (over time)
-- -----------------------------------------------------------------------------
ALTER TABLE NS_RETURN
ADD CONSTRAINT NS_RETURN_ORDER_FK
FOREIGN KEY (ORDER_ROW_ID) 
REFERENCES NS_ORDER(ROW_ID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- -----------------------------------------------------------------------------
-- FK 8: NS_RETURN_DETAIL → NS_RETURN
-- One return has MANY return details (line items)
-- -----------------------------------------------------------------------------
ALTER TABLE NS_RETURN_DETAIL
ADD CONSTRAINT NS_RETURN_DETAIL_RETURN_FK
FOREIGN KEY (RETURN_ROW_ID) 
REFERENCES NS_RETURN(ROW_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- -----------------------------------------------------------------------------
-- FK 9: NS_RETURN_DETAIL → NS_ORDER_DETAIL
-- One order detail can be returned
-- -----------------------------------------------------------------------------
ALTER TABLE NS_RETURN_DETAIL
ADD CONSTRAINT NS_RETURN_DETAIL_ORDER_DETAIL_FK
FOREIGN KEY (ORDER_DETAIL_ROW_ID) 
REFERENCES NS_ORDER_DETAIL(ROW_ID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- ============================================================================
-- INDEXES FOR PERFORMANCE
-- ============================================================================

-- Index on frequently searched columns
CREATE INDEX IDX_CUSTOMER_SEGMENT ON NS_CUSTOMER(SEGMENT_ROW_ID);
CREATE INDEX IDX_CUSTOMER_COUNTRY ON NS_CUSTOMER(COUNTRY);
CREATE INDEX IDX_CUSTOMER_REGION ON NS_CUSTOMER(REGION);

CREATE INDEX IDX_ORDER_CUSTOMER ON NS_ORDER(CUSTOMER_ROW_ID);
CREATE INDEX IDX_ORDER_DATE ON NS_ORDER(ORDER_DATE);
CREATE INDEX IDX_ORDER_SHIP_MODE ON NS_ORDER(SHIP_MODE);

CREATE INDEX IDX_ORDER_DETAIL_ORDER ON NS_ORDER_DETAIL(ORDER_ROW_ID);
CREATE INDEX IDX_ORDER_DETAIL_PRODUCT ON NS_ORDER_DETAIL(PRODUCT_ROW_ID);

CREATE INDEX IDX_PRODUCT_SUBCATEGORY ON NS_PRODUCT(SUB_CATEGORY_ROW_ID);

CREATE INDEX IDX_SUBCATEGORY_CATEGORY ON NS_SUB_CATEGORY(CATEGORY_ROW_ID);

CREATE INDEX IDX_RETURN_ORDER ON NS_RETURN(ORDER_ROW_ID);

CREATE INDEX IDX_RETURN_DETAIL_RETURN ON NS_RETURN_DETAIL(RETURN_ROW_ID);

-- ============================================================================
-- VERIFY CONSTRAINTS
-- ============================================================================

-- Query to list all foreign keys
SELECT 
    TABLE_NAME,
    CONSTRAINT_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'awesome_inc_oltp'
AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;

