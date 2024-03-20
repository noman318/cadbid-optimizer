/*
  Warnings:

  - A unique constraint covering the columns `[stockSheetId]` on the table `panels` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `stockSheetId` to the `panels` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `panels` ADD COLUMN `stockSheetId` VARCHAR(191) NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX `panels_stockSheetId_key` ON `panels`(`stockSheetId`);

-- AddForeignKey
ALTER TABLE `panels` ADD CONSTRAINT `panels_stockSheetId_fkey` FOREIGN KEY (`stockSheetId`) REFERENCES `stock_sheets`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
