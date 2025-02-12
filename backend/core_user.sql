BEGIN;
--
-- Create model Department
--
CREATE TABLE "core_user_department" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(128) NOT NULL, "description" varchar(256) NOT NULL, "created_at" datetime NOT NULL);
--
-- Create model Faculty
--
CREATE TABLE "core_user_faculty" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(128) NOT NULL, "description" varchar(256) NOT NULL);
--
-- Create model Role
--
CREATE TABLE "core_user_role" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(128) NOT NULL, "description" varchar(256) NOT NULL);
--
-- Create model User
--
CREATE TABLE "core_user_user" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "password" varchar(128) NOT NULL, "last_login" datetime NULL, "is_superuser" bool NOT NULL, "username" varchar(150) NOT NULL UNIQUE, "first_name" varchar(150) NOT NULL, "last_name" varchar(150) NOT NULL, "email" varchar(254) NOT NULL, "is_staff" bool NOT NULL, "is_active" bool NOT NULL, "date_joined" datetime NOT NULL, "department_id" bigint NOT NULL REFERENCES "core_user_department" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "core_user_user_groups" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" bigint NOT NULL REFERENCES "core_user_user" ("id") DEFERRABLE INITIALLY DEFERRED, "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "core_user_user_roles" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" bigint NOT NULL REFERENCES "core_user_user" ("id") DEFERRABLE INITIALLY DEFERRED, "role_id" bigint NOT NULL REFERENCES "core_user_role" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "core_user_user_user_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" bigint NOT NULL REFERENCES "core_user_user" ("id") DEFERRABLE INITIALLY DEFERRED, "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED);
--
-- Create model Issue
--
CREATE TABLE "core_user_issue" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "category" varchar(100) NOT NULL, "description" varchar(256) NOT NULL, "status" integer unsigned NOT NULL CHECK ("status" >= 0), "created" datetime NOT NULL, "assignee_id" bigint NOT NULL REFERENCES "core_user_user" ("id") DEFERRABLE INITIALLY DEFERRED, "owner_id" bigint NOT NULL UNIQUE REFERENCES "core_user_user" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "core_user_user_department_id_a74df5a3" ON "core_user_user" ("department_id");
CREATE UNIQUE INDEX "core_user_user_groups_user_id_group_id_ca80d112_uniq" ON "core_user_user_groups" ("user_id", "group_id");
CREATE INDEX "core_user_user_groups_user_id_18e36d6f" ON "core_user_user_groups" ("user_id");
CREATE INDEX "core_user_user_groups_group_id_2da02e74" ON "core_user_user_groups" ("group_id");
CREATE UNIQUE INDEX "core_user_user_roles_user_id_role_id_232b58cc_uniq" ON "core_user_user_roles" ("user_id", "role_id");
CREATE INDEX "core_user_user_roles_user_id_a4348f12" ON "core_user_user_roles" ("user_id");
CREATE INDEX "core_user_user_roles_role_id_4c3001d0" ON "core_user_user_roles" ("role_id");
CREATE UNIQUE INDEX "core_user_user_user_permissions_user_id_permission_id_5742740e_uniq" ON "core_user_user_user_permissions" ("user_id", "permission_id");
CREATE INDEX "core_user_user_user_permissions_user_id_a4223031" ON "core_user_user_user_permissions" ("user_id");
CREATE INDEX "core_user_user_user_permissions_permission_id_ed303843" ON "core_user_user_user_permissions" ("permission_id");
CREATE INDEX "core_user_issue_assignee_id_ccee383e" ON "core_user_issue" ("assignee_id");
COMMIT;
