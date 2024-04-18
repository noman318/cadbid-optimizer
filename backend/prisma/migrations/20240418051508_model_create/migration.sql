/*
  Warnings:

  - You are about to drop the column `trial` on the `memailuser` table. All the data in the column will be lost.
  - You are about to drop the `panels` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `settings` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `stock_sheets` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `nCompanyID` to the `memailuser` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `settings` DROP FOREIGN KEY `Settings_userId_fkey`;

-- DropIndex
DROP INDEX `memailuser_sEmail_key` ON `memailuser`;

-- AlterTable
ALTER TABLE `memailuser` DROP COLUMN `trial`,
    ADD COLUMN `nCompanyID` INTEGER UNSIGNED NOT NULL,
    ADD COLUMN `nCreatedID` INTEGER UNSIGNED NULL,
    ADD COLUMN `nModifiedID` INTEGER UNSIGNED NULL;

-- DropTable
DROP TABLE `panels`;

-- DropTable
DROP TABLE `settings`;

-- DropTable
DROP TABLE `stock_sheets`;

-- DropTable
DROP TABLE `user`;

-- CreateTable
CREATE TABLE `mPanel` (
    `sPanelID` VARCHAR(191) NOT NULL,
    `sName` VARCHAR(191) NOT NULL DEFAULT '',
    `nLength` INTEGER NOT NULL DEFAULT 0,
    `nWidth` INTEGER NOT NULL DEFAULT 0,
    `nQty` INTEGER NOT NULL DEFAULT 0,

    PRIMARY KEY (`sPanelID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mUserNew` (
    `sUserID` VARCHAR(191) NOT NULL,
    `sName` VARCHAR(191) NOT NULL,
    `sUserName` VARCHAR(191) NOT NULL,
    `sPassword` VARCHAR(191) NOT NULL,
    `bIsAdmin` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`sUserID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mSettings` (
    `sSettingsID` VARCHAR(191) NOT NULL,
    `nSawKerfValue` INTEGER NOT NULL DEFAULT 0,
    `nMinWasteSize` INTEGER NOT NULL DEFAULT 0,
    `nLeftTrim` INTEGER NOT NULL DEFAULT 0,
    `nRightTrim` INTEGER NOT NULL DEFAULT 0,
    `nBottomTrim` INTEGER NOT NULL DEFAULT 0,
    `nTopTrim` INTEGER NOT NULL DEFAULT 0,
    `nCuttingComplexity` INTEGER NOT NULL,
    `nMaxLayoutSize` INTEGER NOT NULL DEFAULT 0,
    `bCuttingLayoutMin` BOOLEAN NOT NULL,
    `bMinmizePanelRotation` BOOLEAN NOT NULL,
    `bCutDirection` BOOLEAN NOT NULL,
    `bRollMode` BOOLEAN NOT NULL,
    `sUserId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `mSettings_sUserId_key`(`sUserId`),
    PRIMARY KEY (`sSettingsID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mStockSheets` (
    `sStockID` VARCHAR(191) NOT NULL,
    `sName` VARCHAR(191) NOT NULL DEFAULT '',
    `nLength` INTEGER NOT NULL DEFAULT 0,
    `nWidth` INTEGER NOT NULL DEFAULT 0,
    `nQty` INTEGER NOT NULL DEFAULT 0,

    PRIMARY KEY (`sStockID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `madmin_amend` (
    `nAdmin_amendID` INTEGER UNSIGNED NOT NULL,
    `sChange` VARCHAR(500) NULL,
    `bFixed` TINYINT NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModifiedID` DATETIME(0) NULL,

    PRIMARY KEY (`nAdmin_amendID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `massempackingtemplate` (
    `nAssemPackingTemplateID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(50) NOT NULL,
    `sDescription` VARCHAR(50) NOT NULL,
    `nCategoryID` INTEGER UNSIGNED NOT NULL,
    `bShowUnderItems` TINYINT UNSIGNED NOT NULL,
    `sUnderItemCatIDs` VARCHAR(200) NOT NULL,
    `sStatus` VARCHAR(50) NOT NULL,
    `bFixed` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_massempackingtemplate_nCategoryID`(`nCategoryID`),
    INDEX `FK_massempackingtemplate_nCreatedID`(`nCreatedID`),
    INDEX `FK_massempackingtemplate_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `UNIQUE_massempackingtemplate_nCompanyID_sName`(`nCompanyID`, `sName`),
    PRIMARY KEY (`nAssemPackingTemplateID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbankassociate` (
    `nBankAssociateID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(100) NULL,
    `sAdr1` VARCHAR(150) NULL,
    `sAdr2` VARCHAR(150) NULL,
    `sAdr3` VARCHAR(150) NULL,
    `sSupportPhone` VARCHAR(150) NULL,
    `sEmail` VARCHAR(150) NULL,
    `sWebsite` VARCHAR(150) NULL,
    `sSalesPhone` VARCHAR(150) NULL,
    `sRemark` VARCHAR(200) NULL,
    `sImageName` VARCHAR(200) NOT NULL DEFAULT '',
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mbankassociate_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbankassociate_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nBankAssociateID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbankbiviews` (
    `nbankbiviewsID` INTEGER UNSIGNED NOT NULL,
    `sViewName` VARCHAR(200) NOT NULL,
    `sViewDef` VARCHAR(200) NOT NULL,
    `bFixed` TINYINT NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    UNIQUE INDEX `Unique_sViewName`(`sViewName`),
    INDEX `FK_mbankbiviews_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbankbiviews_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nbankbiviewsID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbankbiviewssysclientconfig` (
    `nbankbiviewssysclientconfigID` INTEGER UNSIGNED NOT NULL,
    `sSysClientID` INTEGER UNSIGNED NOT NULL,
    `nBITemplateID` INTEGER UNSIGNED NOT NULL,
    `bFixed` TINYINT NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mbankbiviewssysclientconfig_nBITemplateID`(`nBITemplateID`),
    INDEX `FK_mbankbiviewssysclientconfig_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbankbiviewssysclientconfig_nModifiedID`(`nModifiedID`),
    INDEX `FK_mbankbiviewssysclientconfig_sSysClientID`(`sSysClientID`),
    PRIMARY KEY (`nbankbiviewssysclientconfigID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbankdashelement` (
    `nBankDashElementID` INTEGER UNSIGNED NOT NULL,
    `nBankModuleID` INTEGER UNSIGNED NOT NULL,
    `nBankDashGroupID` INTEGER UNSIGNED NOT NULL,
    `sDashElement` VARCHAR(100) NULL,
    `sFunctionName` VARCHAR(200) NULL,
    `bLowerLimitReq` TINYINT NULL,
    `nLowerLimit` DOUBLE NULL,
    `bUpperLimitReq` TINYINT NULL,
    `nUpperLimit` DOUBLE NOT NULL,
    `nSequenceNo` INTEGER UNSIGNED NOT NULL,
    `sRemarks` VARCHAR(200) NULL,
    `bTimeIntervalReq` TINYINT NOT NULL DEFAULT 0,
    `nTimeInterval` INTEGER UNSIGNED NOT NULL,
    `sTimeIntervalIn` VARCHAR(100) NOT NULL DEFAULT '',
    `bActive` TINYINT NULL DEFAULT 1,
    `sType` VARCHAR(100) NOT NULL DEFAULT 'Figure',
    `sAddon` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mbankdashelement_nBankDashGroupID`(`nBankDashGroupID`),
    INDEX `FK_mbankdashelement_nBankModuleID`(`nBankModuleID`),
    INDEX `FK_mbankdashelement_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbankdashelement_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nBankDashElementID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbankdashgroup` (
    `nBankDashGroupID` INTEGER UNSIGNED NOT NULL,
    `sBankDashGroup` VARCHAR(100) NULL,
    `nSequenceNo` INTEGER UNSIGNED NOT NULL,
    `sRemark` VARCHAR(200) NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mbankdashgroup_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbankdashgroup_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nBankDashGroupID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbankdashsysclientconfig` (
    `nBankDashSysclientConfigID` INTEGER UNSIGNED NOT NULL,
    `sSysClientID` INTEGER UNSIGNED NOT NULL,
    `nBankDashElementID` INTEGER UNSIGNED NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mbankdashsysclientconfig_nBankDashElementID`(`nBankDashElementID`),
    INDEX `FK_mbankdashsysclientconfig_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbankdashsysclientconfig_nModifiedID`(`nModifiedID`),
    INDEX `FK_mbankdashsysclientconfig_sSysClientID`(`sSysClientID`),
    UNIQUE INDEX `NewIndex1`(`sSysClientID`, `nBankDashElementID`),
    PRIMARY KEY (`nBankDashSysclientConfigID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbankfeaturetemplate` (
    `nBankFeatureTemplateID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(300) NOT NULL,
    `sDescription` VARCHAR(500) NOT NULL,
    `bActive` TINYINT UNSIGNED NOT NULL,
    `sProductCode` VARCHAR(100) NOT NULL,
    `bPartialProduct` TINYINT NOT NULL,
    `bFixed` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mbankfeaturetemplate_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbankfeaturetemplate_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nBankFeatureTemplateID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbankfeaturetemplatedet` (
    `nBankFeatureTemplateDetID` INTEGER UNSIGNED NOT NULL,
    `nBankFeatureTemplateID` INTEGER UNSIGNED NOT NULL,
    `nBankFeatureID` INTEGER UNSIGNED NOT NULL,
    `bFixed` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mbankfeaturetemplatedet_nBankFeatureID`(`nBankFeatureID`),
    INDEX `FK_mbankfeaturetemplatedet_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbankfeaturetemplatedet_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `UNIQUE_mbankfeaturetemplatedet_nBankFeatureID_nBankTemplateID`(`nBankFeatureTemplateID`, `nBankFeatureID`),
    PRIMARY KEY (`nBankFeatureTemplateDetID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbankmanualelement` (
    `nBankManualElementID` INTEGER UNSIGNED NOT NULL,
    `nBankModuleID` INTEGER UNSIGNED NOT NULL,
    `nBankManualGroupID` INTEGER UNSIGNED NOT NULL,
    `sTitle` VARCHAR(100) NULL,
    `sVideolink` VARCHAR(100) NULL,
    `nSequenceNo` INTEGER UNSIGNED NOT NULL,
    `sRemarks` VARCHAR(200) NULL,
    `bActive` TINYINT NULL DEFAULT 1,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mbankmanualelement_nBankManualGroupID`(`nBankManualGroupID`),
    INDEX `FK_mbankmanualelement_nBankModuleID`(`nBankModuleID`),
    INDEX `FK_mbankmanualelement_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbankmanualelement_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nBankManualElementID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbankmanualgroup` (
    `nBankManualGroupID` INTEGER UNSIGNED NOT NULL,
    `sBankManualGroup` VARCHAR(100) NULL,
    `nSequenceNo` INTEGER UNSIGNED NOT NULL,
    `sRemark` VARCHAR(200) NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mbankmanualgroup_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbankmanualgroup_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nBankManualGroupID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbankmanualsysclientconfig` (
    `nBankManualSysclientConfigID` INTEGER UNSIGNED NOT NULL,
    `sSysClientID` INTEGER UNSIGNED NOT NULL,
    `nBankManualElementID` INTEGER UNSIGNED NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mbankmanualsysclientconfig_nBankDashElementID`(`nBankManualElementID`),
    INDEX `FK_mbankmanualsysclientconfig_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbankmanualsysclientconfig_nModifiedID`(`nModifiedID`),
    INDEX `FK_mbankmanualsysclientconfig_sSysClientID`(`sSysClientID`),
    UNIQUE INDEX `NewIndex1`(`sSysClientID`, `nBankManualElementID`),
    PRIMARY KEY (`nBankManualSysclientConfigID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbankmodule` (
    `nBankModuleID` INTEGER UNSIGNED NOT NULL,
    `sBankModule` VARCHAR(100) NULL,
    `nSequenceNo` INTEGER UNSIGNED NOT NULL,
    `sRemark` VARCHAR(200) NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    UNIQUE INDEX `Dupli_Module`(`sBankModule`),
    UNIQUE INDEX `Dupli_SequenceNo`(`nSequenceNo`),
    INDEX `FK_mbankmodule_ModifiedID`(`nModifiedID`),
    INDEX `FK_mbankmodule_nCreatedID`(`nCreatedID`),
    PRIMARY KEY (`nBankModuleID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbankmoduledet` (
    `nBankModuleDetID` INTEGER UNSIGNED NOT NULL,
    `nBankModuleID` INTEGER UNSIGNED NULL,
    `sType` VARCHAR(50) NULL,
    `sSequenceNo` VARCHAR(10) NULL,
    `sLeftLinkName` VARCHAR(200) NULL,
    `sLeftLinkPath` VARCHAR(200) NULL,
    `sRightLinkName` VARCHAR(200) NULL,
    `sRightLinkPath` VARCHAR(200) NULL,
    `sRemarks` VARCHAR(200) NULL,
    `sCatalogNo` VARCHAR(150) NOT NULL,
    `sDashBoardTitle` VARCHAR(150) NULL DEFAULT '',
    `sDashBoardTable` VARCHAR(150) NULL DEFAULT '',
    `nBankModuleGroupID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `nDataEntry` TINYINT NULL DEFAULT 0,
    `nReviewer` TINYINT NULL DEFAULT 0,
    `nApprover` TINYINT NULL DEFAULT 0,
    `bActive` TINYINT NULL DEFAULT 1,
    `sQueryDocDate` VARCHAR(1000) NULL,
    `sQueryTransCreationDate` VARCHAR(1000) NULL,
    `sBasic` ENUM('No', 'Yes') NOT NULL,
    `sPremium` ENUM('No', 'Yes') NOT NULL,
    `sAddon` ENUM('No', 'Yes') NOT NULL,
    `sOEM` ENUM('No', 'Yes') NOT NULL,
    `sMTO` ENUM('No', 'Yes') NOT NULL,
    `sRetail` ENUM('No', 'Yes') NOT NULL,
    `nCost` DOUBLE NOT NULL,
    `sBenefit` VARCHAR(1000) NOT NULL,
    `sMenuIconName` VARCHAR(100) NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `Dupli_SeqNo`(`nBankModuleID`, `sSequenceNo`, `nBankModuleGroupID`),
    INDEX `FK_mbankmoduledet_nBankModuleGroupID`(`nBankModuleGroupID`),
    INDEX `FK_mbankmoduledet_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbankmoduledet_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nBankModuleDetID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbankmodulegroup` (
    `nBankModuleGroupID` INTEGER UNSIGNED NOT NULL,
    `sGroupName` VARCHAR(150) NULL,
    `nSequenceNo` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `bFixed` TINYINT NULL DEFAULT 0,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mbankmodulegroup_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbankmodulegroup_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nBankModuleGroupID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbankmodulesetting` (
    `nBankModuleSettingId` INTEGER UNSIGNED NOT NULL,
    `sModuleSetting` VARCHAR(100) NULL,
    `nModuleid` INTEGER UNSIGNED NOT NULL,
    `sOptions` VARCHAR(3000) NULL,
    `sShortDesc` VARCHAR(250) NULL,
    `sLongDesc` VARCHAR(1000) NULL,
    `sDefValue` VARCHAR(200) NULL,
    `bActive` TINYINT NULL DEFAULT 1,
    `sBasic` ENUM('No', 'Yes') NOT NULL,
    `sPremium` ENUM('No', 'Yes') NOT NULL,
    `sAddon` ENUM('No', 'Yes') NOT NULL,
    `sOEM` ENUM('No', 'Yes') NOT NULL,
    `sMTO` ENUM('No', 'Yes') NOT NULL,
    `sRetail` ENUM('No', 'Yes') NOT NULL,
    `nCost` DOUBLE NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    UNIQUE INDEX `Dupli_Bankname`(`sModuleSetting`),
    INDEX `FK_mbankmodulesetting_nModuleid`(`nModuleid`),
    INDEX `FK_mbankname-CreatedID`(`nCreatedID`),
    INDEX `FK_mbankname_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nBankModuleSettingId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbanksysclientconfig` (
    `nbanksysclientconfigID` INTEGER UNSIGNED NOT NULL,
    `sSysClientID` INTEGER UNSIGNED NULL,
    `nBankModuledetid` INTEGER UNSIGNED NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mbanksysclientconfig_BankModuleDetID`(`nBankModuledetid`),
    INDEX `FK_mbanksysclientconfig_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbanksysclientconfig_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `FK_mbanksysclientconfig_synClientID`(`sSysClientID`, `nBankModuledetid`),
    PRIMARY KEY (`nbanksysclientconfigID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbanksystemtask` (
    `nBankSystemTaskID` INTEGER UNSIGNED NOT NULL,
    `sTask` VARCHAR(100) NOT NULL DEFAULT '',
    `sTaskDescription` VARCHAR(300) NULL DEFAULT '',
    `nRepetitionUnit` VARCHAR(50) NULL DEFAULT 'Months',
    `nRepetitionInterval` DOUBLE NULL DEFAULT 0,
    `dtDeadline` VARCHAR(11) NULL DEFAULT '',
    `sFunctionName` VARCHAR(100) NULL,
    `nBankSystemTaskTypeID` INTEGER UNSIGNED NOT NULL,
    `nBankModuleID` INTEGER UNSIGNED NOT NULL,
    `bUserConfig` TINYINT UNSIGNED NULL,
    `bActive` TINYINT NULL,
    `sRemarks` VARCHAR(300) NULL,
    `nDayofOccurance` INTEGER UNSIGNED NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mbanksystemtask_nBankModuleID`(`nBankModuleID`),
    INDEX `FK_mbanksystemtask_nBankSystemTaskTypeID`(`nBankSystemTaskTypeID`),
    INDEX `FK_mbanksystemtask_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbanksystemtask_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nBankSystemTaskID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbanksystemtasktype` (
    `nBankSystemTaskTypeID` INTEGER UNSIGNED NOT NULL,
    `sTaskType` VARCHAR(100) NOT NULL DEFAULT '',
    `sRemarks` VARCHAR(300) NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mbanksystemtasktype_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbanksystemtasktype_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nBankSystemTaskTypeID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbanktasksysclientconfig` (
    `nBankTaskSysclientConfigID` INTEGER UNSIGNED NOT NULL,
    `sSysClientID` INTEGER UNSIGNED NOT NULL,
    `nBankSystemTaskID` INTEGER UNSIGNED NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mbanktasksysclientconfig_nBankSystemTaskID`(`nBankSystemTaskID`),
    INDEX `FK_mbanktasksysclientconfig_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbanktasksysclientconfig_nModifiedID`(`nModifiedID`),
    INDEX `FK_mbanktasksysclientconfig_sSysClientID`(`sSysClientID`),
    PRIMARY KEY (`nBankTaskSysclientConfigID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbankwidgetsysclientconfig` (
    `nBankWidgetSysclientID` INTEGER UNSIGNED NOT NULL,
    `nSysClientID` INTEGER UNSIGNED NOT NULL,
    `nWidgetID` INTEGER UNSIGNED NOT NULL,
    `bFixed` TINYINT NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mbankwidgetsysclientconfig_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbankwidgetsysclientconfig_nModifiedID`(`nModifiedID`),
    INDEX `FK_mbankwidgetsysclientconfig_nSysClientID`(`nSysClientID`),
    INDEX `FK_mbankwidgetsysclientconfig_nWidgetID`(`nWidgetID`),
    PRIMARY KEY (`nBankWidgetSysclientID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbitemplate` (
    `nBITemplateID` INTEGER UNSIGNED NOT NULL,
    `sTemplateName` VARCHAR(200) NOT NULL,
    `nBankBIViewsID` INTEGER UNSIGNED NOT NULL,
    `nBITemplateGroupID` INTEGER UNSIGNED NOT NULL,
    `sParameters` TEXT NOT NULL,
    `sRemarks` VARCHAR(200) NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mbitemplate_nBITemplateGroupID`(`nBITemplateGroupID`),
    INDEX `FK_mbitemplate_nBankBIViewsID`(`nBankBIViewsID`),
    INDEX `FK_mbitemplate_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbitemplate_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `Unique_sTemplateName_nBankBIViewsID_nBITemplateGroupID`(`sTemplateName`, `nBankBIViewsID`, `nBITemplateGroupID`),
    PRIMARY KEY (`nBITemplateID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbitemplategroup` (
    `nBITemplateGroupID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(200) NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mbitemplategroup_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbitemplategroup_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nBITemplateGroupID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbom` (
    `nBOMID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `nUnderBOMFolderID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(200) NOT NULL,
    `sCategoryName` VARCHAR(50) NOT NULL,
    `sProductName` VARCHAR(50) NOT NULL,
    `sL1Width` VARCHAR(100) NOT NULL,
    `sL2Depth` VARCHAR(100) NOT NULL,
    `sL3Height` VARCHAR(100) NOT NULL,
    `sCoreMaterial` VARCHAR(500) NOT NULL,
    `sArticleCode` VARCHAR(500) NOT NULL,
    `sThickness` VARCHAR(100) NOT NULL,
    `sFinish` VARCHAR(500) NULL,
    `bActive` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `sGroupDescription` VARCHAR(100) NOT NULL,
    `bAttchfromMaster` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `sGroupCategoryName` VARCHAR(50) NOT NULL,
    `sLibType` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `nNoofDrawers` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `nNoofShutterFronts` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `nDrawerLength` DOUBLE NOT NULL,
    `nDrawerLoad` DOUBLE NOT NULL,
    `sDrawerColor` VARCHAR(50) NOT NULL,
    `nBOMGroupID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `sNameAlias` VARCHAR(200) NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mbom_nBOMGroupID`(`nBOMGroupID`),
    INDEX `FK_mbom_nCompanyID`(`nCompanyID`),
    INDEX `FK_mbom_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbom_nModifiedID`(`nModifiedID`),
    INDEX `FK_mbom_nUnderBOMFolderID`(`nUnderBOMFolderID`),
    PRIMARY KEY (`nBOMID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbomdet` (
    `nBOMDetID` INTEGER UNSIGNED NOT NULL,
    `nBOMID` INTEGER UNSIGNED NOT NULL,
    `sCategoryName` VARCHAR(50) NOT NULL,
    `sProductName` VARCHAR(50) NOT NULL,
    `sQty` VARCHAR(400) NOT NULL,
    `sL1` VARCHAR(400) NOT NULL,
    `sL2` VARCHAR(400) NOT NULL,
    `sL3` VARCHAR(400) NOT NULL,
    `sCoreMaterial` VARCHAR(400) NOT NULL,
    `sArticleCode` VARCHAR(400) NOT NULL,
    `sFinish` VARCHAR(400) NULL,
    `sDensity` VARCHAR(100) NOT NULL,
    `sPerimeter` VARCHAR(100) NOT NULL,
    `bChangable` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `nUOMID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `sFaceCoat1` VARCHAR(400) NOT NULL,
    `sFaceCoat2` VARCHAR(400) NOT NULL,
    `sCustomField1` VARCHAR(200) NOT NULL,
    `sCustomField2` VARCHAR(200) NOT NULL,
    `sCustomField3` VARCHAR(200) NOT NULL,
    `sCustomField4` VARCHAR(200) NOT NULL,
    `sUserAttr8` VARCHAR(200) NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mbomdet_nBOMID`(`nBOMID`),
    INDEX `FK_mbomdet_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbomdet_nModifiedID`(`nModifiedID`),
    INDEX `FK_mbomdet_nUOMID`(`nUOMID`),
    PRIMARY KEY (`nBOMDetID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbomdrawershutter` (
    `nBOMDrawerShutterID` INTEGER UNSIGNED NOT NULL,
    `nBOMID` INTEGER UNSIGNED NOT NULL,
    `bType` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `sName` VARCHAR(50) NOT NULL,
    `sL1` VARCHAR(100) NOT NULL,
    `sL2` VARCHAR(100) NOT NULL,
    `nOffSetLH` DOUBLE NOT NULL,
    `nOffSetRH` DOUBLE NOT NULL,
    `nOffSetTop` DOUBLE NOT NULL,
    `nOffSetBottom` DOUBLE NOT NULL,
    `bDrawerRequired` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bValidate` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `sFrontLibGroupIDs` VARCHAR(255) NOT NULL,
    `sDrawerLibGroupIDs` VARCHAR(255) NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mbomdrawershutter_nBOMID`(`nBOMID`),
    INDEX `FK_mbomdrawershutter_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbomdrawershutter_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nBOMDrawerShutterID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbomfolder` (
    `nBOMFolderID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `nParentBOMFolderID` INTEGER UNSIGNED NOT NULL,
    `sSearchStr` VARCHAR(1000) NOT NULL,
    `sName` VARCHAR(200) NOT NULL,
    `bActive` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mbomfolder_nCompanyID`(`nCompanyID`),
    INDEX `FK_mbomfolder_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbomfolder_nModifiedID`(`nModifiedID`),
    INDEX `FK_mbomfolder_nParentBOMFolderID`(`nParentBOMFolderID`),
    PRIMARY KEY (`nBOMFolderID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbomgroup` (
    `nBOMGroupID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(200) NOT NULL,
    `bActive` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mbomgroup_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbomgroup_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `UNIQUE_mbomgroup_sName_nCompanyID`(`nCompanyID`, `sName`),
    PRIMARY KEY (`nBOMGroupID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mbomvariable` (
    `nBOMVariableID` INTEGER UNSIGNED NOT NULL,
    `nBOMID` INTEGER UNSIGNED NOT NULL,
    `sVariableName` VARCHAR(32) NOT NULL,
    `sVariableCode` VARCHAR(2) NOT NULL,
    `sOptions` VARCHAR(500) NOT NULL,
    `nSeqNo` INTEGER UNSIGNED NOT NULL,
    `bAttchfromMaster` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `sVariableCatName` VARCHAR(50) NOT NULL,
    `nUOMID` INTEGER UNSIGNED NOT NULL,
    `sColumnName` VARCHAR(20) NOT NULL,
    `sDefValue` VARCHAR(255) NOT NULL,
    `nDependentOn` INTEGER UNSIGNED NOT NULL,
    `nVisibilityOn` INTEGER UNSIGNED NOT NULL,
    `sVisibleValue` VARCHAR(255) NOT NULL,
    `sGroupName` VARCHAR(50) NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mbomvariable_nBOMID`(`nBOMID`),
    INDEX `FK_mbomvariable_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbomvariable_nModifiedID`(`nModifiedID`),
    INDEX `FK_mbomvariable_nUOMID`(`nUOMID`),
    UNIQUE INDEX `UNIQUE_mbomvariable_nBOMID_sVariableName`(`nBOMID`, `sVariableCode`),
    PRIMARY KEY (`nBOMVariableID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mchecklist` (
    `nCheckListID` INTEGER UNSIGNED NOT NULL,
    `sTitle` VARCHAR(50) NULL,
    `sPage` LONGBLOB NULL,
    `bfixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    UNIQUE INDEX `mchecklist_sTitle_unique`(`sTitle`),
    INDEX `FK_mchecklist_nCreatedID`(`nCreatedID`),
    INDEX `FK_mchecklist_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nCheckListID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mcompany` (
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(100) NOT NULL,
    `sAddr1` VARCHAR(100) NOT NULL,
    `sAddr2` VARCHAR(100) NOT NULL,
    `sAddr3` VARCHAR(100) NOT NULL,
    `sLogoPath` VARCHAR(100) NOT NULL,
    `nCurrencyID` INTEGER UNSIGNED NOT NULL,
    `sApplicableTaxName` VARCHAR(20) NOT NULL,
    `nMarginPercentage` DOUBLE NOT NULL,
    `nWastageMaterialPercentage` DOUBLE NOT NULL,
    `nWastageEdgebrandingPercentage` DOUBLE NOT NULL,
    `sPriceLevel1Name` VARCHAR(20) NOT NULL,
    `sPriceLevel2Name` VARCHAR(20) NOT NULL,
    `sPriceLevel3Name` VARCHAR(20) NOT NULL,
    `nImageHeight` INTEGER UNSIGNED NOT NULL DEFAULT 130,
    `sApplicableTaxNo` VARCHAR(100) NOT NULL,
    `nNumberofUsers` INTEGER UNSIGNED NOT NULL,
    `bActive` TINYINT UNSIGNED NOT NULL,
    `sDefaultTerms1` VARCHAR(2000) NOT NULL,
    `sDefaultTerms2` VARCHAR(2000) NOT NULL,
    `sDefaultTerms3` VARCHAR(2000) NOT NULL,
    `bTermsShow` TINYINT NOT NULL,
    `sReportRequired` VARCHAR(50) NOT NULL,
    `sCategorywiseReportColumns` VARCHAR(50) NOT NULL,
    `sConsolidatedReportTerms` VARCHAR(10) NOT NULL,
    `sCategoryReportTerms` VARCHAR(10) NOT NULL,
    `sProcessReportTerms` VARCHAR(10) NOT NULL,
    `sCuttingListReportColumns` VARCHAR(100) NOT NULL DEFAULT '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20',
    `sReportLabel1` VARCHAR(20) NOT NULL,
    `sReportLabel2` VARCHAR(20) NOT NULL,
    `sReportLabel3` VARCHAR(20) NOT NULL,
    `sReportLabel4` VARCHAR(20) NOT NULL,
    `bCompanyShow` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `sCompanyKey` VARCHAR(100) NOT NULL DEFAULT '0',
    `sUploadType` VARCHAR(10) NOT NULL DEFAULT 'S3',
    `sConsolidatedReportColumns` VARCHAR(10) NOT NULL,
    `bOTPRequired` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `sSMSURL` VARCHAR(1000) NOT NULL,
    `sNameLabel` VARCHAR(30) NOT NULL,
    `sL1Label` VARCHAR(30) NOT NULL,
    `sL2Label` VARCHAR(30) NOT NULL,
    `sL3Label` VARCHAR(30) NOT NULL,
    `sAreaLabel` VARCHAR(30) NOT NULL,
    `sDescriptionLabel` VARCHAR(30) NOT NULL,
    `sCoreMaterialLabel` VARCHAR(30) NOT NULL,
    `sFinishLabel` VARCHAR(30) NOT NULL,
    `sEdgebandingLabel` VARCHAR(30) NOT NULL,
    `sFittingsLabel` VARCHAR(30) NOT NULL,
    `sArticleCodeLabel` VARCHAR(30) NOT NULL,
    `sVendorCodeLabel` VARCHAR(30) NOT NULL,
    `sWeightLabel` VARCHAR(30) NOT NULL,
    `sPerimeterLabel` VARCHAR(30) NOT NULL,
    `sCutLengthLabel` VARCHAR(30) NOT NULL,
    `sCutWidthLabel` VARCHAR(30) NOT NULL,
    `sEL1Label` VARCHAR(30) NOT NULL,
    `sEL2Label` VARCHAR(30) NOT NULL,
    `sSL1Label` VARCHAR(30) NOT NULL,
    `sSL2Label` VARCHAR(30) NOT NULL,
    `sUserAttr1Label` VARCHAR(30) NOT NULL,
    `sUserAttr2Label` VARCHAR(30) NOT NULL,
    `sUserAttr3Label` VARCHAR(30) NOT NULL,
    `sUserAttr4Label` VARCHAR(30) NOT NULL,
    `sUserAttr5Label` VARCHAR(30) NOT NULL,
    `sUserAttr6Label` VARCHAR(30) NOT NULL,
    `sUserAttr7Label` VARCHAR(30) NOT NULL,
    `sUserAttr8Label` VARCHAR(30) NOT NULL,
    `sGroupNoLabel` VARCHAR(30) NOT NULL,
    `sELLabel` VARCHAR(30) NOT NULL,
    `sSLLabel` VARCHAR(30) NOT NULL,
    `sItemCustomeField1Label` VARCHAR(30) NOT NULL,
    `sItemCustomeField2Label` VARCHAR(30) NOT NULL,
    `sItemCustomeField3Label` VARCHAR(30) NOT NULL,
    `sItemCustomeField4Label` VARCHAR(30) NOT NULL,
    `sSiteVisitChargesLabel` VARCHAR(30) NOT NULL,
    `sManufacturingCostLabel` VARCHAR(30) NOT NULL,
    `sInstallationAssemblyLabel` VARCHAR(30) NOT NULL,
    `sAttachInDiscussionReq` VARCHAR(5) NOT NULL DEFAULT 'Yes',
    `sReplaceFuncReq` VARCHAR(5) NOT NULL DEFAULT 'Yes',
    `sSMSUtilityReq` VARCHAR(5) NOT NULL DEFAULT 'Yes',
    `sCustSMSModuleReq` VARCHAR(5) NOT NULL DEFAULT 'Yes',
    `nCompanyOneTimeFee` DOUBLE NOT NULL,
    `dtCompAnnExpiryDate` VARCHAR(11) NOT NULL,
    `sCompanyID` VARCHAR(50) NOT NULL,
    `nPackageMasterID` INTEGER UNSIGNED NOT NULL,
    `nLogoPosition` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `nAddressPosition` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `sNestingReq` VARCHAR(5) NOT NULL DEFAULT 'No',
    `bNestingPriceCalMethod` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `nSawKerfValue` DOUBLE NOT NULL DEFAULT 0,
    `nMinWasteSize` DOUBLE NOT NULL DEFAULT 0,
    `nLeftTrim` DOUBLE NOT NULL DEFAULT 0,
    `nRightTrim` DOUBLE NOT NULL DEFAULT 0,
    `nBottomTrim` DOUBLE NOT NULL DEFAULT 0,
    `nTopTrim` DOUBLE NOT NULL DEFAULT 0,
    `nCuttingComplexity` TINYINT UNSIGNED NOT NULL DEFAULT 6,
    `bCuttingLayoutMin` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `nMaxLayoutSize` INTEGER UNSIGNED NOT NULL,
    `bMinmizePanelRotation` TINYINT NOT NULL DEFAULT 0,
    `bConsolidatedReportShowProcess` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `sNewItemFeatureReq` VARCHAR(5) NOT NULL DEFAULT 'No',
    `sUserDefinedChargesLabel2` VARCHAR(30) NOT NULL,
    `sUserDefinedChargesLabel3` VARCHAR(30) NOT NULL,
    `sUserDefinedChargesLabel4` VARCHAR(30) NOT NULL,
    `sCutPartsLabel1` VARCHAR(50) NOT NULL,
    `sCutPartsLabel2` VARCHAR(50) NOT NULL,
    `sCutPartsLabel3` VARCHAR(50) NOT NULL,
    `sCutPartsLabel4` VARCHAR(50) NOT NULL,
    `sCutPartsLabel5` VARCHAR(50) NOT NULL,
    `sCutPartsLabel6` VARCHAR(50) NOT NULL,
    `sMRPReportCatIds` VARCHAR(1000) NOT NULL,
    `sMRPReportProcessIds` VARCHAR(1000) NOT NULL,
    `nNoofQuotperUser` INTEGER NOT NULL DEFAULT 400,
    `nLeftTrim1D` DOUBLE NOT NULL DEFAULT 0,
    `nRightTrim1D` DOUBLE NOT NULL DEFAULT 0,
    `nSawKerfValue1D` DOUBLE NOT NULL DEFAULT 0,
    `sGroupReportTerms` VARCHAR(10) NOT NULL,
    `nGroupReportIncludeProcessCost` TINYINT UNSIGNED NOT NULL,
    `nItemReportVisibletoCustomer` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `sItemwiseReportColumns` VARCHAR(50) NOT NULL,
    `sBoardPrice` VARCHAR(15) NOT NULL DEFAULT 'Level3Price',
    `bNoEdgebandReduction` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `sCutPartsLabel7` VARCHAR(50) NOT NULL,
    `sCutPartsLabel8` VARCHAR(50) NOT NULL,
    `sCutPartsLabel9` VARCHAR(50) NOT NULL,
    `sCutPartsLabel10` VARCHAR(50) NOT NULL,
    `sCutPartsLabel11` VARCHAR(50) NOT NULL,
    `sCutPartsLabel12` VARCHAR(50) NOT NULL,
    `sCutPartsLabel13` VARCHAR(50) NOT NULL,
    `sCutPartsLabel14` VARCHAR(50) NOT NULL,
    `sCutPartsLabel15` VARCHAR(50) NOT NULL,
    `nCutPartsLabel1CharLimit` VARCHAR(30) NOT NULL,
    `nCutPartsLabel2CharLimit` VARCHAR(30) NOT NULL,
    `nCutPartsLabel3CharLimit` VARCHAR(30) NOT NULL,
    `nCutPartsLabel4CharLimit` VARCHAR(30) NOT NULL,
    `nCutPartsLabel5CharLimit` VARCHAR(30) NOT NULL,
    `nCutPartsLabel6CharLimit` VARCHAR(30) NOT NULL,
    `nCutPartsLabel7CharLimit` VARCHAR(30) NOT NULL,
    `nCutPartsLabel8CharLimit` VARCHAR(30) NOT NULL,
    `nCutPartsLabel9CharLimit` VARCHAR(30) NOT NULL,
    `nCutPartsLabel10CharLimit` VARCHAR(30) NOT NULL,
    `nCutPartsLabel11CharLimit` VARCHAR(30) NOT NULL,
    `nCutPartsLabel12CharLimit` VARCHAR(30) NOT NULL,
    `nCutPartsLabel13CharLimit` VARCHAR(30) NOT NULL,
    `nCutPartsLabel14CharLimit` VARCHAR(30) NOT NULL,
    `nCutPartsLabel15CharLimit` VARCHAR(30) NOT NULL,
    `nLabelCountnoofRows` INTEGER UNSIGNED NOT NULL,
    `nLabelCountnoofColumns` INTEGER UNSIGNED NOT NULL,
    `nMarginSettingTop` DOUBLE NOT NULL,
    `nMarginSettingBottom` DOUBLE NOT NULL,
    `nMarginSettingLeft` DOUBLE NOT NULL,
    `nMarginSettingRight` DOUBLE NOT NULL,
    `nLabelGapHorizontal` DOUBLE NOT NULL,
    `nLabelGapVartical` DOUBLE NOT NULL,
    `nLabelSizeWidth` DOUBLE NOT NULL,
    `nLabelSizeHeight` DOUBLE NOT NULL,
    `nnoofLinesPacking` INTEGER UNSIGNED NOT NULL,
    `sStickerLabelCheckFields` VARCHAR(100) NOT NULL,
    `sCalQtyLabel` VARCHAR(30) NOT NULL,
    `nItemReportSizesVisible` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `bCutDirection` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bRollMode` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `sProjectNoLabel` VARCHAR(30) NOT NULL,
    `sDefLanguage` TEXT NOT NULL,
    `sRemarksAnneReportTerms` VARCHAR(10) NOT NULL,
    `sRemarksAnneReportColumns` VARCHAR(20) NOT NULL,
    `sGrossTotalLabel` VARCHAR(30) NOT NULL,
    `sNetTotalLabel` VARCHAR(30) NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    UNIQUE INDEX `mcompany_nCompanyID_key`(`nCompanyID`),
    INDEX `FK_mcompany_nCreatedID`(`nCreatedID`),
    INDEX `FK_mcompany_nCurrencyID`(`nCurrencyID`),
    INDEX `FK_mcompany_nModifiedID`(`nModifiedID`),
    INDEX `FK_mcompany_nPackageMasterID`(`nPackageMasterID`),
    PRIMARY KEY (`nCompanyID`, `sApplicableTaxName`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mconsolidatedreporttemplate` (
    `nConsolidatedReportTemplateID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(100) NOT NULL,
    `sReportIDs` VARCHAR(1000) NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mconsolidatedreporttemplate_nCreatedID`(`nCreatedID`),
    INDEX `FK_mconsolidatedreporttemplate_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `UNIQUE_mconsolidatedreporttemplate_nCompanyID_sName`(`nCompanyID`, `sName`),
    PRIMARY KEY (`nConsolidatedReportTemplateID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mcoupon` (
    `nCouponID` INTEGER UNSIGNED NOT NULL,
    `sCouponCode` VARCHAR(20) NOT NULL,
    `sDisType` VARCHAR(10) NULL,
    `nDiscount` DOUBLE NOT NULL,
    `sLinkedTo` VARCHAR(20) NOT NULL,
    `nNoCouponRed` DOUBLE NOT NULL,
    `dtValStrDate` VARCHAR(11) NOT NULL,
    `dtValEndDate` VARCHAR(11) NOT NULL,
    `bActive` TINYINT UNSIGNED NOT NULL,
    `sLinkedToValues` VARCHAR(200) NOT NULL,
    `bFixed` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mcoupon_nCreatedID`(`nCreatedID`),
    INDEX `FK_mcoupon_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nCouponID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mcoverpagetemplate` (
    `nCoverpagetemplateID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(50) NOT NULL,
    `sContent` LONGBLOB NULL,
    `bDefault` TINYINT UNSIGNED NOT NULL,
    `bReportVisibletoCustomer` TINYINT UNSIGNED NOT NULL,
    `bFixed` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mcoverpagetemplate_nCreatedID`(`nCreatedID`),
    INDEX `FK_mcoverpagetemplate_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `UNIQUE_mcoverpagetemplate_sName_nCompanyID`(`nCompanyID`, `sName`),
    PRIMARY KEY (`nCoverpagetemplateID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mcurrency` (
    `nCurrencyID` INTEGER UNSIGNED NOT NULL,
    `sCurrencyName` VARCHAR(50) NOT NULL,
    `sCurrencySubUnit` VARCHAR(50) NULL,
    `sCurrencyShortForm` VARCHAR(50) NULL,
    `nConversionFactor` DOUBLE NULL DEFAULT 1,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    UNIQUE INDEX `Duplicate_Currency`(`sCurrencyName`),
    INDEX `FK_mcurrency_nCreatedID`(`nCreatedID`),
    INDEX `FK_mcurrency_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nCurrencyID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mcust` (
    `nCustID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(100) NOT NULL,
    `sAddr1` VARCHAR(100) NOT NULL,
    `sAddr2` VARCHAR(100) NOT NULL,
    `sAddr3` VARCHAR(100) NOT NULL,
    `sPriceGroup` VARCHAR(20) NOT NULL,
    `sTaxNo` VARCHAR(50) NOT NULL,
    `sContactPerson` VARCHAR(100) NOT NULL,
    `sMobileNo` VARCHAR(50) NOT NULL,
    `sEmail` VARCHAR(50) NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mcust_nCompanyID`(`nCompanyID`),
    INDEX `FK_mcust_nCreatedID`(`nCreatedID`),
    INDEX `FK_mcust_nModifiedID`(`nModifiedID`),
    INDEX `INDEX_mcust_sContactPerson`(`sContactPerson`),
    UNIQUE INDEX `UNIQUE_mcust_nCompanyID_sName`(`nCompanyID`, `sName`),
    PRIMARY KEY (`nCustID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mcustomernew` (
    `nCustomerID` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(255) NOT NULL,
    `sContactPerson` VARCHAR(255) NULL,
    `sAddress1` VARCHAR(255) NOT NULL,
    `sAddress2` VARCHAR(255) NULL,
    `sAddress3` VARCHAR(255) NULL,
    `sPriceGroup` VARCHAR(255) NOT NULL,
    `sGstNo` VARCHAR(255) NOT NULL,
    `sMobile` VARCHAR(50) NOT NULL,
    `sEmail` VARCHAR(50) NULL,
    `nCreatedID` INTEGER NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mcustomernew_nCompanyID`(`nCompanyID`),
    PRIMARY KEY (`nCustomerID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mcuttinglisttemplate` (
    `nCuttingListTemplateID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(100) NOT NULL,
    `sArticleCode` VARCHAR(50) NOT NULL,
    `sNameFilter` VARCHAR(200) NOT NULL,
    `sCompanyDesc` VARCHAR(200) NOT NULL,
    `sFinish` VARCHAR(100) NOT NULL,
    `sCorematerial` VARCHAR(100) NOT NULL,
    `sColumnSelection` VARCHAR(200) NOT NULL,
    `nCategoryID` VARCHAR(200) NOT NULL,
    `sVendorCode` VARCHAR(200) NOT NULL,
    `sReportTerms` VARCHAR(10) NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mcuttinglisttemplate_nCreatedID`(`nCreatedID`),
    INDEX `FK_mcuttinglisttemplate_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `UNIQUE_mcuttinglisttemplate_nCompanyID_sName`(`nCompanyID`, `sName`),
    PRIMARY KEY (`nCuttingListTemplateID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mdept` (
    `nDeptID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `sDept` VARCHAR(50) NOT NULL,
    `sRemarks` VARCHAR(100) NULL,
    `bDelete` BOOLEAN NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mdept_nCreatedID`(`nCreatedID`),
    INDEX `FK_mdept_nModifiedID`(`nModifiedID`),
    INDEX `INDEX_mdept_sDept`(`sDept`),
    PRIMARY KEY (`nDeptID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mdocgenerationsetup` (
    `nDocgenerationSetupID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sDocumentType` VARCHAR(50) NOT NULL,
    `sPrefix` VARCHAR(10) NOT NULL,
    `sSufix` VARCHAR(10) NOT NULL,
    `nYear` TINYINT UNSIGNED NOT NULL,
    `nNumberFormat` INTEGER UNSIGNED NOT NULL,
    `bFixed` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mdocgenerationsetup_nCreatedID`(`nCreatedID`),
    INDEX `FK_mdocgenerationsetup_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `UNIQUE_mdocgenerationsetup_nCompanyID_sDocumentType`(`nCompanyID`, `sDocumentType`),
    PRIMARY KEY (`nDocgenerationSetupID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `medgebandingtemplate` (
    `nEdgeBandingTemplateID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(200) NOT NULL,
    `bActive` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_medgebandingtemplate_nCreatedID`(`nCreatedID`),
    INDEX `FK_medgebandingtemplate_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `UNIQUE_medgebandingtemplate_nCOmpanyID_sName`(`nCompanyID`, `sName`),
    PRIMARY KEY (`nEdgeBandingTemplateID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `medgebandingtemplatedet` (
    `nEdgeBandingTemplateDetID` INTEGER UNSIGNED NOT NULL,
    `nEdgeBandingTemplateID` INTEGER UNSIGNED NOT NULL,
    `sGroupName` VARCHAR(50) NOT NULL,
    `nL1ItemID` INTEGER UNSIGNED NOT NULL,
    `nL2ItemID` INTEGER UNSIGNED NOT NULL,
    `nS1ItemID` INTEGER UNSIGNED NOT NULL,
    `nS2ItemID` INTEGER UNSIGNED NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_medgebandingtemplatedet_nCreatedID`(`nCreatedID`),
    INDEX `FK_medgebandingtemplatedet_nEdgeBandingTemplateID`(`nEdgeBandingTemplateID`),
    INDEX `FK_medgebandingtemplatedet_nL1ItemID`(`nL1ItemID`),
    INDEX `FK_medgebandingtemplatedet_nL2ItemID`(`nL2ItemID`),
    INDEX `FK_medgebandingtemplatedet_nModifiedID`(`nModifiedID`),
    INDEX `FK_medgebandingtemplatedet_nS1ItemID`(`nS1ItemID`),
    INDEX `FK_medgebandingtemplatedet_nS2ItemID`(`nS2ItemID`),
    PRIMARY KEY (`nEdgeBandingTemplateDetID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `memp` (
    `nEmpID` INTEGER UNSIGNED NOT NULL,
    `sEmp` VARCHAR(150) NOT NULL,
    `nDepartmentID` INTEGER UNSIGNED NOT NULL,
    `sAdr1` VARCHAR(150) NULL,
    `sAdr2` VARCHAR(150) NULL,
    `sAdr3` VARCHAR(150) NULL,
    `sPhone` VARCHAR(150) NULL,
    `sMobile` VARCHAR(150) NULL,
    `sEmail` VARCHAR(150) NULL,
    `dtJoin` VARCHAR(10) NULL,
    `sQualification` VARCHAR(150) NULL,
    `sExperience` VARCHAR(150) NULL,
    `nCompanyLocationID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `dtDOB` VARCHAR(10) NULL DEFAULT '',
    `bExemp` TINYINT NULL,
    `dtservice` VARCHAR(20) NULL DEFAULT '',
    `nBasicSalary` DOUBLE NOT NULL DEFAULT 0,
    `sEmptyp` VARCHAR(100) NULL DEFAULT '',
    `sESICNo` VARCHAR(100) NOT NULL DEFAULT '',
    `sEmpCode` VARCHAR(25) NOT NULL DEFAULT '',
    `sGender` VARCHAR(25) NOT NULL DEFAULT 'Male',
    `nSupID` INTEGER UNSIGNED NOT NULL,
    `sRelativeName` VARCHAR(100) NOT NULL DEFAULT '',
    `sReltivePhone` VARCHAR(100) NOT NULL DEFAULT '',
    `sImageName` VARCHAR(200) NOT NULL DEFAULT '',
    `nShopID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `sPFNo` VARCHAR(100) NOT NULL DEFAULT '',
    `sDesignation` VARCHAR(100) NOT NULL DEFAULT '',
    `sOTApplied` VARCHAR(25) NOT NULL DEFAULT '',
    `nOTRate` DOUBLE NOT NULL,
    `nLeaveSetupID` INTEGER UNSIGNED NOT NULL,
    `nBonusID` INTEGER UNSIGNED NOT NULL,
    `nWeeklyoffID` INTEGER UNSIGNED NOT NULL,
    `nSalaryTemplateID` INTEGER UNSIGNED NOT NULL,
    `nShiftID` INTEGER UNSIGNED NOT NULL,
    `nReportTo` VARCHAR(100) NOT NULL,
    `nDepartment` VARCHAR(100) NOT NULL,
    `sSalutation` VARCHAR(50) NULL,
    `sFathername` VARCHAR(50) NULL,
    `sMaritalStatus` VARCHAR(25) NULL,
    `sHusbandSpouse` VARCHAR(100) NULL,
    `sPanNo` VARCHAR(50) NULL,
    `sPassportNo` VARCHAR(50) NULL,
    `sBankACNo` VARCHAR(50) NULL,
    `sBankName` VARCHAR(100) NULL,
    `sIFSCcode` VARCHAR(100) NULL,
    `sAadharNo` VARCHAR(50) NULL,
    `nBloodGroup` INTEGER UNSIGNED NOT NULL,
    `nEmpLevelID` INTEGER UNSIGNED NOT NULL,
    `sSalaryPer` VARCHAR(50) NOT NULL,
    `sImgSign` VARCHAR(200) NOT NULL DEFAULT '',
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_memp_nBonusID`(`nBonusID`),
    INDEX `FK_memp_nCompanyLocationID`(`nCompanyLocationID`),
    INDEX `FK_memp_nCreatedID`(`nCreatedID`),
    INDEX `FK_memp_nDepartment`(`nDepartment`),
    INDEX `FK_memp_nEmpLevelID`(`nEmpLevelID`),
    INDEX `FK_memp_nLeaveSetupID`(`nLeaveSetupID`),
    INDEX `FK_memp_nModifiedID`(`nModifiedID`),
    INDEX `FK_memp_nReportTo`(`nReportTo`),
    INDEX `FK_memp_nSalaryTemplateID`(`nSalaryTemplateID`),
    INDEX `FK_memp_nShiftID`(`nShiftID`),
    INDEX `FK_memp_nShopID`(`nShopID`),
    INDEX `FK_memp_nWeeklyoffID`(`nWeeklyoffID`),
    INDEX `iDepartmentID`(`nDepartmentID`),
    UNIQUE INDEX `Duplicate_Employee`(`sEmp`, `nDepartmentID`, `nCompanyLocationID`),
    PRIMARY KEY (`nEmpID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mevent` (
    `nEventID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(200) NOT NULL,
    `sRemark` VARCHAR(250) NOT NULL DEFAULT '',
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mevent_nCreatedID`(`nCreatedID`),
    INDEX `FK_mevent_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nEventID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mfeature` (
    `nfeatureID` INTEGER UNSIGNED NOT NULL,
    `nfeatureGroupID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(200) NOT NULL,
    `sDesc` VARCHAR(250) NOT NULL DEFAULT '',
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mfeature_nCreatedID`(`nCreatedID`),
    INDEX `FK_mfeature_nModifiedID`(`nModifiedID`),
    INDEX `FK_mfeature_nfeatureGroupID`(`nfeatureGroupID`),
    PRIMARY KEY (`nfeatureID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mfeaturedet` (
    `nFeatureDetID` INTEGER UNSIGNED NOT NULL,
    `nFeatureID` INTEGER UNSIGNED NOT NULL,
    `sElementType` VARCHAR(10) NOT NULL,
    `nElementID` INTEGER UNSIGNED NOT NULL,
    `sElementValue` VARCHAR(300) NOT NULL,
    `sElementValueVisible` VARCHAR(300) NOT NULL,
    `bFixed` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mfeaturedet_nCreatedID`(`nCreatedID`),
    INDEX `FK_mfeaturedet_nFeatureID`(`nFeatureID`),
    INDEX `FK_mfeaturedet_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `UNIQUE_mfeaturedet_sElementType_nElementID`(`sElementType`, `nElementID`, `nFeatureID`),
    PRIMARY KEY (`nFeatureDetID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mfeaturegroup` (
    `nFeaturegroupID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(300) NOT NULL,
    `bActive` TINYINT UNSIGNED NOT NULL,
    `bFixed` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mbankfeaturegroup_nCreatedID`(`nCreatedID`),
    INDEX `FK_mbankfeaturegroup_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nFeaturegroupID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mhsn` (
    `nHSNID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sCode` VARCHAR(100) NOT NULL DEFAULT '',
    `sDesc` VARCHAR(255) NULL,
    `sType` VARCHAR(20) NOT NULL DEFAULT 'Goods',
    `nIntegratedTaxRate` DOUBLE NOT NULL,
    `nCess` DOUBLE NOT NULL,
    `bActive` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mhsn_nCompanyID`(`nCompanyID`),
    INDEX `FK_mhsn_nCreatedID`(`nCreatedID`),
    INDEX `FK_mhsn_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `UNIQUE_INDEX_mhsn_sCode_nCompanyID`(`sCode`, `nCompanyID`),
    PRIMARY KEY (`nHSNID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mipadress` (
    `nIPAddressID` INTEGER UNSIGNED NOT NULL,
    `sIPAddress` VARCHAR(100) NOT NULL DEFAULT '',
    `sRemarks` VARCHAR(255) NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    UNIQUE INDEX `mipaddress_sIPAddress_unique`(`sIPAddress`),
    INDEX `FK_mipadress_nCreatedID`(`nCreatedID`),
    INDEX `FK_mipadress_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nIPAddressID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mipadressexcludeuser` (
    `nExcludeuserID` INTEGER UNSIGNED NOT NULL,
    `nUserID` INTEGER UNSIGNED NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mipadressexcludeuser_nCreatedID`(`nCreatedID`),
    INDEX `FK_mipadressexcludeuser_nModifiedID`(`nModifiedID`),
    INDEX `FK_mipadressexcludeuser_nUserID`(`nUserID`),
    PRIMARY KEY (`nExcludeuserID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mitem` (
    `nItemID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `nItemCategoryID` INTEGER UNSIGNED NOT NULL,
    `sCode` VARCHAR(50) NOT NULL,
    `sName` VARCHAR(200) NOT NULL,
    `sVendorCode` VARCHAR(50) NOT NULL,
    `sBrand` VARCHAR(100) NOT NULL,
    `sFinish` VARCHAR(100) NOT NULL,
    `nUOMID` INTEGER UNSIGNED NOT NULL,
    `nLevel1Price` DOUBLE NOT NULL,
    `nLevel2Price` DOUBLE NOT NULL,
    `nLevel3Price` DOUBLE NOT NULL,
    `nInstallationCharges` DOUBLE NOT NULL,
    `nNoofDrillHoles` DOUBLE NOT NULL,
    `nHSNID` INTEGER UNSIGNED NOT NULL,
    `sProcurement` VARCHAR(50) NOT NULL,
    `sCoreMaterial` VARCHAR(100) NOT NULL,
    `nDimension1` DOUBLE NOT NULL,
    `nDimension2` DOUBLE NOT NULL,
    `nDimension3` DOUBLE NOT NULL,
    `nAddSub` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `nItemGroupID` INTEGER UNSIGNED NOT NULL,
    `nCustomField1` VARCHAR(200) NOT NULL,
    `nCustomField2` VARCHAR(200) NOT NULL,
    `nCustomField3` VARCHAR(200) NOT NULL,
    `nCustomField4` VARCHAR(200) NOT NULL,
    `nBoardLength` INTEGER UNSIGNED NOT NULL DEFAULT 2440,
    `nBoardWidth` INTEGER UNSIGNED NOT NULL DEFAULT 1220,
    `sEdgeBandingColor` VARCHAR(7) NOT NULL,
    `nPreMillWidth` DOUBLE NOT NULL,
    `nItemWeight` DOUBLE NOT NULL DEFAULT 0,
    `bRotation` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bCustom` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `sAltUOMText` VARCHAR(100) NOT NULL,
    `nAltConvFactor` DOUBLE NOT NULL,
    `nMOQ` DOUBLE NOT NULL,
    `bFixed` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mitem_nCompanyID`(`nCompanyID`),
    INDEX `FK_mitem_nCreatedID`(`nCreatedID`),
    INDEX `FK_mitem_nHSNID`(`nHSNID`),
    INDEX `FK_mitem_nItemCategoryID`(`nItemCategoryID`),
    INDEX `FK_mitem_nItemGroupID`(`nItemGroupID`),
    INDEX `FK_mitem_nModifiedID`(`nModifiedID`),
    INDEX `FK_mitem_nUOMID`(`nUOMID`),
    INDEX `INDEX_mitem_sBrand`(`sBrand`),
    INDEX `INDEX_mitem_sCode`(`sCode`),
    INDEX `INDEX_mitem_sCoreMaterial`(`sCoreMaterial`),
    INDEX `INDEX_mitem_sFinish`(`sFinish`),
    INDEX `INDEX_mitem_sName`(`sName`),
    INDEX `INDEX_mitem_sProcurement`(`sProcurement`),
    INDEX `INDEX_mitem_sVendorCode`(`sVendorCode`),
    PRIMARY KEY (`nItemID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mitemcategory` (
    `nItemCategoryID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(50) NOT NULL,
    `nUOMID` INTEGER UNSIGNED NOT NULL,
    `nCalculationType` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `nExtramarkup` DOUBLE NOT NULL DEFAULT 0,
    `nDiscountNotAllowed` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `sPrintableName` VARCHAR(50) NOT NULL,
    `nExtraMarkupNotAllowed` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `nOmitforProductNotFound` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bUseinAssembledPackingList` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bNestingRequired` TINYINT UNSIGNED NOT NULL,
    `bHideNameColumn` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bHideAreaColumn` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bHideL1Column` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bHideL2Column` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bHideL3Column` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bIncludeinPackaging` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `sUOMTextCat` VARCHAR(100) NOT NULL,
    `bGenerateLabel` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `nPriceChangeNotAllowed` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bScanPackValidate` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bFixed` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mitemcategory_nCreatedID`(`nCreatedID`),
    INDEX `FK_mitemcategory_nModifiedID`(`nModifiedID`),
    INDEX `FK_mitemcategory_nUOMID`(`nUOMID`),
    UNIQUE INDEX `UNIQUE_INDEX_mitemcategory_sName_nCompanyID`(`nCompanyID`, `sName`),
    PRIMARY KEY (`nItemCategoryID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mitemcategoryfinish` (
    `nItemCategoryFinishID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `nItemCategoryID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(100) NOT NULL,
    `nCost` DOUBLE NOT NULL DEFAULT 0,
    `bFixed` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mitemcategoryfinish_nCompanyID`(`nCompanyID`),
    INDEX `FK_mitemcategoryfinish_nCreatedID`(`nCreatedID`),
    INDEX `FK_mitemcategoryfinish_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `UNIQUE_mitemcategoryfinish_nItemCategoryID_sName`(`nItemCategoryID`, `sName`),
    PRIMARY KEY (`nItemCategoryFinishID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mitemgroup` (
    `nItemGroupID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sGroupName` VARCHAR(50) NOT NULL,
    `nItemCategoryIDs` VARCHAR(500) NOT NULL,
    `bFixed` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mitemgroup_nCreatedID`(`nCreatedID`),
    INDEX `FK_mitemgroup_nItemCategoryID`(`nItemCategoryIDs`),
    INDEX `FK_mitemgroup_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `UNIQUE_INDEX_mitemgroup_sGroupName_nCompanyID`(`nCompanyID`, `sGroupName`),
    PRIMARY KEY (`nItemGroupID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mitemprocess` (
    `nItemProcessID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(50) NOT NULL,
    `nManufacturingCost` DOUBLE NOT NULL,
    `nCostperUnitID` INTEGER UNSIGNED NOT NULL,
    `nItemProcessTypeID` INTEGER UNSIGNED NOT NULL,
    `sItemCategoryIds` VARCHAR(1000) NOT NULL,
    `nHSNID` INTEGER UNSIGNED NOT NULL,
    `nInstValue1` DOUBLE NOT NULL,
    `nInstPercentage1` DOUBLE NOT NULL,
    `nInstValue2` DOUBLE NOT NULL,
    `nInstPercentage2` DOUBLE NOT NULL,
    `nInstValue3` DOUBLE NOT NULL,
    `nInstPercentage3` DOUBLE NOT NULL,
    `nInstValue4` DOUBLE NOT NULL,
    `nInstPercentage4` DOUBLE NOT NULL,
    `bPostOptimisation` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `nPostOptmisationCost` DOUBLE NOT NULL DEFAULT 0,
    `nPostOptmisationCostUOMID` INTEGER UNSIGNED NOT NULL,
    `nConsumption` DOUBLE NOT NULL DEFAULT 0,
    `nConsumptionUOMID` INTEGER UNSIGNED NOT NULL,
    `nLevel2Cost` DOUBLE NOT NULL DEFAULT 0,
    `nLevel3Cost` DOUBLE NOT NULL DEFAULT 0,
    `nInstValue5` DOUBLE NOT NULL DEFAULT 0,
    `nInstPercentage5` DOUBLE NOT NULL DEFAULT 0,
    `bFixed` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mitemprocess_nConsumptionUOMID`(`nConsumptionUOMID`),
    INDEX `FK_mitemprocess_nCostperUnitID`(`nCostperUnitID`),
    INDEX `FK_mitemprocess_nCreatedID`(`nCreatedID`),
    INDEX `FK_mitemprocess_nHSNID`(`nHSNID`),
    INDEX `FK_mitemprocess_nItemProcessTypeID`(`nItemProcessTypeID`),
    INDEX `FK_mitemprocess_nModifiedID`(`nModifiedID`),
    INDEX `FK_mitemprocess_nPostOptmisationCostUOMID`(`nPostOptmisationCostUOMID`),
    UNIQUE INDEX `UNIQUE_INDEX_mitemprocess_sName_nCompanyID`(`nCompanyID`, `sName`),
    PRIMARY KEY (`nItemProcessID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mitemprocesstype` (
    `nItemProcessTypeID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(50) NOT NULL,
    `bFixed` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    UNIQUE INDEX `UNIQUE_mitemprocesstype_sName`(`sName`),
    INDEX `FK_mitemprocesstype_nCreatedID`(`nCreatedID`),
    INDEX `FK_mitemprocesstype_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nItemProcessTypeID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mnewsfeedquote` (
    `nNewsFeedQuoteID` INTEGER UNSIGNED NOT NULL,
    `dtFrom` VARCHAR(10) NOT NULL,
    `dtTo` VARCHAR(10) NOT NULL,
    `nSeqNo` INTEGER UNSIGNED NOT NULL,
    `sNewsFeedQuote` VARCHAR(1000) NOT NULL,
    `sType` VARCHAR(10) NOT NULL,
    `bActive` BOOLEAN NOT NULL,
    `bFixed` TINYINT NULL DEFAULT 0,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mnewsfeedquote_nCreatedID`(`nCreatedID`),
    INDEX `FK_mnewsfeedquote_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nNewsFeedQuoteID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mpackagemaster` (
    `nPackageMasterID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(200) NOT NULL,
    `sDesc` VARCHAR(250) NOT NULL DEFAULT '',
    `nCompLicOne` DOUBLE NOT NULL,
    `nCompLicAnn` DOUBLE NOT NULL,
    `nAddUser` DOUBLE NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mpackagemaster_nCreatedID`(`nCreatedID`),
    INDEX `FK_mpackagemaster_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nPackageMasterID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mpackagemasterdet` (
    `nPackageMasterDetID` INTEGER UNSIGNED NOT NULL,
    `nPackageMasterID` INTEGER UNSIGNED NOT NULL,
    `nFeatureID` INTEGER UNSIGNED NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mpackagemasterdet_nCreatedID`(`nCreatedID`),
    INDEX `FK_mpackagemasterdet_nFeatureID`(`nFeatureID`),
    INDEX `FK_mpackagemasterdet_nModifiedID`(`nModifiedID`),
    INDEX `FK_mpackagemasterdet_nPackageMasterID`(`nPackageMasterID`),
    PRIMARY KEY (`nPackageMasterDetID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mpacket` (
    `nPacketID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(50) NOT NULL,
    `sDescription` VARCHAR(50) NOT NULL,
    `bFixed` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mpacket_nCreatedID`(`nCreatedID`),
    INDEX `FK_mpacket_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `Unique_mpacket_nCompanyID_sName`(`nCompanyID`, `sName`),
    PRIMARY KEY (`nPacketID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mreviewinputtemplate` (
    `nReviewInputTemplateID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(100) NOT NULL,
    `nCategoryID` VARCHAR(200) NOT NULL,
    `sProcurement` VARCHAR(50) NOT NULL,
    `sStatus` VARCHAR(50) NOT NULL,
    `sVendorCode` VARCHAR(100) NOT NULL,
    `sColumnSelection` VARCHAR(200) NOT NULL,
    `bGroupby` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `bGroupbyImageReq` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `sNameFilter` VARCHAR(100) NOT NULL,
    `bConsolidatedGroupWise` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `sReportTerms` VARCHAR(10) NOT NULL,
    `bIgnoreSizes` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bHideProductPrice` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bDistinctValueSorting` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bShowUnderGroupItems` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `bReportVisibletoCustomer` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `sColumnSelectedSorting` VARCHAR(200) NOT NULL,
    `nNoofLines` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `bConsiderProcessCost` TINYINT UNSIGNED NOT NULL,
    `bShowLevel1` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bShowLevel1Comment` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bShowLevel2Comment` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bShowLevel3` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bShowLevel3Comment` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bHideLevel1Price` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bHideLevel2Price` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bHideLevel3Price` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bShowFooter` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bLibSeq` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mreviewinputtemplate_nCompanyID`(`nCompanyID`),
    INDEX `FK_mreviewinputtemplate_nCreatedID`(`nCreatedID`),
    INDEX `FK_mreviewinputtemplate_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `UNIQUE_FK_mreviewinputtemplate_sName_nCompanyID`(`sName`, `nCompanyID`),
    PRIMARY KEY (`nReviewInputTemplateID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mroomtype` (
    `nRoomTypeID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(100) NOT NULL DEFAULT '',
    `bActive` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `bDefault` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mroomtype_nCreatedID`(`nCreatedID`),
    INDEX `FK_mroomtype_nModifiedID`(`nModifiedID`),
    INDEX `FK_mroomtype_nQuotationID`(`nQuotationID`),
    UNIQUE INDEX `UNIQUE_mroomtype_nCompanyID_sName_nQuotationID`(`nCompanyID`, `sName`, `nQuotationID`, `nRoomTypeID`),
    PRIMARY KEY (`nRoomTypeID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mservicename` (
    `nserviceId` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `sServiceName` VARCHAR(255) NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sServicesOffered` VARCHAR(255) NULL,
    `sServiceType` VARCHAR(255) NOT NULL,
    `sServiceRate` VARCHAR(255) NULL,
    `sActive` VARCHAR(255) NOT NULL,
    `nCreatedID` INTEGER NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mServiceName_nCompanyID`(`nCompanyID`),
    PRIMARY KEY (`nserviceId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mservicermasternew` (
    `nServiceId` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `sServiceName` VARCHAR(255) NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `sServicesOffered` VARCHAR(255) NULL,
    `sServiceType` VARCHAR(255) NOT NULL,
    `nServiceRate` INTEGER UNSIGNED NULL,
    `sActive` VARCHAR(255) NULL,
    `nCreatedID` INTEGER NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_mServiceMasterNew_nCompanyID`(`nCompanyID`),
    PRIMARY KEY (`nServiceId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mstickerdesigntemplate` (
    `nStickerDesignTemplateID` INTEGER UNSIGNED NOT NULL,
    `sName` VARCHAR(50) NOT NULL,
    `sCutPartsLabel1` VARCHAR(50) NOT NULL,
    `sCutPartsLabel2` VARCHAR(50) NOT NULL,
    `sCutPartsLabel3` VARCHAR(50) NOT NULL,
    `sCutPartsLabel4` VARCHAR(50) NOT NULL,
    `sCutPartsLabel5` VARCHAR(50) NOT NULL,
    `sCutPartsLabel6` VARCHAR(50) NOT NULL,
    `sCutPartsLabel7` VARCHAR(50) NOT NULL,
    `sCutPartsLabel8` VARCHAR(50) NOT NULL,
    `sCutPartsLabel9` VARCHAR(50) NOT NULL,
    `sCutPartsLabel10` VARCHAR(50) NOT NULL,
    `sCutPartsLabel11` VARCHAR(50) NOT NULL,
    `sCutPartsLabel12` VARCHAR(50) NOT NULL,
    `sCutPartsLabel13` VARCHAR(50) NOT NULL,
    `sCutPartsLabel14` VARCHAR(50) NOT NULL,
    `sCutPartsLabel15` VARCHAR(50) NOT NULL,
    `nCutPartsCharLimit1` VARCHAR(30) NOT NULL,
    `nCutPartsCharLimit2` VARCHAR(30) NOT NULL,
    `nCutPartsCharLimit3` VARCHAR(30) NOT NULL,
    `nCutPartsCharLimit4` VARCHAR(30) NOT NULL,
    `nCutPartsCharLimit5` VARCHAR(30) NOT NULL,
    `nCutPartsCharLimit6` VARCHAR(30) NOT NULL,
    `nCutPartsCharLimit7` VARCHAR(30) NOT NULL,
    `nCutPartsCharLimit8` VARCHAR(30) NOT NULL,
    `nCutPartsCharLimit9` VARCHAR(30) NOT NULL,
    `nCutPartsCharLimit10` VARCHAR(30) NOT NULL,
    `nCutPartsCharLimit11` VARCHAR(30) NOT NULL,
    `nCutPartsCharLimit12` VARCHAR(30) NOT NULL,
    `nCutPartsCharLimit13` VARCHAR(30) NOT NULL,
    `nCutPartsCharLimit14` VARCHAR(30) NOT NULL,
    `nCutPartsCharLimit15` VARCHAR(30) NOT NULL,
    `nLabelCountnoofRows` INTEGER UNSIGNED NOT NULL,
    `nLabelCountnoofColumns` INTEGER UNSIGNED NOT NULL,
    `nMarginSettingTop` DOUBLE NOT NULL,
    `nMarginSettingBottom` DOUBLE NOT NULL,
    `nMarginSettingLeft` DOUBLE NOT NULL,
    `nMarginSettingRight` DOUBLE NOT NULL,
    `nLabelGapHorizontal` DOUBLE NOT NULL,
    `nLabelGapVartical` DOUBLE NOT NULL,
    `nLabelSizeWidth` DOUBLE NOT NULL,
    `nLabelSizeHeight` DOUBLE NOT NULL,
    `sStickerLabelCheckFields` VARCHAR(100) NOT NULL,
    `bFixed` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    UNIQUE INDEX `UNIQUE_mstickerdesigntemplate_sName`(`sName`),
    INDEX `FK_mstickerdesigntemplate_nCreatedID`(`nCreatedID`),
    INDEX `FK_mstickerdesigntemplate_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nStickerDesignTemplateID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mtasktemplate` (
    `nTaskTemplateID` INTEGER UNSIGNED NOT NULL,
    `sTask` VARCHAR(100) NOT NULL DEFAULT '',
    `sTaskDescription` VARCHAR(350) NULL DEFAULT '',
    `nNominalCompletionTime` DOUBLE NULL DEFAULT 0,
    `sRepetitive` VARCHAR(50) NULL,
    `nRepetition` DOUBLE NULL,
    `nRemindBefore` DOUBLE NULL,
    `nParentTaskTemplateID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `dtTask` VARCHAR(11) NULL DEFAULT '',
    `nRepetitionUnit` VARCHAR(50) NULL DEFAULT 'Months',
    `nRepetitionTimes` DOUBLE NULL DEFAULT 0,
    `dtDeadline` VARCHAR(11) NULL DEFAULT '',
    `nTaskStartBefore` DOUBLE NULL DEFAULT 0,
    `bActive` TINYINT NOT NULL DEFAULT 1,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mterms_nCreatedID`(`nCreatedID`),
    INDEX `FK_mterms_nModifiedID`(`nModifiedID`),
    INDEX `sTask`(`sTask`),
    PRIMARY KEY (`nTaskTemplateID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mtasktemplatechecklist` (
    `nTasktemplateChecklistID` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `nTasktemplateID` INTEGER UNSIGNED NOT NULL,
    `sChecklist` LONGBLOB NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `dtmodified` DATETIME(0) NULL,

    INDEX `FK_mtasktemplatechecklist_nCreatedID`(`nCreatedID`),
    INDEX `FK_mtasktemplatechecklist_nModifiedID`(`nModifiedID`),
    INDEX `FK_mtasktemplatechecklist_nTasktemplateID`(`nTasktemplateID`),
    PRIMARY KEY (`nTasktemplateChecklistID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `muom` (
    `nUOMID` INTEGER UNSIGNED NOT NULL,
    `sUOM` VARCHAR(50) NOT NULL,
    `sUOMText` VARCHAR(100) NULL,
    `sUnitType` VARCHAR(50) NOT NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    UNIQUE INDEX `Duplicate_UOM`(`sUOM`),
    INDEX `FK_muom_nCreatedID`(`nCreatedID`),
    INDEX `FK_muom_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nUOMID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `muser` (
    `nUserID` INTEGER UNSIGNED NOT NULL,
    `sUserName` VARCHAR(255) NULL,
    `sUser` VARCHAR(255) NULL,
    `sPassword` VARCHAR(255) NULL,
    `sLevel` VARCHAR(255) NULL,
    `nEmpID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `bMode` TINYINT NULL DEFAULT 1,
    `sUserType` VARCHAR(100) NULL DEFAULT 'Employee',
    `nTypeID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `sSkin` VARCHAR(100) NOT NULL DEFAULT 'Skin1',
    `dtLastLogin` DATETIME(0) NOT NULL,
    `sUserTypeNew` VARCHAR(100) NOT NULL,
    `sAddr1` VARCHAR(100) NOT NULL,
    `sAddr2` VARCHAR(100) NOT NULL,
    `sAddr3` VARCHAR(100) NOT NULL,
    `sTaxNo` VARCHAR(50) NOT NULL,
    `sPriceGroup` VARCHAR(100) NOT NULL,
    `sLogoPath` VARCHAR(100) NOT NULL,
    `sExtraMarkupOptionAvail` VARCHAR(5) NOT NULL DEFAULT 'Yes',
    `sDiscountOptionAvail` VARCHAR(5) NOT NULL DEFAULT 'Yes',
    `bCompanyShow` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `sMobileNo` VARCHAR(50) NOT NULL,
    `sEmail` VARCHAR(50) NOT NULL,
    `sOTPAuthenticationReq` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `nSessionID` INTEGER UNSIGNED NOT NULL,
    `dtValidityDate` VARCHAR(11) NOT NULL,
    `sNestingPriceCalMethodUser` VARCHAR(10) NOT NULL DEFAULT '0',
    `sProfileImageName` VARCHAR(200) NOT NULL DEFAULT '',
    `sOptmisationAvail` VARCHAR(5) NOT NULL DEFAULT 'Yes',
    `sMRPReportAvail` VARCHAR(5) NOT NULL DEFAULT 'Yes',
    `sComparativeAnalysisAvail` VARCHAR(5) NOT NULL DEFAULT 'Yes',
    `sCustomerReportAvail` VARCHAR(5) NOT NULL DEFAULT 'Yes',
    `sUserReportIDs` VARCHAR(5000) NOT NULL,
    `sPriceChangeAvail` VARCHAR(5) NOT NULL DEFAULT 'Yes',
    `sOrderLockAvail` VARCHAR(5) NOT NULL DEFAULT 'Yes',
    `sProductNotFoundAddOption` VARCHAR(5) NOT NULL DEFAULT 'Yes',
    `bFixed` TINYINT NULL DEFAULT 0,
    `nCreatedID` INTEGER UNSIGNED NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NULL,
    `dtModified` DATETIME(0) NULL,

    UNIQUE INDEX `Duplicate_sUser`(`sUser`),
    INDEX `FK_muser_nCreatedID`(`nCreatedID`),
    INDEX `FK_muser_nEmpID`(`nEmpID`),
    INDEX `FK_muser_nModifiedID`(`nModifiedID`),
    INDEX `nTypeID`(`nTypeID`),
    INDEX `sUserType`(`sUserType`),
    PRIMARY KEY (`nUserID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `musercatwisemarkupdisc` (
    `nUserCatwiseMarkupDiscID` INTEGER UNSIGNED NOT NULL,
    `nUserID` INTEGER UNSIGNED NOT NULL,
    `nItemCategoryID` INTEGER UNSIGNED NOT NULL,
    `nDiscountPercentage` DOUBLE NOT NULL,
    `nMarkupPercentage` DOUBLE NOT NULL,
    `nMarkupPercentageLimit` DOUBLE NOT NULL,
    `nDiscountPercentageLimit` DOUBLE NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_musercatwisemarkupdisc_nCreatedID`(`nCreatedID`),
    INDEX `FK_musercatwisemarkupdisc_nItemCategoryID`(`nItemCategoryID`),
    INDEX `FK_musercatwisemarkupdisc_nModifiedID`(`nModifiedID`),
    INDEX `FK_musercatwisemarkupdisc_nUserID`(`nUserID`),
    PRIMARY KEY (`nUserCatwiseMarkupDiscID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `muserwisereportcolumnselection` (
    `nUserwiseReportcolumnselectionID` INTEGER UNSIGNED NOT NULL,
    `nUserID` INTEGER UNSIGNED NOT NULL,
    `nBankmoduleDetID` INTEGER UNSIGNED NOT NULL,
    `sColumnArray` VARCHAR(5000) NOT NULL,
    `bfixed` BOOLEAN NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_muserwisereportcolumnselection_nBankmOduleDetID`(`nBankmoduleDetID`),
    INDEX `FK_muserwisereportcolumnselection_nCreatedID`(`nCreatedID`),
    INDEX `FK_muserwisereportcolumnselection_nModifiedID`(`nModifiedID`),
    INDEX `FK_muserwisereportcolumnselection_nUserID`(`nUserID`),
    PRIMARY KEY (`nUserwiseReportcolumnselectionID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sysclient` (
    `nSysClientID` INTEGER UNSIGNED NOT NULL,
    `sSysClient` VARCHAR(150) NOT NULL,
    `nSysCurrencyID` INTEGER UNSIGNED NOT NULL,
    `sSysClientAbr` VARCHAR(150) NOT NULL,
    `bCurrent` TINYINT NOT NULL,
    `sISOCertificateNo` VARCHAR(150) NOT NULL,
    `sSysClientShortForm` VARCHAR(150) NOT NULL,
    `sBank` VARCHAR(150) NOT NULL,
    `sBranch` VARCHAR(150) NOT NULL,
    `sBankAccNo` VARCHAR(150) NOT NULL,
    `sNEFTcode` VARCHAR(150) NOT NULL,
    `sPANNo` VARCHAR(150) NOT NULL DEFAULT '',
    `sBankSwiftCode` VARCHAR(150) NOT NULL DEFAULT '',
    `sIECCode` VARCHAR(150) NOT NULL DEFAULT '',
    `sApplicationURL` VARCHAR(150) NOT NULL DEFAULT '',
    `bSetMon` TINYINT NOT NULL DEFAULT 0,
    `sDBBackupPath` VARCHAR(100) NOT NULL,
    `sCINNo` VARCHAR(100) NULL DEFAULT '',
    `nVersionNo` DOUBLE NOT NULL,
    `nUserID` INTEGER UNSIGNED NOT NULL,
    `sCodeFolderPath` VARCHAR(200) NOT NULL,
    `sRealConnectionString` VARCHAR(500) NOT NULL DEFAULT 'Driver={MySQL ODBC 5.1 Driver};server=localhost;database=innovia;user=root;option=3;pwd=innovation',
    `sPracticeConnectionString` VARCHAR(500) NOT NULL DEFAULT 'Driver={MySQL ODBC 5.1 Driver};server=localhost;database=practice;user=root;option=3;pwd=innovation',
    `sClientType` ENUM('OEM', 'MTO', 'RETAIL') NOT NULL,
    `sProductType` ENUM('Basic', 'Premium') NOT NULL,
    `nHomeCountryID` INTEGER UNSIGNED NOT NULL DEFAULT 80,
    `nHomeStateID` INTEGER UNSIGNED NOT NULL DEFAULT 19,
    `nHomeCityID` INTEGER UNSIGNED NOT NULL DEFAULT 1,
    `nHomeCurrencyID` INTEGER UNSIGNED NOT NULL DEFAULT 1,
    `nBankAssociateID` INTEGER UNSIGNED NOT NULL,
    `nUserLimit` INTEGER NOT NULL,
    `nBankFeatureTemplateID` INTEGER UNSIGNED NOT NULL,
    `bPartial` TINYINT NOT NULL,
    `bFixed` TINYINT NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    UNIQUE INDEX `Duplicate_System_Client`(`sSysClient`),
    INDEX `FK_sysclient_nBankAssociateID`(`nBankAssociateID`),
    INDEX `FK_sysclient_nBankFeatureTemplateID`(`nBankFeatureTemplateID`),
    INDEX `FK_sysclient_nCreatedID`(`nCreatedID`),
    INDEX `FK_sysclient_nCurrencyID`(`nSysCurrencyID`),
    INDEX `FK_sysclient_nModifiedID`(`nModifiedID`),
    INDEX `bCurrent`(`bCurrent`),
    PRIMARY KEY (`nSysClientID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sysclientloc` (
    `nSysClientLocID` INTEGER UNSIGNED NOT NULL,
    `nSysClientID` INTEGER UNSIGNED NOT NULL,
    `sSysClientLoc` VARCHAR(100) NOT NULL,
    `sSysAdr1` VARCHAR(100) NOT NULL,
    `sSysAdr2` VARCHAR(100) NOT NULL,
    `sSysAdr3` VARCHAR(100) NOT NULL,
    `sSysPhone` VARCHAR(100) NOT NULL,
    `sSysFax` VARCHAR(50) NOT NULL,
    `sSysEmail` VARCHAR(100) NOT NULL,
    `sWeb` VARCHAR(100) NOT NULL,
    `sSysECCNo` VARCHAR(50) NOT NULL,
    `sSysVATTIN` VARCHAR(50) NOT NULL,
    `sSysCSTTIN` VARCHAR(50) NOT NULL,
    `dtSysStart` VARCHAR(11) NOT NULL,
    `sSigneeText` VARCHAR(150) NOT NULL,
    `sSignee` VARCHAR(150) NOT NULL,
    `sRange` VARCHAR(100) NOT NULL,
    `sDivision` VARCHAR(100) NOT NULL,
    `sCommissionerate` VARCHAR(100) NOT NULL,
    `sCollectorate` VARCHAR(100) NOT NULL,
    `sServiceTax` VARCHAR(100) NOT NULL,
    `sLBTNo` VARCHAR(100) NOT NULL,
    `sEPCGLicenceNo` VARCHAR(100) NOT NULL,
    `sGSTNo` VARCHAR(200) NOT NULL DEFAULT '',
    `sPinno` VARCHAR(10) NOT NULL DEFAULT '0',
    `bFixed` TINYINT NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_sysclientloc_nCreatedID`(`nCreatedID`),
    INDEX `FK_sysclientloc_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `Duplicate_System_Client_Location`(`nSysClientID`, `sSysClientLoc`),
    PRIMARY KEY (`nSysClientLocID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sysclientmodulesetting` (
    `nsysclientmodulesettingid` INTEGER UNSIGNED NOT NULL,
    `nBankModuleSettingid` INTEGER UNSIGNED NOT NULL,
    `nSysClientId` INTEGER UNSIGNED NOT NULL,
    `sValue` VARCHAR(200) NULL,
    `bFixed` TINYINT NULL DEFAULT 1,
    `nCreatedID` INTEGER UNSIGNED NOT NULL DEFAULT 1,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL DEFAULT 1,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_sysclientmodulesetting_nBankModuleSettingid`(`nBankModuleSettingid`),
    INDEX `FK_sysrecord_nCreatedID`(`nCreatedID`),
    INDEX `FK_sysrecord_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `Dupli_TableName_ColumnName`(`nSysClientId`, `nBankModuleSettingid`),
    PRIMARY KEY (`nsysclientmodulesettingid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sysdocmgt` (
    `nSysDocMgtID` INTEGER UNSIGNED NOT NULL,
    `sSysDoc` VARCHAR(50) NULL,
    `nSysYrStartMonth` INTEGER NULL,
    `bSysYrwise` TINYINT NULL,
    `sSysStartNo` VARCHAR(10) NULL,
    `nSysDigits` INTEGER NULL,
    `sSysPrefix` VARCHAR(10) NULL,
    `sSysSuffix` VARCHAR(10) NULL,
    `sSeq` VARCHAR(20) NULL,
    `sSeparator` VARCHAR(10) NULL,
    `sSysNewPrefix` VARCHAR(10) NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    UNIQUE INDEX `Duplicate_System_Doc_Mgt`(`sSysDoc`),
    INDEX `FK_sysdocmgt_nCreatedID`(`nCreatedID`),
    INDEX `FK_sysdocmgt_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nSysDocMgtID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sysrecord` (
    `nSysRecordID` INTEGER UNSIGNED NOT NULL,
    `sTableName` VARCHAR(500) NULL,
    `sColumnName` VARCHAR(200) NULL,
    `bFixed` TINYINT NULL DEFAULT 1,
    `nCreatedID` INTEGER UNSIGNED NOT NULL DEFAULT 1,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL DEFAULT 1,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_sysrecord_nCreatedID`(`nCreatedID`),
    INDEX `FK_sysrecord_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `Dupli_TableName_ColumnName`(`sTableName`, `sColumnName`),
    PRIMARY KEY (`nSysRecordID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sysrecorddet` (
    `nSysRecordDetID` INTEGER UNSIGNED NOT NULL,
    `nSysRecordID` INTEGER UNSIGNED NOT NULL,
    `sRecordDesc` VARCHAR(500) NULL,
    `bFixed` TINYINT NULL DEFAULT 1,
    `nCreatedID` INTEGER UNSIGNED NOT NULL DEFAULT 1,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL DEFAULT 1,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_sysrecorddet_nCreatedID`(`nCreatedID`),
    INDEX `FK_sysrecorddet_nModifiedID`(`nModifiedID`),
    INDEX `FK_sysrecorddet_nSysRecordID`(`nSysRecordID`),
    UNIQUE INDEX `Dupli_Sys_RecordDesc`(`nSysRecordID`, `sRecordDesc`),
    PRIMARY KEY (`nSysRecordDetID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sysversions` (
    `nSysVersionID` INTEGER UNSIGNED NOT NULL,
    `dtVersion` VARCHAR(11) NOT NULL,
    `nVersionNo` DOUBLE NOT NULL,
    `sRemarks` LONGBLOB NOT NULL,
    `sCustRemarks` VARCHAR(10000) NOT NULL,
    `sScript` VARCHAR(10000) NULL,
    `bFixed` TINYINT NOT NULL DEFAULT 1,
    `nCreatedID` INTEGER UNSIGNED NOT NULL DEFAULT 1,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL DEFAULT 1,
    `dtModified` DATETIME(0) NOT NULL,

    PRIMARY KEY (`nSysVersionID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `taskchecklist` (
    `nTaskChecklistID` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `nTaskID` INTEGER UNSIGNED NOT NULL,
    `sChecklist` LONGBLOB NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `dtmodified` DATETIME(0) NULL,

    INDEX `FK_taskchecklist_nCreatedID`(`nCreatedID`),
    INDEX `FK_taskchecklist_nModifiedID`(`nModifiedID`),
    INDEX `FK_taskchecklist_nTaskID`(`nTaskID`),
    PRIMARY KEY (`nTaskChecklistID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tchat` (
    `nChatID` INTEGER UNSIGNED NOT NULL,
    `sTransType` VARCHAR(50) NULL,
    `nTransID` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tchat_nCreatedID`(`nCreatedID`),
    INDEX `FK_tchat_nModifiedID`(`nModifiedID`),
    INDEX `nTransID`(`nTransID`),
    INDEX `sTransType`(`sTransType`),
    PRIMARY KEY (`nChatID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tchatdet` (
    `nChatDetID` INTEGER UNSIGNED NOT NULL,
    `nChatID` INTEGER UNSIGNED NOT NULL,
    `nUserID` INTEGER UNSIGNED NOT NULL,
    `sComment` VARCHAR(1000) NULL,
    `sDatetime` VARCHAR(50) NULL,
    `sStage` VARCHAR(100) NULL DEFAULT '',
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tchat_nCreatedID`(`nCreatedID`),
    INDEX `FK_tchat_nModifiedID`(`nModifiedID`),
    INDEX `FK_tchatdet_nChatID`(`nChatID`),
    INDEX `FK_tchatdet_nUserID`(`nUserID`),
    PRIMARY KEY (`nChatDetID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tdashelementconfig` (
    `nDashElementConfigID` INTEGER UNSIGNED NOT NULL,
    `nUserID` INTEGER UNSIGNED NOT NULL,
    `nBankDashSysclientConfigID` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtcreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtmodified` DATETIME(0) NULL,

    INDEX `FK_tdashelementconfig_nBankDashSysclientConfigID`(`nBankDashSysclientConfigID`),
    INDEX `FK_tdashelementconfig_nCreatedID`(`nCreatedID`),
    INDEX `FK_tdashelementconfig_nModifiedID`(`nModifiedID`),
    INDEX `FK_tdashelementconfig_nUserID`(`nUserID`),
    PRIMARY KEY (`nDashElementConfigID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tdashelementconfigcompanywise` (
    `nDashElementConfigCompanyWiseID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `nBankDashSysclientConfigID` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtcreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtmodified` DATETIME(0) NULL,

    INDEX `FK_tdashelementconfigcompanywise_nBankDashSysclientConfigID`(`nBankDashSysclientConfigID`),
    INDEX `FK_tdashelementconfigcompanywise_nCompanyID`(`nCompanyID`),
    INDEX `FK_tdashelementconfigcompanywise_nCreatedID`(`nCreatedID`),
    INDEX `FK_tdashelementconfigcompanywise_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nDashElementConfigCompanyWiseID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tdashelementconfigfav` (
    `nDashElementConfigFavID` INTEGER UNSIGNED NOT NULL,
    `nUserID` INTEGER UNSIGNED NOT NULL,
    `nBankDashSysclientConfigID` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtcreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtmodified` DATETIME(0) NULL,

    INDEX `FK_tdashelementconfig_nBankDashSysclientConfigID`(`nBankDashSysclientConfigID`),
    INDEX `FK_tdashelementconfig_nCreatedID`(`nCreatedID`),
    INDEX `FK_tdashelementconfig_nModifiedID`(`nModifiedID`),
    INDEX `FK_tdashelementconfig_nUserID`(`nUserID`),
    PRIMARY KEY (`nDashElementConfigFavID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tdashelementlimit` (
    `nDashElementLimitID` INTEGER UNSIGNED NOT NULL,
    `nBankDashSysclientConfigID` INTEGER UNSIGNED NOT NULL,
    `nLowerLimit` DOUBLE NULL,
    `nUpperLimit` DOUBLE NULL,
    `nTimeInterval` INTEGER UNSIGNED NOT NULL,
    `sTimeIntervalIn` VARCHAR(100) NULL DEFAULT '',
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_tdashelementlimit_nBankDashSysclientConfigID`(`nBankDashSysclientConfigID`),
    INDEX `FK_tdashelementlimit_nCreatedID`(`nCreatedID`),
    INDEX `FK_tdashelementlimit_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nDashElementLimitID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `temailcredential` (
    `nEmailCredID` INTEGER UNSIGNED NOT NULL,
    `sDocumentType` VARCHAR(100) NOT NULL,
    `sEmail` VARCHAR(150) NOT NULL,
    `sPassword` VARCHAR(150) NOT NULL,
    `sSMTPMailHost` VARCHAR(150) NOT NULL,
    `nSMTPMailPortNo` DOUBLE NOT NULL,
    `sEnableSSL` VARCHAR(25) NOT NULL,
    `sEmailAliasName` VARCHAR(150) NOT NULL,
    `nCreatedid` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedid` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    UNIQUE INDEX `DocUnique`(`sDocumentType`),
    PRIMARY KEY (`nEmailCredID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tevent` (
    `nEventID` INTEGER UNSIGNED NOT NULL,
    `sSubject` VARCHAR(50) NULL,
    `dtStartDate` VARCHAR(20) NOT NULL DEFAULT '',
    `dtEndDate` VARCHAR(20) NULL,
    `sRemarks` VARCHAR(250) NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_tevent_nCreatedID`(`nCreatedID`),
    INDEX `FK_tevent_nModifiedID`(`nModifiedID`),
    INDEX `FK_ttaskschassigned_ttasksch`(`dtStartDate`),
    PRIMARY KEY (`nEventID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tisac` (
    `nISACID` INTEGER UNSIGNED NOT NULL,
    `nUserID` INTEGER NULL,
    `dtExpiry` VARCHAR(255) NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` VARCHAR(10) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` VARCHAR(10) NULL,

    PRIMARY KEY (`nISACID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tmessage` (
    `nMessageID` INTEGER UNSIGNED NOT NULL,
    `sSubject` VARCHAR(250) NULL,
    `sComment` VARCHAR(10000) NULL,
    `nMessageToID` VARCHAR(3000) NOT NULL DEFAULT '',
    `dtMessage` VARCHAR(10) NULL,
    `sDocTable` VARCHAR(200) NOT NULL,
    `nDocTableID` INTEGER UNSIGNED NOT NULL,
    `sMasterTable` VARCHAR(200) NOT NULL,
    `nMasterTableID` INTEGER UNSIGNED NOT NULL,
    `sRelatedTo` VARCHAR(500) NOT NULL,
    `bClose` TINYINT NULL DEFAULT 0,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mitem_nCreatedID`(`nCreatedID`),
    INDEX `FK_mitem_nItemCatID`(`nMessageToID`(767)),
    INDEX `FK_mitem_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nMessageID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tmom` (
    `nMOMID` INTEGER UNSIGNED NOT NULL,
    `dtMOM` VARCHAR(10) NOT NULL,
    `sStartTime` VARCHAR(15) NOT NULL DEFAULT '',
    `sEndTime` VARCHAR(15) NOT NULL DEFAULT '',
    `sMOMNO` VARCHAR(50) NOT NULL DEFAULT '',
    `sMeetLoc` VARCHAR(250) NOT NULL DEFAULT '',
    `nCustID` INTEGER UNSIGNED NOT NULL,
    `sAttendee` VARCHAR(250) NOT NULL,
    `sRemarks` VARCHAR(250) NOT NULL,
    `dtEndDate` VARCHAR(10) NOT NULL DEFAULT '',
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mcust_nCreatedID`(`nCreatedID`),
    INDEX `FK_mcust_nModifiedID`(`nModifiedID`),
    INDEX `tmom_nCustID`(`nCustID`),
    PRIMARY KEY (`nMOMID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tmomdet` (
    `nMOMDetID` INTEGER UNSIGNED NOT NULL,
    `nMOMID` INTEGER UNSIGNED NOT NULL,
    `sSRNO` VARCHAR(10) NOT NULL DEFAULT '',
    `sAgenda` TEXT NOT NULL,
    `sAttachment` VARCHAR(200) NOT NULL DEFAULT '',
    `sAction` VARCHAR(5000) NOT NULL DEFAULT '',
    `nPriority` TINYINT NOT NULL DEFAULT 0,
    `nServiceID` INTEGER UNSIGNED NOT NULL,
    `sRequestFor` VARCHAR(50) NOT NULL DEFAULT '',
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_mcust_nCreatedID`(`nCreatedID`),
    INDEX `FK_mcust_nModifiedID`(`nModifiedID`),
    INDEX `tmomdet_nMOMID`(`nMOMID`),
    INDEX `tmomdet_nServiceID`(`nServiceID`),
    PRIMARY KEY (`nMOMDetID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tnotification` (
    `nNotificationID` INTEGER UNSIGNED NOT NULL,
    `sNoticeMessage` VARCHAR(1000) NULL,
    `nforUserID` INTEGER UNSIGNED NOT NULL,
    `bReadFlag` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tchat_nCreatedID`(`nCreatedID`),
    INDEX `FK_tchat_nModifiedID`(`nModifiedID`),
    INDEX `FK_tnotification_nforUserID`(`nforUserID`),
    PRIMARY KEY (`nNotificationID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `totp` (
    `nOTPID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `nInitiatedBy` INTEGER UNSIGNED NOT NULL,
    `nStartTime` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `nEndTime` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `sOTPNumber` VARCHAR(10) NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_totp_nCreatedID`(`nCreatedID`),
    INDEX `FK_totp_nInitiatedBy`(`nInitiatedBy`),
    INDEX `FK_totp_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nOTPID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotation` (
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `nCustID` INTEGER UNSIGNED NOT NULL,
    `sRefNo` VARCHAR(100) NOT NULL,
    `dtQuotation` VARCHAR(11) NOT NULL,
    `sStage` VARCHAR(30) NOT NULL,
    `sTaxPercentage` VARCHAR(50) NOT NULL,
    `nMarginPercentage` DOUBLE NOT NULL,
    `nWastageMaterialPercentage` DOUBLE NOT NULL,
    `nWastageEdgebandingPercentage` DOUBLE NOT NULL,
    `nSubtotalAmt` DOUBLE NOT NULL,
    `nDiscountPercentage` DOUBLE NOT NULL,
    `nDiscountAmt` DOUBLE NOT NULL,
    `nSubTotalAfterDiscount` DOUBLE NOT NULL,
    `nManufacturingCostAmt` DOUBLE NOT NULL,
    `nInstallationAmt` DOUBLE NOT NULL,
    `nGrossTotalBeforeTax` DOUBLE NOT NULL,
    `nTaxAmount` DOUBLE NOT NULL,
    `nTotalAmt` DOUBLE NOT NULL,
    `nOrderAmt` DOUBLE NOT NULL,
    `sDetails` VARCHAR(500) NOT NULL,
    `sTerms1` VARCHAR(2000) NOT NULL,
    `sTerms2` VARCHAR(2000) NOT NULL,
    `sTerms3` VARCHAR(2000) NOT NULL,
    `nSiteVisitCharges` DOUBLE NOT NULL,
    `dtOrderDate` VARCHAR(11) NOT NULL,
    `nLatestAmendmentNo` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `dtLatestAmendment` VARCHAR(11) NOT NULL,
    `sLatestAmendRemarks` VARCHAR(300) NOT NULL,
    `sQuotProjectHeaderLine7` VARCHAR(255) NOT NULL,
    `sQuotProjectHeaderLine8` VARCHAR(255) NOT NULL,
    `sQuotProjectHeaderLine9` VARCHAR(255) NOT NULL,
    `sQuotProjectHeaderLine10` VARCHAR(255) NOT NULL,
    `bImportFrom` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `sStarWidth` VARCHAR(100) NOT NULL,
    `sStarDepth` VARCHAR(100) NOT NULL,
    `sStarHeight` VARCHAR(100) NOT NULL,
    `sStarCoreMaterial` VARCHAR(100) NOT NULL,
    `sStarFinish` VARCHAR(100) NOT NULL,
    `sStarArticleCode` VARCHAR(100) NOT NULL,
    `sStarThickness` VARCHAR(100) NOT NULL,
    `sTwoStarWidth` VARCHAR(100) NOT NULL,
    `sTwoStarDepth` VARCHAR(100) NOT NULL,
    `sTwoStarHeight` VARCHAR(100) NOT NULL,
    `sTwoStarCoreMaterial` VARCHAR(100) NOT NULL,
    `sTwoStarFinish` VARCHAR(100) NOT NULL,
    `sTwoStarArticleCode` VARCHAR(100) NOT NULL,
    `sTwoStarThickness` VARCHAR(100) NOT NULL,
    `sThreeStarWidth` VARCHAR(100) NOT NULL,
    `sThreeStarDepth` VARCHAR(100) NOT NULL,
    `sThreeStarHeight` VARCHAR(100) NOT NULL,
    `sThreeStarCoreMaterial` VARCHAR(100) NOT NULL,
    `sThreeStarFinish` VARCHAR(100) NOT NULL,
    `sThreeStarArticleCode` VARCHAR(100) NOT NULL,
    `sThreeStarThickness` VARCHAR(100) NOT NULL,
    `sStarCoreMaterialChild` VARCHAR(100) NOT NULL,
    `sStarFinishChild` VARCHAR(100) NOT NULL,
    `sStarArticleCodeChild` VARCHAR(100) NOT NULL,
    `sTwoStarCoreMaterialChild` VARCHAR(100) NOT NULL,
    `sTwoStarFinishChild` VARCHAR(100) NOT NULL,
    `sTwoStarArticleCodeChild` VARCHAR(100) NOT NULL,
    `sThreeStarCoreMaterialChild` VARCHAR(100) NOT NULL,
    `sThreeStarFinishChild` VARCHAR(100) NOT NULL,
    `sThreeStarArticleCodeChild` VARCHAR(100) NOT NULL,
    `dtQuoteValid` VARCHAR(11) NOT NULL,
    `sDocumentNo` VARCHAR(50) NOT NULL,
    `nDocumentSequenceNo` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `sNestingPriceCalMethod` VARCHAR(10) NOT NULL DEFAULT '0',
    `nUserDefinedCharges2` DOUBLE NOT NULL DEFAULT 0,
    `nUserDefinedCharges3` DOUBLE NOT NULL DEFAULT 0,
    `nUserDefinedCharges4` DOUBLE NOT NULL DEFAULT 0,
    `sQuotePriceGroupDef` VARCHAR(20) NOT NULL,
    `sQuotePriceGroup1` VARCHAR(20) NOT NULL,
    `sQuotePriceGroup2` VARCHAR(20) NOT NULL,
    `nSubtotalAmt1` DOUBLE NOT NULL,
    `nDiscountAmt1` DOUBLE NOT NULL,
    `nSubTotalAfterDiscount1` DOUBLE NOT NULL,
    `nManufacturingCostAmt1` DOUBLE NOT NULL,
    `nInstallationAmt1` DOUBLE NOT NULL,
    `nGrossTotalBeforeTax1` DOUBLE NOT NULL,
    `nTaxAmount1` DOUBLE NOT NULL,
    `nTotalAmt1` DOUBLE NOT NULL,
    `nSubtotalAmt2` DOUBLE NOT NULL,
    `nDiscountAmt2` DOUBLE NOT NULL,
    `nSubTotalAfterDiscount2` DOUBLE NOT NULL,
    `nManufacturingCostAmt2` DOUBLE NOT NULL,
    `nInstallationAmt2` DOUBLE NOT NULL,
    `nGrossTotalBeforeTax2` DOUBLE NOT NULL,
    `nTaxAmount2` DOUBLE NOT NULL,
    `nTotalAmt2` DOUBLE NOT NULL,
    `sProjectNo` VARCHAR(50) NOT NULL,
    `nProjectSequenceNo` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `bNestingRunning` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bOrderLock` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `dtNestingStart` VARCHAR(25) NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotation_nCompanyID`(`nCompanyID`),
    INDEX `FK_tquotation_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotation_nCustID`(`nCustID`),
    INDEX `FK_tquotation_nModifiedID`(`nModifiedID`),
    INDEX `INDEX_tquotation_dtQuotation`(`dtQuotation`),
    INDEX `INDEX_tquotation_sRefNo`(`sRefNo`),
    PRIMARY KEY (`nQuotationID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotation_amend` (
    `nQuotation_AmendID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `nCustID` INTEGER UNSIGNED NOT NULL,
    `sRefNo` VARCHAR(100) NOT NULL,
    `dtQuotation` VARCHAR(11) NOT NULL,
    `sStage` VARCHAR(30) NOT NULL,
    `sTaxPercentage` VARCHAR(50) NOT NULL,
    `nMarginPercentage` DOUBLE NOT NULL,
    `nWastageMaterialPercentage` DOUBLE NOT NULL,
    `nWastageEdgebandingPercentage` DOUBLE NOT NULL,
    `nSubtotalAmt` DOUBLE NOT NULL,
    `nDiscountPercentage` DOUBLE NOT NULL,
    `nDiscountAmt` DOUBLE NOT NULL,
    `nSubTotalAfterDiscount` DOUBLE NOT NULL,
    `nManufacturingCostAmt` DOUBLE NOT NULL,
    `nInstallationAmt` DOUBLE NOT NULL,
    `nGrossTotalBeforeTax` DOUBLE NOT NULL,
    `nTaxAmount` DOUBLE NOT NULL,
    `nTotalAmt` DOUBLE NOT NULL,
    `nOrderAmt` DOUBLE NOT NULL,
    `sDetails` VARCHAR(500) NOT NULL,
    `sTerms1` VARCHAR(2000) NOT NULL,
    `sTerms2` VARCHAR(2000) NOT NULL,
    `sTerms3` VARCHAR(2000) NOT NULL,
    `nSiteVisitCharges` DOUBLE NOT NULL,
    `dtOrderDate` VARCHAR(11) NOT NULL,
    `nLatestAmendmentNo` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `dtLatestAmendment` VARCHAR(11) NOT NULL,
    `sLatestAmendRemarks` VARCHAR(300) NOT NULL,
    `sQuotProjectHeaderLine7` VARCHAR(255) NOT NULL,
    `sQuotProjectHeaderLine8` VARCHAR(255) NOT NULL,
    `sQuotProjectHeaderLine9` VARCHAR(255) NOT NULL,
    `sQuotProjectHeaderLine10` VARCHAR(255) NOT NULL,
    `bImportFrom` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `sStarWidth` VARCHAR(100) NOT NULL,
    `sStarDepth` VARCHAR(100) NOT NULL,
    `sStarHeight` VARCHAR(100) NOT NULL,
    `sStarCoreMaterial` VARCHAR(100) NOT NULL,
    `sStarFinish` VARCHAR(100) NOT NULL,
    `sStarArticleCode` VARCHAR(100) NOT NULL,
    `sStarThickness` VARCHAR(100) NOT NULL,
    `sTwoStarWidth` VARCHAR(100) NOT NULL,
    `sTwoStarDepth` VARCHAR(100) NOT NULL,
    `sTwoStarHeight` VARCHAR(100) NOT NULL,
    `sTwoStarCoreMaterial` VARCHAR(100) NOT NULL,
    `sTwoStarFinish` VARCHAR(100) NOT NULL,
    `sTwoStarArticleCode` VARCHAR(100) NOT NULL,
    `sTwoStarThickness` VARCHAR(100) NOT NULL,
    `sThreeStarWidth` VARCHAR(100) NOT NULL,
    `sThreeStarDepth` VARCHAR(100) NOT NULL,
    `sThreeStarHeight` VARCHAR(100) NOT NULL,
    `sThreeStarCoreMaterial` VARCHAR(100) NOT NULL,
    `sThreeStarFinish` VARCHAR(100) NOT NULL,
    `sThreeStarArticleCode` VARCHAR(100) NOT NULL,
    `sThreeStarThickness` VARCHAR(100) NOT NULL,
    `sStarCoreMaterialChild` VARCHAR(100) NOT NULL,
    `sStarFinishChild` VARCHAR(100) NOT NULL,
    `sStarArticleCodeChild` VARCHAR(100) NOT NULL,
    `sTwoStarCoreMaterialChild` VARCHAR(100) NOT NULL,
    `sTwoStarFinishChild` VARCHAR(100) NOT NULL,
    `sTwoStarArticleCodeChild` VARCHAR(100) NOT NULL,
    `sThreeStarCoreMaterialChild` VARCHAR(100) NOT NULL,
    `sThreeStarFinishChild` VARCHAR(100) NOT NULL,
    `sThreeStarArticleCodeChild` VARCHAR(100) NOT NULL,
    `dtQuoteValid` VARCHAR(11) NOT NULL,
    `sDocumentNo` VARCHAR(50) NOT NULL,
    `nDocumentSequenceNo` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `sNestingPriceCalMethod` VARCHAR(10) NOT NULL DEFAULT '0',
    `nUserDefinedCharges2` DOUBLE NOT NULL DEFAULT 0,
    `nUserDefinedCharges3` DOUBLE NOT NULL DEFAULT 0,
    `nUserDefinedCharges4` DOUBLE NOT NULL DEFAULT 0,
    `sQuotePriceGroupDef` VARCHAR(20) NOT NULL,
    `sQuotePriceGroup1` VARCHAR(20) NOT NULL,
    `sQuotePriceGroup2` VARCHAR(20) NOT NULL,
    `nSubtotalAmt1` DOUBLE NOT NULL,
    `nDiscountAmt1` DOUBLE NOT NULL,
    `nSubTotalAfterDiscount1` DOUBLE NOT NULL,
    `nManufacturingCostAmt1` DOUBLE NOT NULL,
    `nInstallationAmt1` DOUBLE NOT NULL,
    `nGrossTotalBeforeTax1` DOUBLE NOT NULL,
    `nTaxAmount1` DOUBLE NOT NULL,
    `nTotalAmt1` DOUBLE NOT NULL,
    `nSubtotalAmt2` DOUBLE NOT NULL,
    `nDiscountAmt2` DOUBLE NOT NULL,
    `nSubTotalAfterDiscount2` DOUBLE NOT NULL,
    `nManufacturingCostAmt2` DOUBLE NOT NULL,
    `nInstallationAmt2` DOUBLE NOT NULL,
    `nGrossTotalBeforeTax2` DOUBLE NOT NULL,
    `nTaxAmount2` DOUBLE NOT NULL,
    `nTotalAmt2` DOUBLE NOT NULL,
    `sProjectNo` VARCHAR(50) NOT NULL,
    `nProjectSequenceNo` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `bNestingRunning` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bOrderLock` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `dtNestingStart` VARCHAR(25) NOT NULL,
    `nAmendmentNo` INTEGER UNSIGNED NOT NULL,
    `dtAmendment` VARCHAR(11) NOT NULL,
    `sAmendRemarks` VARCHAR(300) NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotation_amend_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotation_amend_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotation_amend_nQuotationID`(`nQuotationID`),
    PRIMARY KEY (`nQuotation_AmendID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationcatwisemarkupdisc` (
    `nQuotationcatwiseMarkupDiscID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nItemCategoryID` INTEGER UNSIGNED NOT NULL,
    `nDiscountPercentage` DOUBLE NOT NULL,
    `nMarkupPercentage` DOUBLE NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationcatwisemarkupdisc_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationcatwisemarkupdisc_nItemCategoryID`(`nItemCategoryID`),
    INDEX `FK_tquotationcatwisemarkupdisc_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationcatwisemarkupdisc_nQuotationID`(`nQuotationID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationcatwisemarkupdisc_amend` (
    `nQuotationcatwiseMarkupDiscID_AmendID` INTEGER UNSIGNED NOT NULL,
    `nQuotationcatwiseMarkupDiscID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nItemCategoryID` INTEGER UNSIGNED NOT NULL,
    `nDiscountPercentage` DOUBLE NOT NULL,
    `nMarkupPercentage` DOUBLE NOT NULL,
    `nQuotation_AmendID` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationcatwisemarkupdisc_amend_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationcatwisemarkupdisc_amend_nItemCategoryID`(`nItemCategoryID`),
    INDEX `FK_tquotationcatwisemarkupdisc_amend_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationcatwisemarkupdisc_amend_nQuotation_AmendID`(`nQuotation_AmendID`),
    PRIMARY KEY (`nQuotationcatwiseMarkupDiscID_AmendID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationcutdetails` (
    `nQuotationCutpartDetailsID` INTEGER UNSIGNED NOT NULL,
    `nQuotationStockpartDetailsID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nCutSeqNo` INTEGER UNSIGNED NOT NULL,
    `nX1` DOUBLE NOT NULL,
    `nY1` DOUBLE NOT NULL,
    `nX2` DOUBLE NOT NULL,
    `nY2` DOUBLE NOT NULL,
    `bLevel` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationcutdetails_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationcutdetails_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationcutdetails_nQuotationID`(`nQuotationID`),
    INDEX `FK_tquotationcutdetails_nQuotationStockpartDetailsID`(`nQuotationStockpartDetailsID`),
    PRIMARY KEY (`nQuotationCutpartDetailsID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationcutpartdetails` (
    `nQuotationCutpartDetailsID` INTEGER UNSIGNED NOT NULL,
    `nQuotationStockpartDetailsID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nQuotationItemsID` INTEGER UNSIGNED NOT NULL,
    `nLength` INTEGER UNSIGNED NOT NULL,
    `nHeight` INTEGER UNSIGNED NOT NULL,
    `nXaxis` INTEGER UNSIGNED NOT NULL,
    `nYaxis` INTEGER UNSIGNED NOT NULL,
    `bRotated` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationcutpartdetails_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationcutpartdetails_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationcutpartdetails_nQuotationDetID`(`nQuotationItemsID`),
    INDEX `FK_tquotationcutpartdetails_nQuotationID`(`nQuotationID`),
    INDEX `FK_tquotationcutpartdetails_nQuotationMaterialLayoutID`(`nQuotationStockpartDetailsID`),
    PRIMARY KEY (`nQuotationCutpartDetailsID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationcutpartdetails_amend` (
    `nQuotationCutpartDetails_AmendID` INTEGER UNSIGNED NOT NULL,
    `nQuotationCutpartDetailsID` INTEGER UNSIGNED NOT NULL,
    `nQuotationStockpartDetailsID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nQuotationItemsID` INTEGER UNSIGNED NOT NULL,
    `nLength` INTEGER UNSIGNED NOT NULL,
    `nHeight` INTEGER UNSIGNED NOT NULL,
    `nXaxis` INTEGER UNSIGNED NOT NULL,
    `nYaxis` INTEGER UNSIGNED NOT NULL,
    `bRotated` TINYINT UNSIGNED NOT NULL,
    `nQuotation_AmendID` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationcutpartdetails_amend_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationcutpartdetails_amend_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationcutpartdetails_amend_nQuotation_AmendID`(`nQuotation_AmendID`),
    PRIMARY KEY (`nQuotationCutpartDetails_AmendID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationfronts` (
    `nQuotationFrontsID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nQuotationItemID` INTEGER UNSIGNED NOT NULL,
    `nBOMDrawerShutterID` INTEGER UNSIGNED NOT NULL,
    `nFW` DOUBLE NOT NULL,
    `nFH` DOUBLE NOT NULL,
    `nActualFW` DOUBLE NOT NULL,
    `nActualFH` DOUBLE NOT NULL,
    `nBOMID` INTEGER UNSIGNED NOT NULL,
    `bDrawer` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationfronts_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationfronts_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationfronts_nQuotationID`(`nQuotationID`),
    INDEX `FK_tquotationfronts_nQuotationItemID`(`nQuotationItemID`),
    PRIMARY KEY (`nQuotationFrontsID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationfronts_amend` (
    `nQuotationFronts_AmendID` INTEGER UNSIGNED NOT NULL,
    `nQuotationFrontsID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nQuotationItemID` INTEGER UNSIGNED NOT NULL,
    `nBOMDrawerShutterID` INTEGER UNSIGNED NOT NULL,
    `nFW` DOUBLE NOT NULL,
    `nFH` DOUBLE NOT NULL,
    `nActualFW` DOUBLE NOT NULL,
    `nActualFH` DOUBLE NOT NULL,
    `nBOMID` INTEGER UNSIGNED NOT NULL,
    `bDrawer` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `nQuotation_AmendID` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationfronts_amend_nQuotation_AmendID`(`nQuotation_AmendID`),
    INDEX `FK_tquotationfronts_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationfronts_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationfronts_nQuotationID`(`nQuotationID`),
    INDEX `FK_tquotationfronts_nQuotationItemID`(`nQuotationItemID`),
    PRIMARY KEY (`nQuotationFronts_AmendID`, `nQuotationFrontsID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationitems` (
    `nQuotationItemsID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `sCategoryName` VARCHAR(255) NULL,
    `nQty` DOUBLE NULL,
    `sName` VARCHAR(255) NULL,
    `nDimension1` DOUBLE NULL,
    `nDimension2` DOUBLE NULL,
    `nDimension3` DOUBLE NULL,
    `nArea` DOUBLE NULL,
    `sDescription` VARCHAR(300) NULL,
    `sCoreMaterial` VARCHAR(255) NULL,
    `sFinish` VARCHAR(255) NULL,
    `sEdgebanding` VARCHAR(500) NULL,
    `sFittingsAutomatic` VARCHAR(500) NULL,
    `sArticleCode` VARCHAR(255) NULL,
    `sVendorCode` VARCHAR(100) NULL,
    `nWeight` DOUBLE NULL,
    `nPerimeter` DOUBLE NULL,
    `nCutLenght` DOUBLE NULL,
    `nCutWidth` DOUBLE NULL,
    `sEL1` VARCHAR(255) NULL,
    `sEL2` VARCHAR(255) NULL,
    `sSL1` VARCHAR(255) NULL,
    `sSL2` VARCHAR(255) NULL,
    `sBarcode1` VARCHAR(255) NULL,
    `sBarcode2` VARCHAR(255) NULL,
    `sUnitNumber` VARCHAR(100) NULL,
    `sdxfFullPath` VARCHAR(100) NULL,
    `sComment` VARCHAR(500) NULL,
    `sOrderID` VARCHAR(100) NULL,
    `sProjectNumber` VARCHAR(255) NULL,
    `sProjectName` VARCHAR(255) NULL,
    `sGroupNo` VARCHAR(100) NULL,
    `sProjectHeaderLine7` VARCHAR(255) NULL,
    `sProjectHeaderLine8` VARCHAR(255) NULL,
    `sProjectHeaderLine9` VARCHAR(255) NULL,
    `sProjectHeaderLine10` VARCHAR(255) NULL,
    `nCost` DOUBLE NOT NULL,
    `nCostAmt` DOUBLE NOT NULL,
    `nHSNID` INTEGER UNSIGNED NOT NULL,
    `nTaxRate` DOUBLE NOT NULL,
    `nItemID` INTEGER UNSIGNED NOT NULL,
    `sStatusRemarks` VARCHAR(500) NOT NULL,
    `nCalculatedQty` DOUBLE NOT NULL,
    `nWastageEdgebandingQty` DOUBLE NOT NULL,
    `nWastageMaterialQty` DOUBLE NOT NULL,
    `nTotalQty` DOUBLE NOT NULL,
    `nMarkupCost` DOUBLE NOT NULL,
    `nTotalCost` DOUBLE NOT NULL,
    `nTotalCostAmt` DOUBLE NOT NULL,
    `nDiscountAmt` DOUBLE NOT NULL,
    `nTotalAfterDiscountAmt` DOUBLE NOT NULL,
    `nTaxAmt` DOUBLE NOT NULL,
    `nTotalAfterTaxAmt` DOUBLE NOT NULL,
    `nAdjustedQty` DOUBLE NOT NULL DEFAULT 0,
    `nItemDiscountPercentage` DOUBLE NOT NULL DEFAULT 0,
    `nOldItemID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `nParentID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `nGroupThickness` DOUBLE NOT NULL DEFAULT 0,
    `nBOMID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `sBOMName` VARCHAR(200) NOT NULL,
    `nRoomTypeID` INTEGER UNSIGNED NOT NULL,
    `nItemExtraMarkupPercentage` DOUBLE NOT NULL DEFAULT 0,
    `bExcludeinNesting` TINYINT NOT NULL DEFAULT 0,
    `bConsideredinNesting` TINYINT NOT NULL DEFAULT 0,
    `sLevelComment` VARCHAR(200) NOT NULL,
    `nNestingPartNumber` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `nCost1` DOUBLE NOT NULL,
    `nCostAmt1` DOUBLE NOT NULL,
    `nMarkupCost1` DOUBLE NOT NULL,
    `nTotalCost1` DOUBLE NOT NULL,
    `nTotalCostAmt1` DOUBLE NOT NULL,
    `nDiscountAmt1` DOUBLE NOT NULL,
    `nTotalAfterDiscountAmt1` DOUBLE NOT NULL,
    `nTaxAmt1` DOUBLE NOT NULL,
    `nTotalAfterTaxAmt1` DOUBLE NOT NULL,
    `nCost2` DOUBLE NOT NULL,
    `nCostAmt2` DOUBLE NOT NULL,
    `nMarkupCost2` DOUBLE NOT NULL,
    `nTotalCost2` DOUBLE NOT NULL,
    `nTotalCostAmt2` DOUBLE NOT NULL,
    `nDiscountAmt2` DOUBLE NOT NULL,
    `nTotalAfterDiscountAmt2` DOUBLE NOT NULL,
    `nTaxAmt2` DOUBLE NOT NULL,
    `nTotalAfterTaxAmt2` DOUBLE NOT NULL,
    `nBOMDetID` INTEGER UNSIGNED NOT NULL,
    `nPreMillWidth` DOUBLE NOT NULL,
    `nParentforEdBandingID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `nQuotationFrontsID` INTEGER UNSIGNED NOT NULL,
    `nParentSeqNo` INTEGER UNSIGNED NOT NULL,
    `nWidthMargin` DOUBLE NOT NULL,
    `nLengthMargin` DOUBLE NOT NULL,
    `sCustomField1` VARCHAR(200) NOT NULL,
    `sCustomField2` VARCHAR(200) NOT NULL,
    `sCustomField3` VARCHAR(200) NOT NULL,
    `sCustomField4` VARCHAR(200) NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationitems_nBOMID`(`nBOMID`),
    INDEX `FK_tquotationitems_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationitems_nItemID`(`nItemID`),
    INDEX `FK_tquotationitems_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationitems_nOldItemID`(`nOldItemID`),
    INDEX `FK_tquotationitems_nQuotationFrontsID`(`nQuotationFrontsID`),
    INDEX `FK_tquotationitems_nQuotationID`(`nQuotationID`),
    INDEX `FK_tquotationitems_nRoomTypeID`(`nRoomTypeID`),
    INDEX `INDEX_tquotationitems_sCategoryName`(`sCategoryName`),
    INDEX `INDEX_tquotationitems_sStatusRemarks`(`sStatusRemarks`),
    PRIMARY KEY (`nQuotationItemsID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationitems_amend` (
    `nQuotationitems_AmendID` INTEGER UNSIGNED NOT NULL,
    `nQuotationItemsID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `sCategoryName` VARCHAR(255) NULL,
    `nQty` DOUBLE NULL,
    `sName` VARCHAR(255) NULL,
    `nDimension1` DOUBLE NULL,
    `nDimension2` DOUBLE NULL,
    `nDimension3` DOUBLE NULL,
    `nArea` DOUBLE NULL,
    `sDescription` VARCHAR(300) NULL,
    `sCoreMaterial` VARCHAR(255) NULL,
    `sFinish` VARCHAR(255) NULL,
    `sEdgebanding` VARCHAR(500) NULL,
    `sFittingsAutomatic` VARCHAR(500) NULL,
    `sArticleCode` VARCHAR(255) NULL,
    `sVendorCode` VARCHAR(100) NULL,
    `nWeight` DOUBLE NULL,
    `nPerimeter` DOUBLE NULL,
    `nCutLenght` DOUBLE NULL,
    `nCutWidth` DOUBLE NULL,
    `sEL1` VARCHAR(255) NULL,
    `sEL2` VARCHAR(255) NULL,
    `sSL1` VARCHAR(255) NULL,
    `sSL2` VARCHAR(255) NULL,
    `sBarcode1` VARCHAR(255) NULL,
    `sBarcode2` VARCHAR(255) NULL,
    `sUnitNumber` VARCHAR(100) NULL,
    `sdxfFullPath` VARCHAR(100) NULL,
    `sComment` VARCHAR(500) NULL,
    `sOrderID` VARCHAR(100) NULL,
    `sProjectNumber` VARCHAR(255) NULL,
    `sProjectName` VARCHAR(255) NULL,
    `sGroupNo` VARCHAR(100) NULL,
    `sProjectHeaderLine7` VARCHAR(255) NULL,
    `sProjectHeaderLine8` VARCHAR(255) NULL,
    `sProjectHeaderLine9` VARCHAR(255) NULL,
    `sProjectHeaderLine10` VARCHAR(255) NULL,
    `nCost` DOUBLE NOT NULL,
    `nCostAmt` DOUBLE NOT NULL,
    `nHSNID` INTEGER UNSIGNED NOT NULL,
    `nTaxRate` DOUBLE NOT NULL,
    `nItemID` INTEGER UNSIGNED NOT NULL,
    `sStatusRemarks` VARCHAR(500) NOT NULL,
    `nCalculatedQty` DOUBLE NOT NULL,
    `nWastageEdgebandingQty` DOUBLE NOT NULL,
    `nWastageMaterialQty` DOUBLE NOT NULL,
    `nTotalQty` DOUBLE NOT NULL,
    `nMarkupCost` DOUBLE NOT NULL,
    `nTotalCost` DOUBLE NOT NULL,
    `nTotalCostAmt` DOUBLE NOT NULL,
    `nDiscountAmt` DOUBLE NOT NULL,
    `nTotalAfterDiscountAmt` DOUBLE NOT NULL,
    `nTaxAmt` DOUBLE NOT NULL,
    `nTotalAfterTaxAmt` DOUBLE NOT NULL,
    `nAdjustedQty` DOUBLE NOT NULL DEFAULT 0,
    `nItemDiscountPercentage` DOUBLE NOT NULL DEFAULT 0,
    `nOldItemID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `nParentID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `nGroupThickness` DOUBLE NOT NULL DEFAULT 0,
    `nBOMID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `sBOMName` VARCHAR(200) NOT NULL,
    `nRoomTypeID` INTEGER UNSIGNED NOT NULL,
    `nItemExtraMarkupPercentage` DOUBLE NOT NULL DEFAULT 0,
    `bExcludeinNesting` TINYINT NOT NULL DEFAULT 0,
    `bConsideredinNesting` TINYINT NOT NULL DEFAULT 0,
    `sLevelComment` VARCHAR(200) NOT NULL,
    `nNestingPartNumber` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `nCost1` DOUBLE NOT NULL,
    `nCostAmt1` DOUBLE NOT NULL,
    `nMarkupCost1` DOUBLE NOT NULL,
    `nTotalCost1` DOUBLE NOT NULL,
    `nTotalCostAmt1` DOUBLE NOT NULL,
    `nDiscountAmt1` DOUBLE NOT NULL,
    `nTotalAfterDiscountAmt1` DOUBLE NOT NULL,
    `nTaxAmt1` DOUBLE NOT NULL,
    `nTotalAfterTaxAmt1` DOUBLE NOT NULL,
    `nCost2` DOUBLE NOT NULL,
    `nCostAmt2` DOUBLE NOT NULL,
    `nMarkupCost2` DOUBLE NOT NULL,
    `nTotalCost2` DOUBLE NOT NULL,
    `nTotalCostAmt2` DOUBLE NOT NULL,
    `nDiscountAmt2` DOUBLE NOT NULL,
    `nTotalAfterDiscountAmt2` DOUBLE NOT NULL,
    `nTaxAmt2` DOUBLE NOT NULL,
    `nTotalAfterTaxAmt2` DOUBLE NOT NULL,
    `nBOMDetID` INTEGER UNSIGNED NOT NULL,
    `nPreMillWidth` DOUBLE NOT NULL,
    `nParentforEdBandingID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `nQuotationFrontsID` INTEGER UNSIGNED NOT NULL,
    `nParentSeqNo` INTEGER UNSIGNED NOT NULL,
    `nWidthMargin` DOUBLE NOT NULL,
    `nLengthMargin` DOUBLE NOT NULL,
    `sCustomField1` VARCHAR(200) NOT NULL,
    `sCustomField2` VARCHAR(200) NOT NULL,
    `sCustomField3` VARCHAR(200) NOT NULL,
    `sCustomField4` VARCHAR(200) NOT NULL,
    `nQuotation_AmendID` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationitems_amend_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationitems_amend_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationitems_amend_nQuotation_AmendID`(`nQuotation_AmendID`),
    INDEX `FK_tquotationitems_amend_nRoomTypeID`(`nRoomTypeID`),
    INDEX `INDEX_tquotationitems_amend_sStatusRemarks`(`sStatusRemarks`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationitemsprocess` (
    `nQuotationItemProcessID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nQuotationItemID` INTEGER UNSIGNED NOT NULL,
    `nItemProcessID` INTEGER UNSIGNED NOT NULL,
    `nProcessCost` DOUBLE NOT NULL,
    `nCalculatedQty` DOUBLE NOT NULL,
    `nProcessCostAmt` DOUBLE NOT NULL,
    `nHSNID` INTEGER UNSIGNED NOT NULL,
    `nTaxRate` DOUBLE NOT NULL,
    `nTaxAmt` DOUBLE NOT NULL,
    `nTotalAfterTaxAmt` DOUBLE NOT NULL,
    `nMarkupCost` DOUBLE NOT NULL,
    `nTotalCost` DOUBLE NOT NULL,
    `nDiscountAmt` DOUBLE NOT NULL,
    `nTotalAfterDiscountAmt` DOUBLE NOT NULL,
    `nRoomTypeID` INTEGER UNSIGNED NOT NULL,
    `nProcessCost1` DOUBLE NOT NULL,
    `nProcessCostAmt1` DOUBLE NOT NULL,
    `nTaxAmt1` DOUBLE NOT NULL,
    `nTotalAfterTaxAmt1` DOUBLE NOT NULL,
    `nMarkupCost1` DOUBLE NOT NULL,
    `nTotalCost1` DOUBLE NOT NULL,
    `nDiscountAmt1` DOUBLE NOT NULL,
    `nTotalAfterDiscountAmt1` DOUBLE NOT NULL,
    `nProcessCost2` DOUBLE NOT NULL,
    `nProcessCostAmt2` DOUBLE NOT NULL,
    `nTaxAmt2` DOUBLE NOT NULL,
    `nTotalAfterTaxAmt2` DOUBLE NOT NULL,
    `nMarkupCost2` DOUBLE NOT NULL,
    `nTotalCost2` DOUBLE NOT NULL,
    `nDiscountAmt2` DOUBLE NOT NULL,
    `nTotalAfterDiscountAmt2` DOUBLE NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationitemsprocess_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationitemsprocess_nItemProcessID`(`nItemProcessID`),
    INDEX `FK_tquotationitemsprocess_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationitemsprocess_nQuotationID`(`nQuotationID`),
    INDEX `FK_tquotationitemsprocess_nQuotationItemID`(`nQuotationItemID`),
    INDEX `FK_tquotationitemsprocess_nRoomTypeID`(`nRoomTypeID`),
    PRIMARY KEY (`nQuotationItemProcessID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationitemsprocess_amend` (
    `nQuotationItemProcess_AmendID` INTEGER UNSIGNED NOT NULL,
    `nQuotationItemProcessID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nQuotationItemID` INTEGER UNSIGNED NOT NULL,
    `nItemProcessID` INTEGER UNSIGNED NOT NULL,
    `nProcessCost` DOUBLE NOT NULL,
    `nCalculatedQty` DOUBLE NOT NULL,
    `nProcessCostAmt` DOUBLE NOT NULL,
    `nHSNID` INTEGER UNSIGNED NOT NULL,
    `nTaxRate` DOUBLE NOT NULL,
    `nTaxAmt` DOUBLE NOT NULL,
    `nTotalAfterTaxAmt` DOUBLE NOT NULL,
    `nMarkupCost` DOUBLE NOT NULL,
    `nTotalCost` DOUBLE NOT NULL,
    `nDiscountAmt` DOUBLE NOT NULL,
    `nTotalAfterDiscountAmt` DOUBLE NOT NULL,
    `nRoomTypeID` INTEGER UNSIGNED NOT NULL,
    `nProcessCost1` DOUBLE NOT NULL,
    `nProcessCostAmt1` DOUBLE NOT NULL,
    `nTaxAmt1` DOUBLE NOT NULL,
    `nTotalAfterTaxAmt1` DOUBLE NOT NULL,
    `nMarkupCost1` DOUBLE NOT NULL,
    `nTotalCost1` DOUBLE NOT NULL,
    `nDiscountAmt1` DOUBLE NOT NULL,
    `nTotalAfterDiscountAmt1` DOUBLE NOT NULL,
    `nProcessCost2` DOUBLE NOT NULL,
    `nProcessCostAmt2` DOUBLE NOT NULL,
    `nTaxAmt2` DOUBLE NOT NULL,
    `nTotalAfterTaxAmt2` DOUBLE NOT NULL,
    `nMarkupCost2` DOUBLE NOT NULL,
    `nTotalCost2` DOUBLE NOT NULL,
    `nDiscountAmt2` DOUBLE NOT NULL,
    `nTotalAfterDiscountAmt2` DOUBLE NOT NULL,
    `nQuotation_AmendID` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationitemsprocess_amend_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationitemsprocess_amend_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationitemsprocess_amend_nQuotation_AmendID`(`nQuotation_AmendID`),
    INDEX `FK_tquotationitemsprocess_amend_nRoomTypeID`(`nRoomTypeID`),
    PRIMARY KEY (`nQuotationItemProcess_AmendID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationitemsvariable` (
    `nQuotationItemsVariableID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nQuotationItemsID` INTEGER UNSIGNED NOT NULL,
    `nBOMVariableID` INTEGER UNSIGNED NOT NULL,
    `sSelectedOption` VARCHAR(50) NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationitemsvariable_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationitemsvariable_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationitemsvariable_nQuotationID`(`nQuotationID`),
    INDEX `FK_tquotationitemsvariable_nQuotationItemsID`(`nQuotationItemsID`),
    PRIMARY KEY (`nQuotationItemsVariableID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationmaterial` (
    `nQuotationMaterialID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `sCoreMaterial` VARCHAR(100) NOT NULL,
    `nBoardLength` INTEGER UNSIGNED NOT NULL,
    `nBoardWidth` INTEGER UNSIGNED NOT NULL,
    `nThickness` DOUBLE NOT NULL,
    `nNoofBoards` INTEGER UNSIGNED NOT NULL,
    `nBoardCost` DOUBLE NOT NULL,
    `nBoardMarkupCost` DOUBLE NOT NULL,
    `nBoardTotalCost` DOUBLE NOT NULL,
    `nBoardTotalCostAmt` DOUBLE NOT NULL,
    `sArticleCode` VARCHAR(255) NOT NULL,
    `nHSNID` INTEGER UNSIGNED NOT NULL,
    `nTaxRate` DOUBLE NOT NULL,
    `nDiscountAmt` DOUBLE NOT NULL,
    `nTotalAfterDiscountAmt` DOUBLE NOT NULL,
    `nTaxAmt` DOUBLE NOT NULL,
    `nTotalAfterTaxAmt` DOUBLE NOT NULL,
    `nItemCategoryID` INTEGER UNSIGNED NOT NULL,
    `nDiscountPercentage` DOUBLE NOT NULL,
    `sFaceCoat1` VARCHAR(255) NOT NULL DEFAULT '',
    `sFaceCoat2` VARCHAR(255) NOT NULL DEFAULT '',
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationmaterial_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationmaterial_nHSNID`(`nHSNID`),
    INDEX `FK_tquotationmaterial_nItemCategoryID`(`nItemCategoryID`),
    INDEX `FK_tquotationmaterial_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationmaterial_nQuotationID`(`nQuotationID`),
    PRIMARY KEY (`nQuotationMaterialID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationmaterial_amend` (
    `nQuotationMaterial_AmendID` INTEGER UNSIGNED NOT NULL,
    `nQuotationMaterialID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `sCoreMaterial` VARCHAR(100) NOT NULL,
    `nBoardLength` INTEGER UNSIGNED NOT NULL,
    `nBoardWidth` INTEGER UNSIGNED NOT NULL,
    `nThickness` DOUBLE NOT NULL,
    `nNoofBoards` INTEGER UNSIGNED NOT NULL,
    `nBoardCost` DOUBLE NOT NULL,
    `nBoardMarkupCost` DOUBLE NOT NULL,
    `nBoardTotalCost` DOUBLE NOT NULL,
    `nBoardTotalCostAmt` DOUBLE NOT NULL,
    `sArticleCode` VARCHAR(255) NOT NULL,
    `nHSNID` INTEGER UNSIGNED NOT NULL,
    `nTaxRate` DOUBLE NOT NULL,
    `nDiscountAmt` DOUBLE NOT NULL,
    `nTotalAfterDiscountAmt` DOUBLE NOT NULL,
    `nTaxAmt` DOUBLE NOT NULL,
    `nTotalAfterTaxAmt` DOUBLE NOT NULL,
    `nItemCategoryID` INTEGER UNSIGNED NOT NULL,
    `nDiscountPercentage` DOUBLE NOT NULL,
    `sFaceCoat1` VARCHAR(255) NOT NULL DEFAULT '',
    `sFaceCoat2` VARCHAR(255) NOT NULL DEFAULT '',
    `nQuotation_AmendID` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationmaterial_amend_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationmaterial_amend_nHSNID`(`nHSNID`),
    INDEX `FK_tquotationmaterial_amend_nItemCategoryID`(`nItemCategoryID`),
    INDEX `FK_tquotationmaterial_amend_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationmaterial_amend_nQuotation_AmendID`(`nQuotation_AmendID`),
    PRIMARY KEY (`nQuotationMaterial_AmendID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationmateriallayout` (
    `nQuotationMaterialLayoutID` INTEGER UNSIGNED NOT NULL,
    `nQuotationMaterialID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nLayoutSeqNo` INTEGER UNSIGNED NOT NULL,
    `nStartStockCount` INTEGER UNSIGNED NOT NULL,
    `nStockCount` INTEGER UNSIGNED NOT NULL,
    `nUtilisationPercentage` DOUBLE NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationmateriallayout_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationmateriallayout_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationmateriallayout_nQuotationID`(`nQuotationID`),
    INDEX `FK_tquotationmateriallayout_nQuotationMaterialID`(`nQuotationMaterialID`),
    PRIMARY KEY (`nQuotationMaterialLayoutID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationmateriallayout_amend` (
    `nQuotationMaterialLayout_AmendID` INTEGER UNSIGNED NOT NULL,
    `nQuotationMaterialLayoutID` INTEGER UNSIGNED NOT NULL,
    `nQuotationMaterialID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nLayoutSeqNo` INTEGER UNSIGNED NOT NULL,
    `nStartStockCount` INTEGER UNSIGNED NOT NULL,
    `nStockCount` INTEGER UNSIGNED NOT NULL,
    `nUtilisationPercentage` DOUBLE NOT NULL,
    `nQuotation_AmendID` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationmateriallayout_amend_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationmateriallayout_amend_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationmateriallayout_amend_nQuotation_AmendID`(`nQuotation_AmendID`),
    PRIMARY KEY (`nQuotationMaterialLayout_AmendID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationpacket` (
    `nQuotationPacketID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nPacketID` INTEGER UNSIGNED NOT NULL,
    `sDescription` VARCHAR(50) NOT NULL,
    `nSeqNo` INTEGER UNSIGNED NOT NULL,
    `sPacketName` VARCHAR(50) NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationpacket_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationpacket_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationpacket_nPacketID`(`nPacketID`),
    INDEX `FK_tquotationpacket_nQuotationID`(`nQuotationID`),
    PRIMARY KEY (`nQuotationPacketID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationpacketdet` (
    `nQuotationPacketDetID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nQuotationPacketID` INTEGER UNSIGNED NOT NULL,
    `nQuotationItemsID` INTEGER UNSIGNED NOT NULL,
    `nPackingQty` DOUBLE NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationpacketdet_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationpacketdet_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationpacketdet_nQuotationID`(`nQuotationID`),
    INDEX `FK_tquotationpacketdet_nQuotationItemsID`(`nQuotationItemsID`),
    INDEX `FK_tquotationpacketdet_nQuotationPacketID`(`nQuotationPacketID`),
    PRIMARY KEY (`nQuotationPacketDetID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationprocesswisemarkupdisc` (
    `nQuotationProcesswiseMarkupDiscID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nItemProcessID` INTEGER UNSIGNED NOT NULL,
    `nDiscountPercentage` DOUBLE NOT NULL,
    `nMarkupPercentage` DOUBLE NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationprocesswisemarkupdisc_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationprocesswisemarkupdisc_nItemProcessID`(`nItemProcessID`),
    INDEX `FK_tquotationprocesswisemarkupdisc_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationprocesswisemarkupdisc_nQuotationID`(`nQuotationID`),
    PRIMARY KEY (`nQuotationProcesswiseMarkupDiscID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationprocesswisemarkupdisc_amend` (
    `nQuotationProcesswiseMarkupDiscID_AmendID` INTEGER UNSIGNED NOT NULL,
    `nQuotationProcesswiseMarkupDiscID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nItemProcessID` INTEGER UNSIGNED NOT NULL,
    `nDiscountPercentage` DOUBLE NOT NULL,
    `nMarkupPercentage` DOUBLE NOT NULL,
    `nQuotation_AmendID` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationprocesswisemarkupdisc_amend_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationprocesswisemarkupdisc_amend_nItemProcessID`(`nItemProcessID`),
    INDEX `FK_tquotationprocesswisemarkupdisc_amend_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationprocesswisemarkupdisc_amend_nQuotation_AmendID`(`nQuotation_AmendID`),
    PRIMARY KEY (`nQuotationProcesswiseMarkupDiscID_AmendID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationroom` (
    `nQuotationRoomID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nRoomTypeID` INTEGER UNSIGNED NOT NULL,
    `sLevelComment` VARCHAR(200) NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationroom_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationroom_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationroom_nQuotationID`(`nQuotationID`),
    INDEX `FK_tquotationroom_nRoomTypeID`(`nRoomTypeID`),
    PRIMARY KEY (`nQuotationRoomID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationroom_amend` (
    `nQuotationRoom_AmendID` INTEGER UNSIGNED NOT NULL,
    `nQuotationRoomID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nRoomTypeID` INTEGER UNSIGNED NOT NULL,
    `sLevelComment` VARCHAR(200) NOT NULL,
    `nQuotation_AmendID` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationroom_amend_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationroom_amend_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationroom_amend_nQuotation_AmendID`(`nQuotation_AmendID`),
    INDEX `FK_tquotationroom_amend_nRoomTypeID`(`nRoomTypeID`),
    PRIMARY KEY (`nQuotationRoom_AmendID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationstockpartdetails` (
    `nQuotationStockpartDetailsID` INTEGER UNSIGNED NOT NULL,
    `nQuotationMaterialLayoutID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nStockSeqNo` INTEGER UNSIGNED NOT NULL,
    `nTotalPartCount` INTEGER UNSIGNED NOT NULL,
    `nTotalRemainingPart` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationstockpartdetails_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationstockpartdetails_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationstockpartdetails_nQuotationID`(`nQuotationID`),
    INDEX `FK_tquotationstockpartdetails_nQuotationMaterialLayoutID`(`nQuotationMaterialLayoutID`),
    PRIMARY KEY (`nQuotationStockpartDetailsID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationstockpartdetails_amend` (
    `nQuotationStockpartDetails_AmendID` INTEGER UNSIGNED NOT NULL,
    `nQuotationStockpartDetailsID` INTEGER UNSIGNED NOT NULL,
    `nQuotationMaterialLayoutID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nStockSeqNo` INTEGER UNSIGNED NOT NULL,
    `nTotalPartCount` INTEGER UNSIGNED NOT NULL,
    `nTotalRemainingPart` INTEGER UNSIGNED NOT NULL,
    `nQuotation_AmendID` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationstockpartdetails_amend_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationstockpartdetails_amend_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationstockpartdetails_amend_nQuotation_AmendID`(`nQuotation_AmendID`),
    PRIMARY KEY (`nQuotationStockpartDetails_AmendID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationwastagefactor` (
    `nQuotationWastageFactorID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nItemCategoryID` INTEGER UNSIGNED NOT NULL,
    `sArticleCodeCoreMaterial` VARCHAR(100) NOT NULL,
    `nWastageMaterialPercentage` DOUBLE NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationprocesswisemarkupdisc_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationprocesswisemarkupdisc_nItemProcessID`(`nItemCategoryID`),
    INDEX `FK_tquotationprocesswisemarkupdisc_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationprocesswisemarkupdisc_nQuotationID`(`nQuotationID`),
    PRIMARY KEY (`nQuotationWastageFactorID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tquotationwastagefactor_amend` (
    `nQuotationWastagefactor_AmendID` INTEGER UNSIGNED NOT NULL,
    `nQuotationWastageFactorID` INTEGER UNSIGNED NOT NULL,
    `nQuotationID` INTEGER UNSIGNED NOT NULL,
    `nItemCategoryID` INTEGER UNSIGNED NOT NULL,
    `sArticleCodeCoreMaterial` VARCHAR(100) NOT NULL,
    `nWastageMaterialPercentage` DOUBLE NOT NULL,
    `nQuotation_AmendID` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_tquotationprocesswisemarkupdisc_nCreatedID`(`nCreatedID`),
    INDEX `FK_tquotationprocesswisemarkupdisc_nItemProcessID`(`nItemCategoryID`),
    INDEX `FK_tquotationprocesswisemarkupdisc_nModifiedID`(`nModifiedID`),
    INDEX `FK_tquotationprocesswisemarkupdisc_nQuotationID`(`nQuotationID`),
    INDEX `FK_tquotationwastagefactor_amend_nQuotation_AmendID`(`nQuotation_AmendID`),
    PRIMARY KEY (`nQuotationWastagefactor_AmendID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tsmscredential` (
    `nSMSCredentialID` INTEGER UNSIGNED NOT NULL,
    `sDocumentType` VARCHAR(100) NOT NULL,
    `sURL` VARCHAR(1000) NOT NULL,
    `nCreatedid` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedid` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    UNIQUE INDEX `UNIQUE_tsmscredential_sDocumentType`(`sDocumentType`),
    INDEX `FK_tsmscredential_nCreatedid`(`nCreatedid`),
    INDEX `FK_tsmscredential_nModifiedid`(`nModifiedid`),
    PRIMARY KEY (`nSMSCredentialID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tsysclientconfigure` (
    `nSysclientconfigid` INTEGER UNSIGNED NOT NULL,
    `nuid` INTEGER UNSIGNED NOT NULL,
    `nBankSysClientConfigID` INTEGER UNSIGNED NOT NULL,
    `nDataEntry` TINYINT NULL DEFAULT 0,
    `nReviewer` TINYINT NULL DEFAULT 0,
    `nApprover` TINYINT NULL DEFAULT 0,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtcreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtmodified` DATETIME(0) NULL,

    PRIMARY KEY (`nSysclientconfigid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tsysclientconfigurecompanywise` (
    `nSysclientConfigureCompanywiseID` INTEGER UNSIGNED NOT NULL,
    `nCompanyID` INTEGER UNSIGNED NOT NULL,
    `nBankSysClientConfigID` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtcreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtmodified` DATETIME(0) NULL,

    INDEX `FK_tsysclientconfigurecompanywise_nBankSysClientConfigID`(`nBankSysClientConfigID`),
    INDEX `FK_tsysclientconfigurecompanywise_nCompanyID`(`nCompanyID`),
    INDEX `FK_tsysclientconfigurecompanywise_nCreatedID`(`nCreatedID`),
    INDEX `FK_tsysclientconfigurecompanywise_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nSysclientConfigureCompanywiseID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tsysclientsystemtaskconfigure` (
    `nSysclienSystemTaskConfigureID` INTEGER UNSIGNED NOT NULL,
    `nuid` INTEGER UNSIGNED NOT NULL,
    `nBankTaskSysclientConfigID` INTEGER UNSIGNED NOT NULL,
    `sTimeIntervalIn` VARCHAR(100) NOT NULL,
    `dtDeadline` VARCHAR(11) NOT NULL,
    `nRepetitionInterval` INTEGER UNSIGNED NOT NULL,
    `nDayofOccurance` INTEGER UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtcreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtmodified` DATETIME(0) NULL,

    INDEX `FK_tsysclientsystemtaskconfigure_nBankTaskSysclientConfigID`(`nBankTaskSysclientConfigID`),
    INDEX `FK_tsysclientsystemtaskconfigure_nCreatedID`(`nCreatedID`),
    INDEX `FK_tsysclientsystemtaskconfigure_nModifiedID`(`nModifiedID`),
    INDEX `FK_tsysclientsystemtaskconfigure_nuid`(`nuid`),
    PRIMARY KEY (`nSysclienSystemTaskConfigureID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tsysclientsystemtaskexecution` (
    `nSysclienSystemTaskExecutionID` INTEGER UNSIGNED NOT NULL,
    `nUID` INTEGER UNSIGNED NOT NULL,
    `nBankTaskSysclientConfigID` INTEGER UNSIGNED NOT NULL,
    `dtExecution` VARCHAR(11) NULL,
    `sExecutionDetails` VARCHAR(1000) NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtcreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtmodified` DATETIME(0) NULL,

    INDEX `FK_tsysclientsystemtaskexecution_nBankTaskSysclientConfigID`(`nBankTaskSysclientConfigID`),
    INDEX `FK_tsysclientsystemtaskexecution_nCreatedID`(`nCreatedID`),
    INDEX `FK_tsysclientsystemtaskexecution_nModifiedID`(`nModifiedID`),
    INDEX `FK_tsysclientsystemtaskexecution_nUID`(`nUID`),
    PRIMARY KEY (`nSysclienSystemTaskExecutionID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tsystemhealth` (
    `nSystemHealthID` INTEGER UNSIGNED NOT NULL,
    `sDocNo` VARCHAR(100) NOT NULL,
    `dtDoc` VARCHAR(10) NOT NULL DEFAULT '',
    `sAttendance` VARCHAR(100) NOT NULL DEFAULT '',
    `dtStartAnalysis` VARCHAR(10) NOT NULL,
    `dtEndAnalysis` VARCHAR(10) NOT NULL,
    `sRemarks` VARCHAR(1000) NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_tsystemhealth_nCreatedID`(`nCreatedID`),
    INDEX `FK_tsystemhealth_nModifiedID`(`nModifiedID`),
    PRIMARY KEY (`nSystemHealthID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tsystemhealthdet` (
    `nSystemHealthDetID` INTEGER UNSIGNED NOT NULL,
    `nSystemHealthID` INTEGER UNSIGNED NOT NULL,
    `nBankmoduleDetID` INTEGER UNSIGNED NOT NULL,
    `nNoofTransactions` DOUBLE NULL,
    `dtLastTransaction` VARCHAR(10) NULL,
    `sResponsible` VARCHAR(150) NULL,
    `sComment` VARCHAR(1000) NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_tsystemhealthdet_nBankmoduleDetID`(`nBankmoduleDetID`),
    INDEX `FK_tsystemhealthdet_nCreatedID`(`nCreatedID`),
    INDEX `FK_tsystemhealthdet_nModifiedID`(`nModifiedID`),
    INDEX `FK_tsystemhealthdet_nSystemHealthID`(`nSystemHealthID`),
    PRIMARY KEY (`nSystemHealthDetID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ttask` (
    `nTaskID` INTEGER UNSIGNED NOT NULL,
    `nTaskTemplateID` INTEGER UNSIGNED NOT NULL,
    `sTaskNo` VARCHAR(50) NULL,
    `sTaskDescription` VARCHAR(2000) NULL DEFAULT '',
    `dtStartDate` VARCHAR(11) NULL,
    `nAssignedToID` INTEGER UNSIGNED NOT NULL,
    `dtTargetDate` VARCHAR(11) NULL,
    `dtRevisedTargetDate` VARCHAR(11) NULL,
    `dtRemind` VARCHAR(11) NULL,
    `sStatusRemarks` VARCHAR(400) NULL,
    `sStatus` VARCHAR(50) NULL,
    `nParentTaskID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `nSourceTaskID` INTEGER UNSIGNED NOT NULL,
    `dtTask` VARCHAR(11) NULL,
    `sProgressingDetails` VARCHAR(2000) NULL DEFAULT '',
    `dtCompletion` VARCHAR(11) NULL DEFAULT '',
    `sMarkUrgency` VARCHAR(50) NULL DEFAULT 'No',
    `sVerify` VARCHAR(50) NULL DEFAULT 'No',
    `nVerifiedID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `nReportToID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `sNotificationstatus` VARCHAR(50) NOT NULL DEFAULT 'No',
    `sDocTable` VARCHAR(200) NOT NULL,
    `nDocTableID` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `sMasterTable` VARCHAR(200) NOT NULL,
    `nMasterTableID` INTEGER NULL DEFAULT 0,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NOT NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NOT NULL,

    INDEX `FK_ttask_nAssignedToID`(`nAssignedToID`),
    INDEX `FK_ttask_nCreatedID`(`nCreatedID`),
    INDEX `FK_ttask_nModifiedID`(`nModifiedID`),
    INDEX `FK_ttask_nParentTaskID`(`nParentTaskID`),
    INDEX `FK_ttask_nReportToID`(`nReportToID`),
    INDEX `FK_ttask_nSourceTaskID`(`nSourceTaskID`),
    INDEX `FK_ttask_nTaskTemplateID`(`nTaskTemplateID`),
    INDEX `FK_ttask_nVerifiedID`(`nVerifiedID`),
    INDEX `Index_dtStartDate`(`dtStartDate`),
    INDEX `Index_dtTargetDate`(`dtTargetDate`),
    INDEX `Index_nDocTableID`(`nDocTableID`),
    INDEX `Index_nMasterTableID`(`nMasterTableID`),
    INDEX `Index_sDocTable`(`sDocTable`),
    INDEX `Index_sMasterTable`(`sMasterTable`),
    INDEX `Index_sStatus`(`sStatus`),
    INDEX `Index_sStatusRemarks`(`sStatusRemarks`),
    INDEX `Index_sTaskNo`(`sTaskNo`),
    PRIMARY KEY (`nTaskID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tuploads` (
    `nUploadId` INTEGER UNSIGNED NOT NULL,
    `sFileName` VARCHAR(250) NOT NULL,
    `sTableName` VARCHAR(250) NOT NULL,
    `nTableID` INTEGER UNSIGNED NOT NULL,
    `sDescription` VARCHAR(500) NOT NULL DEFAULT '',
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_tuploads_nCreatedID`(`nCreatedID`),
    INDEX `FK_tuploads_nModifiedID`(`nModifiedID`),
    INDEX `Index_nTableID`(`nTableID`),
    INDEX `Index_sFileName`(`sFileName`),
    INDEX `Index_sTableName`(`sTableName`),
    PRIMARY KEY (`nUploadId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tuserprofile` (
    `nUserProfileID` INTEGER UNSIGNED NOT NULL,
    `sProfile` VARCHAR(100) NULL,
    `sRemarks` VARCHAR(300) NULL,
    `bFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtCreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtModified` DATETIME(0) NULL,

    INDEX `FK_tuserprofile_nCreatedID`(`nCreatedID`),
    INDEX `FK_tuserprofile_nModifiedID`(`nModifiedID`),
    INDEX `Index_sProfile`(`sProfile`),
    PRIMARY KEY (`nUserProfileID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tuserprofiledet` (
    `nUserProfileDetID` INTEGER UNSIGNED NOT NULL,
    `nUserProfileID` INTEGER UNSIGNED NOT NULL,
    `nBankSysClientConfigID` INTEGER UNSIGNED NOT NULL,
    `nDataEntry` TINYINT NULL DEFAULT 0,
    `nReviewer` TINYINT NULL DEFAULT 0,
    `nApprover` TINYINT NULL DEFAULT 0,
    `nbFixed` TINYINT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtcreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtmodified` DATETIME(0) NULL,

    INDEX `FK_tuserprofiledet_nBankSysClientConfigID`(`nBankSysClientConfigID`),
    INDEX `FK_tuserprofiledet_nCreatedID`(`nCreatedID`),
    INDEX `FK_tuserprofiledet_nModifiedID`(`nModifiedID`),
    INDEX `FK_tuserprofiledet_nUserProfileID`(`nUserProfileID`),
    PRIMARY KEY (`nUserProfileDetID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tuserwisereportsetting` (
    `nUserwiseReportSettingID` INTEGER UNSIGNED NOT NULL,
    `nuid` INTEGER UNSIGNED NOT NULL,
    `nBankModuleDetID` INTEGER UNSIGNED NOT NULL,
    `nOption` TINYINT UNSIGNED NOT NULL,
    `nCreatedID` INTEGER UNSIGNED NOT NULL,
    `dtcreated` DATETIME(0) NULL,
    `nModifiedID` INTEGER UNSIGNED NOT NULL,
    `dtmodified` DATETIME(0) NULL,

    INDEX `FK_tuserwisereportsetting_nBankModuleDetID`(`nBankModuleDetID`),
    INDEX `FK_tuserwisereportsetting_nCreatedID`(`nCreatedID`),
    INDEX `FK_tuserwisereportsetting_nModifiedID`(`nModifiedID`),
    UNIQUE INDEX `UNIQUE_tuserwisereportsetting_uid_nBankSysClientConfigID_`(`nuid`, `nBankModuleDetID`),
    PRIMARY KEY (`nUserwiseReportSettingID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE INDEX `FK_memailuser_nCompanyID` ON `memailuser`(`nCompanyID`);

-- CreateIndex
CREATE INDEX `FK_memailuser_nCreatedID` ON `memailuser`(`nCreatedID`);

-- CreateIndex
CREATE INDEX `FK_memailuser_nModifiedID` ON `memailuser`(`nModifiedID`);

-- AddForeignKey
ALTER TABLE `mSettings` ADD CONSTRAINT `mSettings_sUserId_fkey` FOREIGN KEY (`sUserId`) REFERENCES `mUserNew`(`sUserID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `memailuser` ADD CONSTRAINT `FK_memailuser_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `memailuser` ADD CONSTRAINT `FK_memailuser_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `memailuser` ADD CONSTRAINT `FK_memailuser_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `massempackingtemplate` ADD CONSTRAINT `FK_massempackingtemplate_nCategoryID` FOREIGN KEY (`nCategoryID`) REFERENCES `mitemcategory`(`nItemCategoryID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `massempackingtemplate` ADD CONSTRAINT `FK_massempackingtemplate_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `massempackingtemplate` ADD CONSTRAINT `FK_massempackingtemplate_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `massempackingtemplate` ADD CONSTRAINT `FK_massempackingtemplate_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankassociate` ADD CONSTRAINT `FK_mbankassociate_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankassociate` ADD CONSTRAINT `FK_mbankassociate_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankbiviews` ADD CONSTRAINT `FK_mbankbiviews_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankbiviews` ADD CONSTRAINT `FK_mbankbiviews_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankbiviewssysclientconfig` ADD CONSTRAINT `FK_mbankbiviewssysclientconfig_nBITemplateID` FOREIGN KEY (`nBITemplateID`) REFERENCES `mbitemplate`(`nBITemplateID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankbiviewssysclientconfig` ADD CONSTRAINT `FK_mbankbiviewssysclientconfig_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankbiviewssysclientconfig` ADD CONSTRAINT `FK_mbankbiviewssysclientconfig_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankbiviewssysclientconfig` ADD CONSTRAINT `FK_mbankbiviewssysclientconfig_sSysClientID` FOREIGN KEY (`sSysClientID`) REFERENCES `sysclient`(`nSysClientID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankdashelement` ADD CONSTRAINT `FK_mbankdashelement_nBankDashGroupID` FOREIGN KEY (`nBankDashGroupID`) REFERENCES `mbankdashgroup`(`nBankDashGroupID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankdashelement` ADD CONSTRAINT `FK_mbankdashelement_nBankModuleID` FOREIGN KEY (`nBankModuleID`) REFERENCES `mbankmodule`(`nBankModuleID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankdashelement` ADD CONSTRAINT `FK_mbankdashelement_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankdashelement` ADD CONSTRAINT `FK_mbankdashelement_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankdashgroup` ADD CONSTRAINT `FK_mbankdashgroup_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankdashgroup` ADD CONSTRAINT `FK_mbankdashgroup_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankdashsysclientconfig` ADD CONSTRAINT `FK_mbankdashsysclientconfig_nBankDashElementID` FOREIGN KEY (`nBankDashElementID`) REFERENCES `mbankdashelement`(`nBankDashElementID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankdashsysclientconfig` ADD CONSTRAINT `FK_mbankdashsysclientconfig_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankdashsysclientconfig` ADD CONSTRAINT `FK_mbankdashsysclientconfig_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankdashsysclientconfig` ADD CONSTRAINT `FK_mbankdashsysclientconfig_sSysClientID` FOREIGN KEY (`sSysClientID`) REFERENCES `sysclient`(`nSysClientID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankfeaturetemplate` ADD CONSTRAINT `FK_mbankfeaturetemplate_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankfeaturetemplate` ADD CONSTRAINT `FK_mbankfeaturetemplate_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankfeaturetemplatedet` ADD CONSTRAINT `FK_mbankfeaturetemplatedet_nBankFeatureTemplateID` FOREIGN KEY (`nBankFeatureTemplateID`) REFERENCES `mbankfeaturetemplate`(`nBankFeatureTemplateID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankfeaturetemplatedet` ADD CONSTRAINT `FK_mbankfeaturetemplatedet_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankfeaturetemplatedet` ADD CONSTRAINT `FK_mbankfeaturetemplatedet_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankmanualelement` ADD CONSTRAINT `FK_mbankmanualelement_nBankManualGroupID` FOREIGN KEY (`nBankManualGroupID`) REFERENCES `mbankmanualgroup`(`nBankManualGroupID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankmanualelement` ADD CONSTRAINT `FK_mbankmanualelement_nBankModuleID` FOREIGN KEY (`nBankModuleID`) REFERENCES `mbankmodule`(`nBankModuleID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankmanualelement` ADD CONSTRAINT `FK_mbankmanualelement_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankmanualelement` ADD CONSTRAINT `FK_mbankmanualelement_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankmanualsysclientconfig` ADD CONSTRAINT `FK_mbankmanualsysclientconfig_nBankDashElementID` FOREIGN KEY (`nBankManualElementID`) REFERENCES `mbankmanualelement`(`nBankManualElementID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankmanualsysclientconfig` ADD CONSTRAINT `FK_mbankmanualsysclientconfig_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankmanualsysclientconfig` ADD CONSTRAINT `FK_mbankmanualsysclientconfig_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankmanualsysclientconfig` ADD CONSTRAINT `FK_mbankmanualsysclientconfig_sSysClientID` FOREIGN KEY (`sSysClientID`) REFERENCES `sysclient`(`nSysClientID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankmodule` ADD CONSTRAINT `FK_mbankmodule_ModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankmodule` ADD CONSTRAINT `FK_mbankmodule_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankmoduledet` ADD CONSTRAINT `FK_mbankmoduledet_nBankModuleGroupID` FOREIGN KEY (`nBankModuleGroupID`) REFERENCES `mbankmodulegroup`(`nBankModuleGroupID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankmoduledet` ADD CONSTRAINT `FK_mbankmoduledet_nBankModuleID` FOREIGN KEY (`nBankModuleID`) REFERENCES `mbankmodule`(`nBankModuleID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankmoduledet` ADD CONSTRAINT `FK_mbankmoduledet_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankmoduledet` ADD CONSTRAINT `FK_mbankmoduledet_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankmodulegroup` ADD CONSTRAINT `FK_mbankmodulegroup_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankmodulegroup` ADD CONSTRAINT `FK_mbankmodulegroup_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankmodulesetting` ADD CONSTRAINT `FK_mbankmodulesetting_nModuleid` FOREIGN KEY (`nModuleid`) REFERENCES `mbankmodule`(`nBankModuleID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbanksysclientconfig` ADD CONSTRAINT `FK_mbanksysclientconfig_BankModuleDetID` FOREIGN KEY (`nBankModuledetid`) REFERENCES `mbankmoduledet`(`nBankModuleDetID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbanksysclientconfig` ADD CONSTRAINT `FK_mbanksysclientconfig_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbanksysclientconfig` ADD CONSTRAINT `FK_mbanksysclientconfig_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbanksysclientconfig` ADD CONSTRAINT `FK_mbanksysclientconfig_nSysClientID` FOREIGN KEY (`sSysClientID`) REFERENCES `sysclient`(`nSysClientID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbanksystemtask` ADD CONSTRAINT `FK_mbanksystemtask_nBankModuleID` FOREIGN KEY (`nBankModuleID`) REFERENCES `mbankmodule`(`nBankModuleID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbanksystemtask` ADD CONSTRAINT `FK_mbanksystemtask_nBankSystemTaskTypeID` FOREIGN KEY (`nBankSystemTaskTypeID`) REFERENCES `mbanksystemtasktype`(`nBankSystemTaskTypeID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbanksystemtask` ADD CONSTRAINT `FK_mbanksystemtask_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbanksystemtask` ADD CONSTRAINT `FK_mbanksystemtask_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbanksystemtasktype` ADD CONSTRAINT `FK_mbanksystemtasktype_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbanksystemtasktype` ADD CONSTRAINT `FK_mbanksystemtasktype_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbanktasksysclientconfig` ADD CONSTRAINT `FK_mbanktasksysclientconfig_nBankSystemTaskID` FOREIGN KEY (`nBankSystemTaskID`) REFERENCES `mbanksystemtask`(`nBankSystemTaskID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbanktasksysclientconfig` ADD CONSTRAINT `FK_mbanktasksysclientconfig_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbanktasksysclientconfig` ADD CONSTRAINT `FK_mbanktasksysclientconfig_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbanktasksysclientconfig` ADD CONSTRAINT `FK_mbanktasksysclientconfig_sSysClientID` FOREIGN KEY (`sSysClientID`) REFERENCES `sysclient`(`nSysClientID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankwidgetsysclientconfig` ADD CONSTRAINT `FK_mbankwidgetsysclientconfig_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankwidgetsysclientconfig` ADD CONSTRAINT `FK_mbankwidgetsysclientconfig_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbankwidgetsysclientconfig` ADD CONSTRAINT `FK_mbankwidgetsysclientconfig_nSysClientID` FOREIGN KEY (`nSysClientID`) REFERENCES `sysclient`(`nSysClientID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbitemplate` ADD CONSTRAINT `FK_mbitemplate_nBITemplateGroupID` FOREIGN KEY (`nBITemplateGroupID`) REFERENCES `mbitemplategroup`(`nBITemplateGroupID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbitemplate` ADD CONSTRAINT `FK_mbitemplate_nBankBIViewsID` FOREIGN KEY (`nBankBIViewsID`) REFERENCES `mbankbiviews`(`nbankbiviewsID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbitemplate` ADD CONSTRAINT `FK_mbitemplate_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbitemplate` ADD CONSTRAINT `FK_mbitemplate_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbitemplategroup` ADD CONSTRAINT `FK_mbitemplategroup_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbitemplategroup` ADD CONSTRAINT `FK_mbitemplategroup_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbom` ADD CONSTRAINT `FK_mbom_nBOMGroupID` FOREIGN KEY (`nBOMGroupID`) REFERENCES `mbomgroup`(`nBOMGroupID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbom` ADD CONSTRAINT `FK_mbom_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbom` ADD CONSTRAINT `FK_mbom_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbom` ADD CONSTRAINT `FK_mbom_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbom` ADD CONSTRAINT `FK_mbom_nUnderBOMFolderID` FOREIGN KEY (`nUnderBOMFolderID`) REFERENCES `mbomfolder`(`nBOMFolderID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomdet` ADD CONSTRAINT `FK_mbomdet_nBOMID` FOREIGN KEY (`nBOMID`) REFERENCES `mbom`(`nBOMID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomdet` ADD CONSTRAINT `FK_mbomdet_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomdet` ADD CONSTRAINT `FK_mbomdet_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomdet` ADD CONSTRAINT `FK_mbomdet_nUOMID` FOREIGN KEY (`nUOMID`) REFERENCES `muom`(`nUOMID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomdrawershutter` ADD CONSTRAINT `FK_mbomdrawershutter_nBOMID` FOREIGN KEY (`nBOMID`) REFERENCES `mbom`(`nBOMID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomdrawershutter` ADD CONSTRAINT `FK_mbomdrawershutter_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomdrawershutter` ADD CONSTRAINT `FK_mbomdrawershutter_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomfolder` ADD CONSTRAINT `FK_mbomfolder_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomfolder` ADD CONSTRAINT `FK_mbomfolder_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomfolder` ADD CONSTRAINT `FK_mbomfolder_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomfolder` ADD CONSTRAINT `FK_mbomfolder_nParentBOMFolderID` FOREIGN KEY (`nParentBOMFolderID`) REFERENCES `mbomfolder`(`nBOMFolderID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomgroup` ADD CONSTRAINT `FK_mbomgroup_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomgroup` ADD CONSTRAINT `FK_mbomgroup_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomgroup` ADD CONSTRAINT `FK_mbomgroup_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomvariable` ADD CONSTRAINT `FK_mbomvariable_nBOMID` FOREIGN KEY (`nBOMID`) REFERENCES `mbom`(`nBOMID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomvariable` ADD CONSTRAINT `FK_mbomvariable_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomvariable` ADD CONSTRAINT `FK_mbomvariable_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mbomvariable` ADD CONSTRAINT `FK_mbomvariable_nUOMID` FOREIGN KEY (`nUOMID`) REFERENCES `muom`(`nUOMID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mchecklist` ADD CONSTRAINT `FK_mchecklist_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mchecklist` ADD CONSTRAINT `FK_mchecklist_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcompany` ADD CONSTRAINT `FK_mcompany_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcompany` ADD CONSTRAINT `FK_mcompany_nCurrencyID` FOREIGN KEY (`nCurrencyID`) REFERENCES `mcurrency`(`nCurrencyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcompany` ADD CONSTRAINT `FK_mcompany_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcompany` ADD CONSTRAINT `FK_mcompany_nPackageMasterID` FOREIGN KEY (`nPackageMasterID`) REFERENCES `mpackagemaster`(`nPackageMasterID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mconsolidatedreporttemplate` ADD CONSTRAINT `FK_mconsolidatedreporttemplate_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mconsolidatedreporttemplate` ADD CONSTRAINT `FK_mconsolidatedreporttemplate_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mconsolidatedreporttemplate` ADD CONSTRAINT `FK_mconsolidatedreporttemplate_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcoupon` ADD CONSTRAINT `FK_mcoupon_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcoupon` ADD CONSTRAINT `FK_mcoupon_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcoverpagetemplate` ADD CONSTRAINT `FK_mcoverpagetemplate_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcoverpagetemplate` ADD CONSTRAINT `FK_mcoverpagetemplate_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcoverpagetemplate` ADD CONSTRAINT `FK_mcoverpagetemplate_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcurrency` ADD CONSTRAINT `FK_mcurrency_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcurrency` ADD CONSTRAINT `FK_mcurrency_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcust` ADD CONSTRAINT `FK_mcust_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcust` ADD CONSTRAINT `FK_mcust_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcust` ADD CONSTRAINT `FK_mcust_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcustomernew` ADD CONSTRAINT `FK_mcustomernew_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcuttinglisttemplate` ADD CONSTRAINT `FK_mcuttinglisttemplate_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcuttinglisttemplate` ADD CONSTRAINT `FK_mcuttinglisttemplate_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mcuttinglisttemplate` ADD CONSTRAINT `FK_mcuttinglisttemplate_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mdept` ADD CONSTRAINT `FK_mdept_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mdept` ADD CONSTRAINT `FK_mdept_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mdocgenerationsetup` ADD CONSTRAINT `FK_mdocgenerationsetup_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mdocgenerationsetup` ADD CONSTRAINT `FK_mdocgenerationsetup_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mdocgenerationsetup` ADD CONSTRAINT `FK_mdocgenerationsetup_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `medgebandingtemplate` ADD CONSTRAINT `FK_medgebandingtemplate_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `medgebandingtemplate` ADD CONSTRAINT `FK_medgebandingtemplate_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `medgebandingtemplate` ADD CONSTRAINT `FK_medgebandingtemplate_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `medgebandingtemplatedet` ADD CONSTRAINT `FK_medgebandingtemplatedet_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `medgebandingtemplatedet` ADD CONSTRAINT `FK_medgebandingtemplatedet_nEdgeBandingTemplateID` FOREIGN KEY (`nEdgeBandingTemplateID`) REFERENCES `medgebandingtemplate`(`nEdgeBandingTemplateID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `medgebandingtemplatedet` ADD CONSTRAINT `FK_medgebandingtemplatedet_nL1ItemID` FOREIGN KEY (`nL1ItemID`) REFERENCES `mitem`(`nItemID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `medgebandingtemplatedet` ADD CONSTRAINT `FK_medgebandingtemplatedet_nL2ItemID` FOREIGN KEY (`nL2ItemID`) REFERENCES `mitem`(`nItemID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `medgebandingtemplatedet` ADD CONSTRAINT `FK_medgebandingtemplatedet_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `medgebandingtemplatedet` ADD CONSTRAINT `FK_medgebandingtemplatedet_nS1ItemID` FOREIGN KEY (`nS1ItemID`) REFERENCES `mitem`(`nItemID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `medgebandingtemplatedet` ADD CONSTRAINT `FK_medgebandingtemplatedet_nS2ItemID` FOREIGN KEY (`nS2ItemID`) REFERENCES `mitem`(`nItemID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `memp` ADD CONSTRAINT `FK_memp_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `memp` ADD CONSTRAINT `FK_memp_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mevent` ADD CONSTRAINT `FK_mevent_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mevent` ADD CONSTRAINT `FK_mevent_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mfeature` ADD CONSTRAINT `FK_mfeature_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mfeature` ADD CONSTRAINT `FK_mfeature_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mfeature` ADD CONSTRAINT `FK_mfeature_nfeatureGroupID` FOREIGN KEY (`nfeatureGroupID`) REFERENCES `mfeaturegroup`(`nFeaturegroupID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mfeaturedet` ADD CONSTRAINT `FK_mfeaturedet_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mfeaturedet` ADD CONSTRAINT `FK_mfeaturedet_nFeatureID` FOREIGN KEY (`nFeatureID`) REFERENCES `mfeature`(`nfeatureID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mfeaturedet` ADD CONSTRAINT `FK_mfeaturedet_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mfeaturegroup` ADD CONSTRAINT `FK_mbankfeaturegroup_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mfeaturegroup` ADD CONSTRAINT `FK_mbankfeaturegroup_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mhsn` ADD CONSTRAINT `FK_mhsn_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mhsn` ADD CONSTRAINT `FK_mhsn_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mhsn` ADD CONSTRAINT `FK_mhsn_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mipadress` ADD CONSTRAINT `FK_mipadress_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mipadress` ADD CONSTRAINT `FK_mipadress_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mipadressexcludeuser` ADD CONSTRAINT `FK_mipadressexcludeuser_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mipadressexcludeuser` ADD CONSTRAINT `FK_mipadressexcludeuser_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mipadressexcludeuser` ADD CONSTRAINT `FK_mipadressexcludeuser_nUserID` FOREIGN KEY (`nUserID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitem` ADD CONSTRAINT `FK_mitem_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitem` ADD CONSTRAINT `FK_mitem_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitem` ADD CONSTRAINT `FK_mitem_nHSNID` FOREIGN KEY (`nHSNID`) REFERENCES `mhsn`(`nHSNID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitem` ADD CONSTRAINT `FK_mitem_nItemCategoryID` FOREIGN KEY (`nItemCategoryID`) REFERENCES `mitemcategory`(`nItemCategoryID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitem` ADD CONSTRAINT `FK_mitem_nItemGroupID` FOREIGN KEY (`nItemGroupID`) REFERENCES `mitemgroup`(`nItemGroupID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitem` ADD CONSTRAINT `FK_mitem_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitem` ADD CONSTRAINT `FK_mitem_nUOMID` FOREIGN KEY (`nUOMID`) REFERENCES `muom`(`nUOMID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemcategory` ADD CONSTRAINT `FK_mitemcategory_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemcategory` ADD CONSTRAINT `FK_mitemcategory_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemcategory` ADD CONSTRAINT `FK_mitemcategory_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemcategory` ADD CONSTRAINT `FK_mitemcategory_nUOMID` FOREIGN KEY (`nUOMID`) REFERENCES `muom`(`nUOMID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemcategoryfinish` ADD CONSTRAINT `FK_mitemcategoryfinish_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemcategoryfinish` ADD CONSTRAINT `FK_mitemcategoryfinish_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemcategoryfinish` ADD CONSTRAINT `FK_mitemcategoryfinish_nItemCategoryID` FOREIGN KEY (`nItemCategoryID`) REFERENCES `mitemcategory`(`nItemCategoryID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemcategoryfinish` ADD CONSTRAINT `FK_mitemcategoryfinish_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemgroup` ADD CONSTRAINT `FK_mitemgroup_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemgroup` ADD CONSTRAINT `FK_mitemgroup_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemgroup` ADD CONSTRAINT `FK_mitemgroup_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemprocess` ADD CONSTRAINT `FK_mitemprocess_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemprocess` ADD CONSTRAINT `FK_mitemprocess_nConsumptionUOMID` FOREIGN KEY (`nConsumptionUOMID`) REFERENCES `muom`(`nUOMID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemprocess` ADD CONSTRAINT `FK_mitemprocess_nCostperUnitID` FOREIGN KEY (`nCostperUnitID`) REFERENCES `muom`(`nUOMID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemprocess` ADD CONSTRAINT `FK_mitemprocess_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemprocess` ADD CONSTRAINT `FK_mitemprocess_nHSNID` FOREIGN KEY (`nHSNID`) REFERENCES `mhsn`(`nHSNID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemprocess` ADD CONSTRAINT `FK_mitemprocess_nItemProcessTypeID` FOREIGN KEY (`nItemProcessTypeID`) REFERENCES `mitemprocesstype`(`nItemProcessTypeID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemprocess` ADD CONSTRAINT `FK_mitemprocess_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemprocess` ADD CONSTRAINT `FK_mitemprocess_nPostOptmisationCostUOMID` FOREIGN KEY (`nPostOptmisationCostUOMID`) REFERENCES `muom`(`nUOMID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemprocesstype` ADD CONSTRAINT `FK_mitemprocesstype_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mitemprocesstype` ADD CONSTRAINT `FK_mitemprocesstype_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mnewsfeedquote` ADD CONSTRAINT `FK_mnewsfeedquote_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mnewsfeedquote` ADD CONSTRAINT `FK_mnewsfeedquote_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mpackagemaster` ADD CONSTRAINT `FK_mpackagemaster_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mpackagemaster` ADD CONSTRAINT `FK_mpackagemaster_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mpackagemasterdet` ADD CONSTRAINT `FK_mpackagemasterdet_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mpackagemasterdet` ADD CONSTRAINT `FK_mpackagemasterdet_nFeatureID` FOREIGN KEY (`nFeatureID`) REFERENCES `mfeature`(`nfeatureID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mpackagemasterdet` ADD CONSTRAINT `FK_mpackagemasterdet_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mpackagemasterdet` ADD CONSTRAINT `FK_mpackagemasterdet_nPackageMasterID` FOREIGN KEY (`nPackageMasterID`) REFERENCES `mpackagemaster`(`nPackageMasterID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mpacket` ADD CONSTRAINT `FK_mpacket_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mpacket` ADD CONSTRAINT `FK_mpacket_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mpacket` ADD CONSTRAINT `FK_mpacket_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mreviewinputtemplate` ADD CONSTRAINT `FK_mreviewinputtemplate_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mreviewinputtemplate` ADD CONSTRAINT `FK_mreviewinputtemplate_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mreviewinputtemplate` ADD CONSTRAINT `FK_mreviewinputtemplate_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mroomtype` ADD CONSTRAINT `FK_mroomtype_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mroomtype` ADD CONSTRAINT `FK_mroomtype_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mroomtype` ADD CONSTRAINT `FK_mroomtype_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mroomtype` ADD CONSTRAINT `FK_mroomtype_nQuotationID` FOREIGN KEY (`nQuotationID`) REFERENCES `tquotation`(`nQuotationID`) ON DELETE NO ACTION ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mservicename` ADD CONSTRAINT `FK_mServiceName_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mservicermasternew` ADD CONSTRAINT `FK_mServiceMasterNew_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `mstickerdesigntemplate` ADD CONSTRAINT `FK_mstickerdesigntemplate_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mstickerdesigntemplate` ADD CONSTRAINT `FK_mstickerdesigntemplate_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mtasktemplate` ADD CONSTRAINT `FK_mtasktemplate_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mtasktemplate` ADD CONSTRAINT `FK_mtasktemplate_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mtasktemplatechecklist` ADD CONSTRAINT `FK_mtasktemplatechecklist_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mtasktemplatechecklist` ADD CONSTRAINT `FK_mtasktemplatechecklist_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `mtasktemplatechecklist` ADD CONSTRAINT `FK_mtasktemplatechecklist_nTasktemplateID` FOREIGN KEY (`nTasktemplateID`) REFERENCES `mtasktemplate`(`nTaskTemplateID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `muom` ADD CONSTRAINT `FK_muom_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `muom` ADD CONSTRAINT `FK_muom_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `muser` ADD CONSTRAINT `FK_muser_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `muser` ADD CONSTRAINT `FK_muser_nEmpID` FOREIGN KEY (`nEmpID`) REFERENCES `memp`(`nEmpID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `muser` ADD CONSTRAINT `FK_muser_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `musercatwisemarkupdisc` ADD CONSTRAINT `FK_musercatwisemarkupdisc_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `musercatwisemarkupdisc` ADD CONSTRAINT `FK_musercatwisemarkupdisc_nItemCategoryID` FOREIGN KEY (`nItemCategoryID`) REFERENCES `mitemcategory`(`nItemCategoryID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `musercatwisemarkupdisc` ADD CONSTRAINT `FK_musercatwisemarkupdisc_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `musercatwisemarkupdisc` ADD CONSTRAINT `FK_musercatwisemarkupdisc_nUserID` FOREIGN KEY (`nUserID`) REFERENCES `muser`(`nUserID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `muserwisereportcolumnselection` ADD CONSTRAINT `FK_muserwisereportcolumnselection_nBankmOduleDetID` FOREIGN KEY (`nBankmoduleDetID`) REFERENCES `mbankmoduledet`(`nBankModuleDetID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `muserwisereportcolumnselection` ADD CONSTRAINT `FK_muserwisereportcolumnselection_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `muserwisereportcolumnselection` ADD CONSTRAINT `FK_muserwisereportcolumnselection_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `muserwisereportcolumnselection` ADD CONSTRAINT `FK_muserwisereportcolumnselection_nUserID` FOREIGN KEY (`nUserID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysclient` ADD CONSTRAINT `FK_sysclient_nBankAssociateID` FOREIGN KEY (`nBankAssociateID`) REFERENCES `mbankassociate`(`nBankAssociateID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysclient` ADD CONSTRAINT `FK_sysclient_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysclient` ADD CONSTRAINT `FK_sysclient_nCurrencyID` FOREIGN KEY (`nSysCurrencyID`) REFERENCES `mcurrency`(`nCurrencyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysclient` ADD CONSTRAINT `FK_sysclient_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysclientloc` ADD CONSTRAINT `FK_sysclientloc_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysclientloc` ADD CONSTRAINT `FK_sysclientloc_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysclientloc` ADD CONSTRAINT `FK_sysclientloc_nSysClientID` FOREIGN KEY (`nSysClientID`) REFERENCES `sysclient`(`nSysClientID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysclientmodulesetting` ADD CONSTRAINT `FK_sysclientmodulesetting_nBankModuleSettingid` FOREIGN KEY (`nBankModuleSettingid`) REFERENCES `mbankmodulesetting`(`nBankModuleSettingId`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysclientmodulesetting` ADD CONSTRAINT `FK_sysclientmodulesetting_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysclientmodulesetting` ADD CONSTRAINT `FK_sysclientmodulesetting_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysclientmodulesetting` ADD CONSTRAINT `FK_sysclientmodulesetting_nSysClientId` FOREIGN KEY (`nSysClientId`) REFERENCES `sysclient`(`nSysClientID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysdocmgt` ADD CONSTRAINT `FK_sysdocmgt_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysdocmgt` ADD CONSTRAINT `FK_sysdocmgt_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysrecord` ADD CONSTRAINT `FK_sysrecord_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysrecord` ADD CONSTRAINT `FK_sysrecord_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysrecorddet` ADD CONSTRAINT `FK_sysrecorddet_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysrecorddet` ADD CONSTRAINT `FK_sysrecorddet_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sysrecorddet` ADD CONSTRAINT `FK_sysrecorddet_nSysRecordID` FOREIGN KEY (`nSysRecordID`) REFERENCES `sysrecord`(`nSysRecordID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `taskchecklist` ADD CONSTRAINT `FK_taskchecklist_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `taskchecklist` ADD CONSTRAINT `FK_taskchecklist_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `taskchecklist` ADD CONSTRAINT `FK_taskchecklist_nTaskID` FOREIGN KEY (`nTaskID`) REFERENCES `ttask`(`nTaskID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tchat` ADD CONSTRAINT `FK_tchat_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tchat` ADD CONSTRAINT `FK_tchat_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tchatdet` ADD CONSTRAINT `FK_tchatdet_nChatID` FOREIGN KEY (`nChatID`) REFERENCES `tchat`(`nChatID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tchatdet` ADD CONSTRAINT `FK_tchatdet_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tchatdet` ADD CONSTRAINT `FK_tchatdet_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tchatdet` ADD CONSTRAINT `FK_tchatdet_nUserID` FOREIGN KEY (`nUserID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tdashelementconfig` ADD CONSTRAINT `FK_tdashelementconfig_nBankDashSysclientConfigID` FOREIGN KEY (`nBankDashSysclientConfigID`) REFERENCES `mbankdashsysclientconfig`(`nBankDashSysclientConfigID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tdashelementconfig` ADD CONSTRAINT `FK_tdashelementconfig_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tdashelementconfig` ADD CONSTRAINT `FK_tdashelementconfig_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tdashelementconfig` ADD CONSTRAINT `FK_tdashelementconfig_nUserID` FOREIGN KEY (`nUserID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tdashelementconfigcompanywise` ADD CONSTRAINT `FK_tdashelementconfigcompanywise_nBankDashSysclientConfigID` FOREIGN KEY (`nBankDashSysclientConfigID`) REFERENCES `mbankdashsysclientconfig`(`nBankDashSysclientConfigID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tdashelementconfigcompanywise` ADD CONSTRAINT `FK_tdashelementconfigcompanywise_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tdashelementconfigcompanywise` ADD CONSTRAINT `FK_tdashelementconfigcompanywise_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tdashelementconfigcompanywise` ADD CONSTRAINT `FK_tdashelementconfigcompanywise_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tdashelementconfigfav` ADD CONSTRAINT `FK_tdashelementconfigfav_nBankDashSysclientConfigID` FOREIGN KEY (`nBankDashSysclientConfigID`) REFERENCES `mbankdashsysclientconfig`(`nBankDashSysclientConfigID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tdashelementconfigfav` ADD CONSTRAINT `FK_tdashelementconfigfav_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tdashelementconfigfav` ADD CONSTRAINT `FK_tdashelementconfigfav_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tdashelementconfigfav` ADD CONSTRAINT `FK_tdashelementconfigfav_nUserID` FOREIGN KEY (`nUserID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tdashelementlimit` ADD CONSTRAINT `FK_tdashelementlimit_nBankDashSysclientConfigID` FOREIGN KEY (`nBankDashSysclientConfigID`) REFERENCES `mbankdashsysclientconfig`(`nBankDashSysclientConfigID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tdashelementlimit` ADD CONSTRAINT `FK_tdashelementlimit_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tdashelementlimit` ADD CONSTRAINT `FK_tdashelementlimit_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tevent` ADD CONSTRAINT `FK_tevent_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tevent` ADD CONSTRAINT `FK_tevent_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tmessage` ADD CONSTRAINT `FK_tmessage_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tmessage` ADD CONSTRAINT `FK_tmessage_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tmom` ADD CONSTRAINT `tmom_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tmom` ADD CONSTRAINT `tmom_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tmomdet` ADD CONSTRAINT `tmomdet_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tmomdet` ADD CONSTRAINT `tmomdet_nMOMID` FOREIGN KEY (`nMOMID`) REFERENCES `tmom`(`nMOMID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tmomdet` ADD CONSTRAINT `tmomdet_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tnotification` ADD CONSTRAINT `FK_tnotification_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tnotification` ADD CONSTRAINT `FK_tnotification_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tnotification` ADD CONSTRAINT `FK_tnotification_nforUserID` FOREIGN KEY (`nforUserID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `totp` ADD CONSTRAINT `FK_totp_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `totp` ADD CONSTRAINT `FK_totp_nInitiatedBy` FOREIGN KEY (`nInitiatedBy`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `totp` ADD CONSTRAINT `FK_totp_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotation` ADD CONSTRAINT `FK_tquotation_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotation` ADD CONSTRAINT `FK_tquotation_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotation` ADD CONSTRAINT `FK_tquotation_nCustID` FOREIGN KEY (`nCustID`) REFERENCES `mcust`(`nCustID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotation` ADD CONSTRAINT `FK_tquotation_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotation_amend` ADD CONSTRAINT `FK_tquotation_amend_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotation_amend` ADD CONSTRAINT `FK_tquotation_amend_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotation_amend` ADD CONSTRAINT `FK_tquotation_amend_nQuotationID` FOREIGN KEY (`nQuotationID`) REFERENCES `tquotation`(`nQuotationID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcatwisemarkupdisc` ADD CONSTRAINT `FK_tquotationcatwisemarkupdisc_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcatwisemarkupdisc` ADD CONSTRAINT `FK_tquotationcatwisemarkupdisc_nItemCategoryID` FOREIGN KEY (`nItemCategoryID`) REFERENCES `mitemcategory`(`nItemCategoryID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcatwisemarkupdisc` ADD CONSTRAINT `FK_tquotationcatwisemarkupdisc_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcatwisemarkupdisc` ADD CONSTRAINT `FK_tquotationcatwisemarkupdisc_nQuotationID` FOREIGN KEY (`nQuotationID`) REFERENCES `tquotation`(`nQuotationID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcatwisemarkupdisc_amend` ADD CONSTRAINT `FK_tquotationcatwisemarkupdisc_amend_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcatwisemarkupdisc_amend` ADD CONSTRAINT `FK_tquotationcatwisemarkupdisc_amend_nItemCategoryID` FOREIGN KEY (`nItemCategoryID`) REFERENCES `mitemcategory`(`nItemCategoryID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcatwisemarkupdisc_amend` ADD CONSTRAINT `FK_tquotationcatwisemarkupdisc_amend_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcatwisemarkupdisc_amend` ADD CONSTRAINT `FK_tquotationcatwisemarkupdisc_amend_nQuotation_AmendID` FOREIGN KEY (`nQuotation_AmendID`) REFERENCES `tquotation_amend`(`nQuotation_AmendID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcutdetails` ADD CONSTRAINT `FK_tquotationcutdetails_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcutdetails` ADD CONSTRAINT `FK_tquotationcutdetails_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcutdetails` ADD CONSTRAINT `FK_tquotationcutdetails_nQuotationID` FOREIGN KEY (`nQuotationID`) REFERENCES `tquotation`(`nQuotationID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcutdetails` ADD CONSTRAINT `FK_tquotationcutdetails_nQuotationStockpartDetailsID` FOREIGN KEY (`nQuotationStockpartDetailsID`) REFERENCES `tquotationstockpartdetails`(`nQuotationStockpartDetailsID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcutpartdetails` ADD CONSTRAINT `FK_tquotationcutpartdetails_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcutpartdetails` ADD CONSTRAINT `FK_tquotationcutpartdetails_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcutpartdetails` ADD CONSTRAINT `FK_tquotationcutpartdetails_nQuotationDetID` FOREIGN KEY (`nQuotationItemsID`) REFERENCES `tquotationitems`(`nQuotationItemsID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcutpartdetails` ADD CONSTRAINT `FK_tquotationcutpartdetails_nQuotationID` FOREIGN KEY (`nQuotationID`) REFERENCES `tquotation`(`nQuotationID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcutpartdetails_amend` ADD CONSTRAINT `FK_tquotationcutpartdetails_amend_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcutpartdetails_amend` ADD CONSTRAINT `FK_tquotationcutpartdetails_amend_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationcutpartdetails_amend` ADD CONSTRAINT `FK_tquotationcutpartdetails_amend_nQuotation_AmendID` FOREIGN KEY (`nQuotation_AmendID`) REFERENCES `tquotation_amend`(`nQuotation_AmendID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationfronts` ADD CONSTRAINT `FK_tquotationfronts_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationfronts` ADD CONSTRAINT `FK_tquotationfronts_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationfronts` ADD CONSTRAINT `FK_tquotationfronts_nQuotationID` FOREIGN KEY (`nQuotationID`) REFERENCES `tquotation`(`nQuotationID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationfronts` ADD CONSTRAINT `FK_tquotationfronts_nQuotationItemID` FOREIGN KEY (`nQuotationItemID`) REFERENCES `tquotationitems`(`nQuotationItemsID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationfronts_amend` ADD CONSTRAINT `FK_tquotationfronts_amend_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationfronts_amend` ADD CONSTRAINT `FK_tquotationfronts_amend_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationfronts_amend` ADD CONSTRAINT `FK_tquotationfronts_amend_nQuotation_AmendID` FOREIGN KEY (`nQuotation_AmendID`) REFERENCES `tquotation_amend`(`nQuotation_AmendID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitems` ADD CONSTRAINT `FK_tquotationitems_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitems` ADD CONSTRAINT `FK_tquotationitems_nItemID` FOREIGN KEY (`nItemID`) REFERENCES `mitem`(`nItemID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitems` ADD CONSTRAINT `FK_tquotationitems_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitems` ADD CONSTRAINT `FK_tquotationitems_nOldItemID` FOREIGN KEY (`nOldItemID`) REFERENCES `mitem`(`nItemID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitems` ADD CONSTRAINT `FK_tquotationitems_nQuotationFrontsID` FOREIGN KEY (`nQuotationFrontsID`) REFERENCES `tquotationfronts`(`nQuotationFrontsID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitems` ADD CONSTRAINT `FK_tquotationitems_nQuotationID` FOREIGN KEY (`nQuotationID`) REFERENCES `tquotation`(`nQuotationID`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tquotationitems` ADD CONSTRAINT `FK_tquotationitems_nRoomTypeID` FOREIGN KEY (`nRoomTypeID`) REFERENCES `mroomtype`(`nRoomTypeID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitems_amend` ADD CONSTRAINT `FK_tquotationitems_amend_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitems_amend` ADD CONSTRAINT `FK_tquotationitems_amend_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitems_amend` ADD CONSTRAINT `FK_tquotationitems_amend_nQuotation_AmendID` FOREIGN KEY (`nQuotation_AmendID`) REFERENCES `tquotation_amend`(`nQuotation_AmendID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitems_amend` ADD CONSTRAINT `FK_tquotationitems_amend_nRoomTypeID` FOREIGN KEY (`nRoomTypeID`) REFERENCES `mroomtype`(`nRoomTypeID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitemsprocess` ADD CONSTRAINT `FK_tquotationitemsprocess_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitemsprocess` ADD CONSTRAINT `FK_tquotationitemsprocess_nItemProcessID` FOREIGN KEY (`nItemProcessID`) REFERENCES `mitemprocess`(`nItemProcessID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitemsprocess` ADD CONSTRAINT `FK_tquotationitemsprocess_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitemsprocess` ADD CONSTRAINT `FK_tquotationitemsprocess_nQuotationID` FOREIGN KEY (`nQuotationID`) REFERENCES `tquotation`(`nQuotationID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitemsprocess` ADD CONSTRAINT `FK_tquotationitemsprocess_nQuotationItemID` FOREIGN KEY (`nQuotationItemID`) REFERENCES `tquotationitems`(`nQuotationItemsID`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tquotationitemsprocess` ADD CONSTRAINT `FK_tquotationitemsprocess_nRoomTypeID` FOREIGN KEY (`nRoomTypeID`) REFERENCES `mroomtype`(`nRoomTypeID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitemsprocess_amend` ADD CONSTRAINT `FK_tquotationitemsprocess_amend_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitemsprocess_amend` ADD CONSTRAINT `FK_tquotationitemsprocess_amend_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitemsprocess_amend` ADD CONSTRAINT `FK_tquotationitemsprocess_amend_nQuotation_AmendID` FOREIGN KEY (`nQuotation_AmendID`) REFERENCES `tquotation_amend`(`nQuotation_AmendID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitemsprocess_amend` ADD CONSTRAINT `FK_tquotationitemsprocess_amend_nRoomTypeID` FOREIGN KEY (`nRoomTypeID`) REFERENCES `mroomtype`(`nRoomTypeID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitemsvariable` ADD CONSTRAINT `FK_tquotationitemsvariable_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitemsvariable` ADD CONSTRAINT `FK_tquotationitemsvariable_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitemsvariable` ADD CONSTRAINT `FK_tquotationitemsvariable_nQuotationID` FOREIGN KEY (`nQuotationID`) REFERENCES `tquotation`(`nQuotationID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationitemsvariable` ADD CONSTRAINT `FK_tquotationitemsvariable_nQuotationItemsID` FOREIGN KEY (`nQuotationItemsID`) REFERENCES `tquotationitems`(`nQuotationItemsID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationmaterial` ADD CONSTRAINT `FK_tquotationmaterial_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationmaterial` ADD CONSTRAINT `FK_tquotationmaterial_nHSNID` FOREIGN KEY (`nHSNID`) REFERENCES `mhsn`(`nHSNID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationmaterial` ADD CONSTRAINT `FK_tquotationmaterial_nItemCategoryID` FOREIGN KEY (`nItemCategoryID`) REFERENCES `mitemcategory`(`nItemCategoryID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationmaterial` ADD CONSTRAINT `FK_tquotationmaterial_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationmaterial` ADD CONSTRAINT `FK_tquotationmaterial_nQuotationID` FOREIGN KEY (`nQuotationID`) REFERENCES `tquotation`(`nQuotationID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationmaterial_amend` ADD CONSTRAINT `FK_tquotationmaterial_amend_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE NO ACTION ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationmaterial_amend` ADD CONSTRAINT `FK_tquotationmaterial_amend_nHSNID` FOREIGN KEY (`nHSNID`) REFERENCES `mhsn`(`nHSNID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationmaterial_amend` ADD CONSTRAINT `FK_tquotationmaterial_amend_nItemCategoryID` FOREIGN KEY (`nItemCategoryID`) REFERENCES `mitemcategory`(`nItemCategoryID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationmaterial_amend` ADD CONSTRAINT `FK_tquotationmaterial_amend_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationmaterial_amend` ADD CONSTRAINT `FK_tquotationmaterial_amend_nQuotation_AmendID` FOREIGN KEY (`nQuotation_AmendID`) REFERENCES `tquotation_amend`(`nQuotation_AmendID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationmateriallayout` ADD CONSTRAINT `FK_tquotationmateriallayout_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationmateriallayout` ADD CONSTRAINT `FK_tquotationmateriallayout_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationmateriallayout` ADD CONSTRAINT `FK_tquotationmateriallayout_nQuotationID` FOREIGN KEY (`nQuotationID`) REFERENCES `tquotation`(`nQuotationID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationmateriallayout` ADD CONSTRAINT `FK_tquotationmateriallayout_nQuotationMaterialID` FOREIGN KEY (`nQuotationMaterialID`) REFERENCES `tquotationmaterial`(`nQuotationMaterialID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationmateriallayout_amend` ADD CONSTRAINT `FK_tquotationmateriallayout_amend_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationmateriallayout_amend` ADD CONSTRAINT `FK_tquotationmateriallayout_amend_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationmateriallayout_amend` ADD CONSTRAINT `FK_tquotationmateriallayout_amend_nQuotation_AmendID` FOREIGN KEY (`nQuotation_AmendID`) REFERENCES `tquotation_amend`(`nQuotation_AmendID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationpacket` ADD CONSTRAINT `FK_tquotationpacket_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationpacket` ADD CONSTRAINT `FK_tquotationpacket_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationpacket` ADD CONSTRAINT `FK_tquotationpacket_nPacketID` FOREIGN KEY (`nPacketID`) REFERENCES `mpacket`(`nPacketID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationpacket` ADD CONSTRAINT `FK_tquotationpacket_nQuotationID` FOREIGN KEY (`nQuotationID`) REFERENCES `tquotation`(`nQuotationID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationpacketdet` ADD CONSTRAINT `FK_tquotationpacketdet_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationpacketdet` ADD CONSTRAINT `FK_tquotationpacketdet_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationpacketdet` ADD CONSTRAINT `FK_tquotationpacketdet_nQuotationID` FOREIGN KEY (`nQuotationID`) REFERENCES `tquotation`(`nQuotationID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationpacketdet` ADD CONSTRAINT `FK_tquotationpacketdet_nQuotationItemsID` FOREIGN KEY (`nQuotationItemsID`) REFERENCES `tquotationitems`(`nQuotationItemsID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationpacketdet` ADD CONSTRAINT `FK_tquotationpacketdet_nQuotationPacketID` FOREIGN KEY (`nQuotationPacketID`) REFERENCES `tquotationpacket`(`nQuotationPacketID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationprocesswisemarkupdisc` ADD CONSTRAINT `FK_tquotationprocesswisemarkupdisc_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationprocesswisemarkupdisc` ADD CONSTRAINT `FK_tquotationprocesswisemarkupdisc_nItemProcessID` FOREIGN KEY (`nItemProcessID`) REFERENCES `mitemprocess`(`nItemProcessID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationprocesswisemarkupdisc` ADD CONSTRAINT `FK_tquotationprocesswisemarkupdisc_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationprocesswisemarkupdisc` ADD CONSTRAINT `FK_tquotationprocesswisemarkupdisc_nQuotationID` FOREIGN KEY (`nQuotationID`) REFERENCES `tquotation`(`nQuotationID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationprocesswisemarkupdisc_amend` ADD CONSTRAINT `FK_tquotationprocesswisemarkupdisc_amend_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationprocesswisemarkupdisc_amend` ADD CONSTRAINT `FK_tquotationprocesswisemarkupdisc_amend_nItemProcessID` FOREIGN KEY (`nItemProcessID`) REFERENCES `mitemprocess`(`nItemProcessID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationprocesswisemarkupdisc_amend` ADD CONSTRAINT `FK_tquotationprocesswisemarkupdisc_amend_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationprocesswisemarkupdisc_amend` ADD CONSTRAINT `FK_tquotationprocesswisemarkupdisc_amend_nQuotation_AmendID` FOREIGN KEY (`nQuotation_AmendID`) REFERENCES `tquotation_amend`(`nQuotation_AmendID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationroom` ADD CONSTRAINT `FK_tquotationroom_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationroom` ADD CONSTRAINT `FK_tquotationroom_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationroom` ADD CONSTRAINT `FK_tquotationroom_nQuotationID` FOREIGN KEY (`nQuotationID`) REFERENCES `tquotation`(`nQuotationID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationroom` ADD CONSTRAINT `FK_tquotationroom_nRoomTypeID` FOREIGN KEY (`nRoomTypeID`) REFERENCES `mroomtype`(`nRoomTypeID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationroom_amend` ADD CONSTRAINT `FK_tquotationroom_amend_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationroom_amend` ADD CONSTRAINT `FK_tquotationroom_amend_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationroom_amend` ADD CONSTRAINT `FK_tquotationroom_amend_nQuotation_AmendID` FOREIGN KEY (`nQuotation_AmendID`) REFERENCES `tquotation_amend`(`nQuotation_AmendID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationroom_amend` ADD CONSTRAINT `FK_tquotationroom_amend_nRoomTypeID` FOREIGN KEY (`nRoomTypeID`) REFERENCES `mroomtype`(`nRoomTypeID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationstockpartdetails` ADD CONSTRAINT `FK_tquotationstockpartdetails_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationstockpartdetails` ADD CONSTRAINT `FK_tquotationstockpartdetails_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationstockpartdetails` ADD CONSTRAINT `FK_tquotationstockpartdetails_nQuotationID` FOREIGN KEY (`nQuotationID`) REFERENCES `tquotation`(`nQuotationID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationstockpartdetails` ADD CONSTRAINT `FK_tquotationstockpartdetails_nQuotationMaterialLayoutID` FOREIGN KEY (`nQuotationMaterialLayoutID`) REFERENCES `tquotationmateriallayout`(`nQuotationMaterialLayoutID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationstockpartdetails_amend` ADD CONSTRAINT `FK_tquotationstockpartdetails_amend_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationstockpartdetails_amend` ADD CONSTRAINT `FK_tquotationstockpartdetails_amend_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationstockpartdetails_amend` ADD CONSTRAINT `FK_tquotationstockpartdetails_amend_nQuotation_AmendID` FOREIGN KEY (`nQuotation_AmendID`) REFERENCES `tquotation_amend`(`nQuotation_AmendID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationwastagefactor` ADD CONSTRAINT `FK_tquotationwastagefactor_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationwastagefactor` ADD CONSTRAINT `FK_tquotationwastagefactor_nItemCategoryID` FOREIGN KEY (`nItemCategoryID`) REFERENCES `mitemcategory`(`nItemCategoryID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationwastagefactor` ADD CONSTRAINT `FK_tquotationwastagefactor_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationwastagefactor` ADD CONSTRAINT `FK_tquotationwastagefactor_nQuotationID` FOREIGN KEY (`nQuotationID`) REFERENCES `tquotation`(`nQuotationID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationwastagefactor_amend` ADD CONSTRAINT `FK_tquotationwastagefactor_amend_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationwastagefactor_amend` ADD CONSTRAINT `FK_tquotationwastagefactor_amend_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tquotationwastagefactor_amend` ADD CONSTRAINT `FK_tquotationwastagefactor_amend_nQuotation_AmendID` FOREIGN KEY (`nQuotation_AmendID`) REFERENCES `tquotation_amend`(`nQuotation_AmendID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsmscredential` ADD CONSTRAINT `FK_tsmscredential_nCreatedid` FOREIGN KEY (`nCreatedid`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsmscredential` ADD CONSTRAINT `FK_tsmscredential_nModifiedid` FOREIGN KEY (`nModifiedid`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsysclientconfigurecompanywise` ADD CONSTRAINT `FK_tsysclientconfigurecompanywise_nBankSysClientConfigID` FOREIGN KEY (`nBankSysClientConfigID`) REFERENCES `mbanksysclientconfig`(`nbanksysclientconfigID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsysclientconfigurecompanywise` ADD CONSTRAINT `FK_tsysclientconfigurecompanywise_nCompanyID` FOREIGN KEY (`nCompanyID`) REFERENCES `mcompany`(`nCompanyID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsysclientconfigurecompanywise` ADD CONSTRAINT `FK_tsysclientconfigurecompanywise_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsysclientconfigurecompanywise` ADD CONSTRAINT `FK_tsysclientconfigurecompanywise_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsysclientsystemtaskconfigure` ADD CONSTRAINT `FK_tsysclientsystemtaskconfigure_nBankTaskSysclientConfigID` FOREIGN KEY (`nBankTaskSysclientConfigID`) REFERENCES `mbanktasksysclientconfig`(`nBankTaskSysclientConfigID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsysclientsystemtaskconfigure` ADD CONSTRAINT `FK_tsysclientsystemtaskconfigure_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsysclientsystemtaskconfigure` ADD CONSTRAINT `FK_tsysclientsystemtaskconfigure_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsysclientsystemtaskconfigure` ADD CONSTRAINT `FK_tsysclientsystemtaskconfigure_nuid` FOREIGN KEY (`nuid`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsysclientsystemtaskexecution` ADD CONSTRAINT `FK_tsysclientsystemtaskexecution_nBankTaskSysclientConfigID` FOREIGN KEY (`nBankTaskSysclientConfigID`) REFERENCES `mbanktasksysclientconfig`(`nBankTaskSysclientConfigID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsysclientsystemtaskexecution` ADD CONSTRAINT `FK_tsysclientsystemtaskexecution_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsysclientsystemtaskexecution` ADD CONSTRAINT `FK_tsysclientsystemtaskexecution_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsysclientsystemtaskexecution` ADD CONSTRAINT `FK_tsysclientsystemtaskexecution_nUID` FOREIGN KEY (`nUID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsystemhealth` ADD CONSTRAINT `FK_tsystemhealth_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsystemhealth` ADD CONSTRAINT `FK_tsystemhealth_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsystemhealthdet` ADD CONSTRAINT `FK_tsystemhealthdet_nBankmoduleDetID` FOREIGN KEY (`nBankmoduleDetID`) REFERENCES `mbankmoduledet`(`nBankModuleDetID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsystemhealthdet` ADD CONSTRAINT `FK_tsystemhealthdet_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsystemhealthdet` ADD CONSTRAINT `FK_tsystemhealthdet_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tsystemhealthdet` ADD CONSTRAINT `FK_tsystemhealthdet_nSystemHealthID` FOREIGN KEY (`nSystemHealthID`) REFERENCES `tsystemhealth`(`nSystemHealthID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `ttask` ADD CONSTRAINT `FK_ttask_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `ttask` ADD CONSTRAINT `FK_ttask_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `ttask` ADD CONSTRAINT `FK_ttask_nParentTaskID` FOREIGN KEY (`nParentTaskID`) REFERENCES `ttask`(`nTaskID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `ttask` ADD CONSTRAINT `FK_ttask_nReportToID` FOREIGN KEY (`nReportToID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `ttask` ADD CONSTRAINT `FK_ttask_nTaskTemplateID` FOREIGN KEY (`nTaskTemplateID`) REFERENCES `mtasktemplate`(`nTaskTemplateID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `ttask` ADD CONSTRAINT `FK_ttask_nVerifiedID` FOREIGN KEY (`nVerifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tuploads` ADD CONSTRAINT `FK_tuploads_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tuploads` ADD CONSTRAINT `FK_tuploads_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tuserprofile` ADD CONSTRAINT `FK_tuserprofile_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tuserprofile` ADD CONSTRAINT `FK_tuserprofile_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tuserprofiledet` ADD CONSTRAINT `FK_tuserprofiledet_nBankSysClientConfigID` FOREIGN KEY (`nBankSysClientConfigID`) REFERENCES `mbanksysclientconfig`(`nbanksysclientconfigID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tuserprofiledet` ADD CONSTRAINT `FK_tuserprofiledet_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tuserprofiledet` ADD CONSTRAINT `FK_tuserprofiledet_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tuserprofiledet` ADD CONSTRAINT `FK_tuserprofiledet_nUserProfileID` FOREIGN KEY (`nUserProfileID`) REFERENCES `tuserprofile`(`nUserProfileID`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tuserwisereportsetting` ADD CONSTRAINT `FK_tuserwisereportsetting_nBankModuleDetID` FOREIGN KEY (`nBankModuleDetID`) REFERENCES `mbankmoduledet`(`nBankModuleDetID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tuserwisereportsetting` ADD CONSTRAINT `FK_tuserwisereportsetting_nCreatedID` FOREIGN KEY (`nCreatedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tuserwisereportsetting` ADD CONSTRAINT `FK_tuserwisereportsetting_nModifiedID` FOREIGN KEY (`nModifiedID`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `tuserwisereportsetting` ADD CONSTRAINT `FK_tuserwisereportsetting_nuid` FOREIGN KEY (`nuid`) REFERENCES `muser`(`nUserID`) ON DELETE RESTRICT ON UPDATE RESTRICT;
