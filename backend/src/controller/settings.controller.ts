import { Request, Response } from "express";
import { prisma } from "../utils/db";

const testSettingsController = (req: Request, res: Response) => {
  res.json({ message: "Settings controller is working" });
};

const createSetting = async (req: Request, res: Response) => {
  //   console.log("req.body", req.body);
  try {
    const {
      trimLeft,
      trimRight,
      trimTop,
      trimBottom,
      bladeWidth,
      minimizeLayoutNumber,
      minimizeSheetRotation,
      userId,
    } = req.body;

    const settings = await prisma.settings.create({
      data: {
        trimLeft: typeof trimLeft === "string" ? Number(trimLeft) : trimLeft,
        trimRight:
          typeof trimRight === "string" ? Number(trimRight) : trimRight,
        trimTop: typeof trimTop === "string" ? Number(trimTop) : trimTop,
        trimBottom:
          typeof trimBottom === "string" ? Number(trimBottom) : trimBottom,
        bladeWidth:
          typeof bladeWidth === "string" ? Number(bladeWidth) : bladeWidth,
        minimizeLayoutNumber:
          typeof minimizeLayoutNumber === "string"
            ? minimizeLayoutNumber.toLowerCase() === "true"
            : minimizeLayoutNumber,
        minimizeSheetRotation:
          typeof minimizeSheetRotation === "string"
            ? minimizeSheetRotation.toLowerCase() === "true"
            : minimizeSheetRotation,
        userId,
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
  const settingData = await prisma.settings.findUnique({
    where: { id },
    include: { user: true },
  });
  res.json(settingData);
};

const getAllSettings = async (req: Request, res: Response) => {
  const allSettings = await prisma.settings.findMany({
    include: { user: true },
  });
  res.json(allSettings);
};

export default { createSetting, getSettings, getAllSettings };
