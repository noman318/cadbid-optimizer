import { Request, Response, NextFunction } from "express";
import { prisma } from "../utils/db";

// Testing Panel controller

const testPanelController = async (req: Request, res: Response) => {
  res.json({ message: "Panel Controller Running" });
};

// Create a panel POST REQUEST

const createPanel = async (req: Request, res: Response, next: NextFunction) => {
  // console.log("calling Create");
  console.log("req.body", req.body);
  const {
    length,
    width,
    qty,
    stockSheet: stockSheetData,
    panelLength,
    panelWidth,
    panelQty,
  } = req.body;
  try {
    // Create the stock sheet
    const stockSheet = await prisma.stock_Sheets.create({
      data: {
        length,
        width,
        qty,
      },
    });
    console.log("stockSheet", stockSheet);
    // Create the panel and connect it to the created stock sheet
    const panel = await prisma.panel.create({
      data: {
        panelLength,
        panelWidth,
        panelQty,
        stockSheet: {
          connect: { id: stockSheet.id },
        },
      },
    });
    console.log("panel", panel);
    // Return both the created stock sheet and panel
    res.json({ stockSheet, panel });
  } catch (error) {
    console.log("error", error);
    next(error);
  }
};

export default { createPanel, testPanelController };
