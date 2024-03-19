import { Request, Response, NextFunction } from "express";
import { prismaClient } from "../utils/db";

// Testing Panel controller

const testPanelController = async (req: Request, res: Response) => {
  res.json({ message: "Panel Controller Running" });
};

// Create a panel POST REQUEST

const createPanel = async (req: Request, res: Response, next: NextFunction) => {
  const { length, width, qty } = req.body;
  try {
    const panel = await prismaClient.panel.create({
      data: {
        length,
        width,
        qty,
      },
    });
    res.json(panel);
  } catch (error) {
    console.log("error", error);
    next(error);
  }
};

export default { createPanel, testPanelController };
