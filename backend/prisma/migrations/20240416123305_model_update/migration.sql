/*
  Warnings:

  - You are about to drop the column `minimizeLayoutNumber` on the `settings` table. All the data in the column will be lost.
  - Added the required column `cuttingComplexity` to the `Settings` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cuttingLayoutsMinimization` to the `Settings` table without a default value. This is not possible if the table is not empty.
  - Added the required column `minimizePanelsRotations` to the `Settings` table without a default value. This is not possible if the table is not empty.
  - Added the required column `rollMode` to the `Settings` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `settings` DROP COLUMN `minimizeLayoutNumber`,
    ADD COLUMN `cutDirection` ENUM('Auto', 'Vertical', 'Horizontal') NOT NULL DEFAULT 'Auto',
    ADD COLUMN `cuttingComplexity` VARCHAR(191) NOT NULL,
    ADD COLUMN `cuttingLayoutsMinimization` BOOLEAN NOT NULL,
    ADD COLUMN `maximumLayoutSize` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `minimizePanelsRotations` BOOLEAN NOT NULL,
    ADD COLUMN `minimumWasteSize` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `rollMode` BOOLEAN NOT NULL,
    ADD COLUMN `sawKerfValue` INTEGER NOT NULL DEFAULT 0,
    MODIFY `trimLeft` INTEGER NOT NULL DEFAULT 0,
    MODIFY `trimRight` INTEGER NOT NULL DEFAULT 0,
    MODIFY `trimTop` INTEGER NOT NULL DEFAULT 0,
    MODIFY `trimBottom` INTEGER NOT NULL DEFAULT 0,
    MODIFY `bladeWidth` INTEGER NOT NULL DEFAULT 0;
