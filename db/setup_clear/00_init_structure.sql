SET
  check_function_bodies = false;

create SCHEMA IF NOT EXISTS "user";

create SCHEMA IF NOT EXISTS system;

CREATE TABLE
  "games" (
    "id" serial8 PRIMARY KEY,
    "name" varchar(255) NOT NULL,
    "release_year" integer,
    "category" varchar(1024),
    "mechanic" varchar(1024),
    "players_min" integer,
    "players_max" integer,
    "playtime_min" integer,
    "playtime_max" integer,
    "min_age" integer,
    "is_expansion" boolean DEFAULT false
  );

CREATE TABLE
  "games_to_sell" (
    "id" serial8 PRIMARY KEY,
    "game_id" serial8,
    "price" float,
    "amount" integer NOT NULL
  );

CREATE TABLE
  "games_to_rent" (
    "id" serial8 PRIMARY KEY,
    "game_id" serial8,
    "price" float,
    "discount" float,
    "date_of_delete" timestamp,
    "date" timestamp,
    "comments" varchar(1024),
    "rented" boolean
  );

CREATE TABLE
  "employees" (
    "id" serial8 PRIMARY KEY,
    "first_name" varchar(32),
    "last_name" varchar(32),
    "email" varchar(64),
    "phone" varchar(9),
    "hired_date" timestamp,
    "position" varchar(32),
    "date_end_of_work" timestamp,
    "salary" float
  );

CREATE TABLE
  "customers" (
    "id" serial8 PRIMARY KEY,
    "first_name" varchar(32),
    "last_name" varchar(32),
    "email" varchar(64),
    "phone" varchar(9),
    "discount" float,
    "date_of_registration" timestamp
  );

CREATE TABLE
  "additional_payment" (
    "id" serial8 PRIMARY KEY,
    "days_paid_time_min" integer,
    "days_paid_time_max" integer,
    "payment_percent" float
  );

CREATE TABLE
  "sales" (
    "id" serial8 PRIMARY KEY,
    "game_id" serial8,
    "employee_id" serial8,
    "date" timestamp
  );

CREATE TABLE
  "rental" (
    "id" serial8 PRIMARY KEY,
    "additional_payment_id" serial8,
    "return_date" timestamp,
    "rental_date" timestamp,
    "game_id" serial8,
    "customer_id" serial8,
    "return_employee_id" serial8,
    "employee_id" serial8
  );

CREATE TABLE
  "competitions" (
    "id" serial8 PRIMARY KEY,
    "name" varchar(256),
    "entry_fee" float,
    "number_of_participants" integer,
    "date" timestamp,
    "description" varchar(1024),
    "game_id" serial8
  );

CREATE TABLE
  "prizes" (
    "id" serial8 PRIMARY KEY,
    "kind" varchar(64),
    "given" boolean
  );

CREATE TABLE
  "registration" (
    "id" serial8 PRIMARY KEY,
    "first_name" varchar(32),
    "last_name" varchar(32),
    "email" varchar(64),
    "phone" varchar(9)
  );

CREATE TABLE
  "participants" (
    "id" serial8 PRIMARY KEY,
    "competition_id" serial8,
    "prize_id" serial8,
    "registration_id" serial8,
    "score" integer,
    "ranking" integer,
    "present" boolean
  );

ALTER TABLE participants
ALTER COLUMN prize_id
DROP NOT NULL;

CREATE TABLE
  "meetings" (
    "id" serial8 PRIMARY KEY,
    "date" timestamp,
    "name" varchar(512),
    "fee" float,
    "online" boolean
  );

ALTER TABLE "games_to_sell" ADD FOREIGN KEY ("game_id") REFERENCES "games" ("id");

ALTER TABLE "games_to_rent" ADD FOREIGN KEY ("game_id") REFERENCES "games" ("id");

ALTER TABLE "sales" ADD FOREIGN KEY ("game_id") REFERENCES "games_to_sell" ("id");

ALTER TABLE "sales" ADD FOREIGN KEY ("employee_id") REFERENCES "employees" ("id");

ALTER TABLE "rental" ADD FOREIGN KEY ("additional_payment_id") REFERENCES "additional_payment" ("id");

ALTER TABLE "rental" ADD FOREIGN KEY ("game_id") REFERENCES "games_to_rent" ("id");

ALTER TABLE "rental" ADD FOREIGN KEY ("customer_id") REFERENCES "customers" ("id");

ALTER TABLE "rental" ADD FOREIGN KEY ("return_employee_id") REFERENCES "employees" ("id");

ALTER TABLE "rental" ADD FOREIGN KEY ("employee_id") REFERENCES "employees" ("id");

ALTER TABLE "competitions" ADD FOREIGN KEY ("game_id") REFERENCES "games" ("id");

ALTER TABLE "participants" ADD FOREIGN KEY ("competition_id") REFERENCES "competitions" ("id");

ALTER TABLE "participants" ADD FOREIGN KEY ("prize_id") REFERENCES "prizes" ("id");

ALTER TABLE "participants" ADD FOREIGN KEY ("registration_id") REFERENCES "registration" ("id");

ALTER TABLE rental
ALTER COLUMN additional_payment_id
DROP NOT NULL;

ALTER TABLE rental
ALTER COLUMN return_employee_id
DROP NOT NULL;