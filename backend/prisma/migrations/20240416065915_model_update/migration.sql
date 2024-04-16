/*
  Warnings:

  - You are about to drop the column `stockSheetId` on the `panels` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `panels` DROP FOREIGN KEY `panels_stockSheetId_fkey`;

-- AlterTable
ALTER TABLE `panels` DROP COLUMN `stockSheetId`;
