import { Request, Response } from "express";
import { prisma } from "../utils/db";

const testSettingsController = (req: Request, res: Response) => {
  res.json({ message: "Settings controller is working" });
};

const createSetting = async (req: Request, res: Response) => {
  // console.log("req.body", req.body);
  try {
    const {
      nLeftTrim,
      nRightTrim,
      nBottomTrim,
      nTopTrim,
      nSawKerfValue,
      bMinmizePanelRotation,
      bCuttingLayoutMin,
      nCuttingComplexity,
      nMaxLayoutSize,
      userId,
      bCutDirection,
      bRollMode,
      sUserId,
      bLayoutNumber,
    } = req.body;

    const settings = await prisma.mSettings.create({
      data: {
        nLeftTrim:
          typeof nLeftTrim === "string" ? Number(nLeftTrim) : nLeftTrim,
        nRightTrim:
          typeof nRightTrim === "string" ? Number(nRightTrim) : nRightTrim,
        nBottomTrim:
          typeof nBottomTrim === "string" ? Number(nBottomTrim) : nBottomTrim,
        nTopTrim: typeof nTopTrim === "string" ? Number(nTopTrim) : nTopTrim,
        nSawKerfValue:
          typeof nSawKerfValue === "string"
            ? Number(nSawKerfValue)
            : nSawKerfValue,

        nCuttingComplexity:
          typeof nCuttingComplexity === "string"
            ? Number(nCuttingComplexity)
            : nCuttingComplexity,
        nMaxLayoutSize:
          typeof nMaxLayoutSize === "string"
            ? Number(nMaxLayoutSize)
            : nMaxLayoutSize,
        bCuttingLayoutMin:
          typeof bCuttingLayoutMin === "string"
            ? bCuttingLayoutMin.toLowerCase() === "true"
            : bCuttingLayoutMin,
        bMinmizePanelRotation:
          typeof bMinmizePanelRotation === "string"
            ? bMinmizePanelRotation.toLowerCase() === "true"
            : bMinmizePanelRotation,
        bLayoutNumber:
          typeof bLayoutNumber === "string"
            ? bLayoutNumber.toLowerCase() === "true"
            : bLayoutNumber,
        bCutDirection:
          typeof bCutDirection === "string"
            ? Number(bCutDirection)
            : bCutDirection,
        bRollMode:
          typeof bRollMode === "string"
            ? bRollMode.toLowerCase() === "true"
            : bRollMode,
        sUserId,
      },
    });

    res.json(settings);
  } catch (error) {
    console.error("Error creating setting:", error);
    res
      .status(500)
      .json({ error: "An error occurred while creating the setting." });
  }
};

const getSettings = async (req: Request, res: Response) => {
  const { id } = req.params;
  const settingData = await prisma.mSettings.findUnique({
    where: { sSettingsID: id },
    include: { user: true },
  });
  res.json(settingData);
};

const getAllSettings = async (req: Request, res: Response) => {
  const allSettings = await prisma.mSettings.findMany({
    include: { user: true },
  });
  res.json(allSettings);
};

export default { createSetting, getSettings, getAllSettings };
