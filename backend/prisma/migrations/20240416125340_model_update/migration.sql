/*
  Warnings:

  - You are about to drop the column `bladeWidth` on the `settings` table. All the data in the column will be lost.
  - You are about to drop the column `cutDirection` on the `settings` table. All the data in the column will be lost.
  - You are about to drop the column `cuttingComplexity` on the `settings` table. All the data in the column will be lost.
  - You are about to drop the column `cuttingLayoutsMinimization` on the `settings` table. All the data in the column will be lost.
  - You are about to drop the column `maximumLayoutSize` on the `settings` table. All the data in the column will be lost.
  - You are about to drop the column `minimizePanelsRotations` on the `settings` table. All the data in the column will be lost.
  - You are about to drop the column `minimizeSheetRotation` on the `settings` table. All the data in the column will be lost.
  - You are about to drop the column `minimumWasteSize` on the `settings` table. All the data in the column will be lost.
  - You are about to drop the column `rollMode` on the `settings` table. All the data in the column will be lost.
  - You are about to drop the column `sawKerfValue` on the `settings` table. All the data in the column will be lost.
  - You are about to drop the column `trimBottom` on the `settings` table. All the data in the column will be lost.
  - You are about to drop the column `trimLeft` on the `settings` table. All the data in the column will be lost.
  - You are about to drop the column `trimRight` on the `settings` table. All the data in the column will be lost.
  - You are about to drop the column `trimTop` on the `settings` table. All the data in the column will be lost.
  - Added the required column `bCutDirection` to the `Settings` table without a default value. This is not possible if the table is not empty.
  - Added the required column `bCuttingLayoutMin` to the `Settings` table without a default value. This is not possible if the table is not empty.
  - Added the required column `bMinmizePanelRotation` to the `Settings` table without a default value. This is not possible if the table is not empty.
  - Added the required column `bRollMode` to the `Settings` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nCuttingComplexity` to the `Settings` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `settings` DROP COLUMN `bladeWidth`,
    DROP COLUMN `cutDirection`,
    DROP COLUMN `cuttingComplexity`,
    DROP COLUMN `cuttingLayoutsMinimization`,
    DROP COLUMN `maximumLayoutSize`,
    DROP COLUMN `minimizePanelsRotations`,
    DROP COLUMN `minimizeSheetRotation`,
    DROP COLUMN `minimumWasteSize`,
    DROP COLUMN `rollMode`,
    DROP COLUMN `sawKerfValue`,
    DROP COLUMN `trimBottom`,
    DROP COLUMN `trimLeft`,
    DROP COLUMN `trimRight`,
    DROP COLUMN `trimTop`,
    ADD COLUMN `bCutDirection` BOOLEAN NOT NULL,
    ADD COLUMN `bCuttingLayoutMin` BOOLEAN NOT NULL,
    ADD COLUMN `bMinmizePanelRotation` BOOLEAN NOT NULL,
    ADD COLUMN `bRollMode` BOOLEAN NOT NULL,
    ADD COLUMN `nBottomTrim` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `nCuttingComplexity` INTEGER NOT NULL,
    ADD COLUMN `nLeftTrim` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `nMaxLayoutSize` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `nMinWasteSize` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `nRightTrim` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `nSawKerfValue` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `nTopTrim` INTEGER NOT NULL DEFAULT 0;
