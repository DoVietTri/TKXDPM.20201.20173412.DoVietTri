-- Creator:       MySQL Workbench 8.0.21/ExportSQLite Plugin 0.1.0
-- Author:        8881_TriDV_LAPTOP
-- Caption:       New Model
-- Project:       Name of the project
-- Changed:       2020-12-03 09:56
-- Created:       2020-12-03 09:56
PRAGMA foreign_keys = OFF;

-- Schema: aims
ATTACH "aims.sdb" AS "aims";
BEGIN;
CREATE TABLE "aims"."DeleveryInfo"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" VARCHAR(45) DEFAULT NULL,
  "province" VARCHAR(45) DEFAULT NULL,
  "instructions" VARCHAR(200) DEFAULT NULL,
  "address" VARCHAR(100) DEFAULT NULL
);
CREATE TABLE "aims"."Media"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "category" VARCHAR(45) NOT NULL,
  "price" INTEGER NOT NULL,
  "quantity" INTEGER NOT NULL,
  "title" VARCHAR(45) NOT NULL,
  "value" INTEGER NOT NULL,
  "imageUrl" VARCHAR(45) NOT NULL
);
CREATE TABLE "aims"."Order"(
  "id" INTEGER PRIMARY KEY NOT NULL,
  "shippingFees" VARCHAR(45) DEFAULT NULL,
  "deleveryInfoId" INTEGER NOT NULL,
  CONSTRAINT "fk_Order_DeleveryInfo1"
    FOREIGN KEY("deleveryInfoId")
    REFERENCES "DeleveryInfo"("id")
);
CREATE INDEX "aims"."Order.fk_Order_DeleveryInfo1_idx" ON "Order" ("deleveryInfoId");
CREATE TABLE "aims"."Card"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "cardCode" VARCHAR(15) NOT NULL,
  "owner" VARCHAR(45) NOT NULL,
  "cvvCode" VARCHAR(3) NOT NULL,
  "dateExpired" VARCHAR(4) NOT NULL
);
CREATE TABLE "aims"."DVD"(
  "id" INTEGER PRIMARY KEY NOT NULL,
  "discType" VARCHAR(45) NOT NULL,
  "director" VARCHAR(45) NOT NULL,
  "runtime" INTEGER NOT NULL,
  "studio" VARCHAR(45) NOT NULL,
  "subtitle" VARCHAR(45) NOT NULL,
  "releasedDate" VARCHAR(45) DEFAULT NULL,
  CONSTRAINT "fk_DVD_Media1"
    FOREIGN KEY("id")
    REFERENCES "Media"("id")
);
CREATE TABLE "aims"."CD"(
  "id" INTEGER PRIMARY KEY NOT NULL,
  "artist" VARCHAR(45) NOT NULL,
  "recordLabel" VARCHAR(45) NOT NULL,
  "musicType" VARCHAR(45) NOT NULL,
  "releasedDate" DATE NOT NULL,
  CONSTRAINT "fk_CD_Media1"
    FOREIGN KEY("id")
    REFERENCES "Media"("id")
);
CREATE TABLE "aims"."Book"(
  "id" INTEGER PRIMARY KEY NOT NULL,
  "author" VARCHAR(45) NOT NULL,
  "coverType" VARCHAR(45) NOT NULL,
  "publisher" VARCHAR(45) NOT NULL,
  "publishDate" DATETIME(6) NOT NULL,
  "numOfPages" INTEGER NOT NULL,
  "language" VARCHAR(45) NOT NULL,
  "bookCategory" VARCHAR(45) NOT NULL,
  CONSTRAINT "fk_Book_Media1"
    FOREIGN KEY("id")
    REFERENCES "Media"("id")
);
CREATE TABLE "aims"."OrderMedia"(
  "orderID" INTEGER NOT NULL,
  "price" INTEGER NOT NULL,
  "quantity" INTEGER NOT NULL,
  "mediaId" INTEGER NOT NULL,
  PRIMARY KEY("orderID","mediaId"),
  CONSTRAINT "fk_OrderMedia_Media1"
    FOREIGN KEY("mediaId")
    REFERENCES "Media"("id"),
  CONSTRAINT "fk_OrderMedia_order"
    FOREIGN KEY("orderID")
    REFERENCES "Order"("id")
);
CREATE INDEX "aims"."OrderMedia.fk_OrderMedia_Media1_idx" ON "OrderMedia" ("mediaId");
CREATE TABLE "aims"."Invoice"(
  "id" INTEGER PRIMARY KEY NOT NULL,
  "totalAmount" INTEGER NOT NULL,
  "orderId" INTEGER NOT NULL,
  CONSTRAINT "fk_Invoice_Order1"
    FOREIGN KEY("orderId")
    REFERENCES "Order"("id")
);
CREATE INDEX "aims"."Invoice.fk_Invoice_Order1_idx" ON "Invoice" ("orderId");
CREATE TABLE "aims"."PaymentTransaction"(
  "id" INTEGER NOT NULL,
  "createAt" DATETIME(6) NOT NULL,
  "content" VARCHAR(45) NOT NULL,
  "method" VARCHAR(45) NOT NULL,
  "cardId" INTEGER NOT NULL,
  "invoiceId" INTEGER NOT NULL,
  PRIMARY KEY("id","cardId","invoiceId"),
  CONSTRAINT "fk_PaymentTransaction_Card1"
    FOREIGN KEY("cardId")
    REFERENCES "Card"("id"),
  CONSTRAINT "fk_PaymentTransaction_Invoice1"
    FOREIGN KEY("invoiceId")
    REFERENCES "Invoice"("id")
);
CREATE INDEX "aims"."PaymentTransaction.fk_PaymentTransaction_Card1_idx" ON "PaymentTransaction" ("cardId");
CREATE INDEX "aims"."PaymentTransaction.fk_PaymentTransaction_Invoice1_idx" ON "PaymentTransaction" ("invoiceId");
COMMIT;
