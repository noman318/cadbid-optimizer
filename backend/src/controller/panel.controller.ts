import { Request, Response, NextFunction } from "express";
import { prisma } from "../utils/db";
import csv from "csvtojson";

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
    name,
    panelLength,
    panelWidth,
    panelQty,
    panelName,
  } = req.body;
  try {
    // Create the stock sheet
    const stockSheet = await prisma.stock_Sheets.create({
      data: {
        name,
        length,
        width,
        qty,
      },
    });
    // console.log("stockSheet", stockSheet);
    // Create the panel and connect it to the created stock sheet
    const panel = await prisma.panel.create({
      data: {
        panelName,
        panelLength,
        panelWidth,
        panelQty,
        // stockSheet: {
        //   connect: { id: stockSheet.id },
        // },
      },
    });
    // console.log("panel", panel);
    // Return both the created stock sheet and panel
    res.json({ stockSheet, panel });
  } catch (error) {
    console.log("error", error);
    next(error);
  }
};

const uploadCsv = async (req: Request, res: Response, next: NextFunction) => {
  // console.log("req", req.file);
  // res.send("running");
  const file = req?.file?.path;
  console.log("file", file);
  try {
    const panelData: any = [];
    if (!file) {
      return res.status(400).send("No file uploaded");
    } else {
      csv()
        .fromFile(file)
        .then(async (response: string | any[]) => {
          for (let i = 0; i < response.length; i++) {
            panelData.push({
              panelLength: +response[i].length,
              panelWidth: +response[i].width,
              panelQty: +response[i].qty,
              panelName: response[i].name,
            });
          }
          await prisma.panel.createMany({ data: panelData });
        });
    }
    return res.status(200).json({ message: "Uploaded CSV" });
  } catch (error) {
    console.log("error while uploading CSV", error);
    next(error);
  }
};

export default { createPanel, testPanelController, uploadCsv };
