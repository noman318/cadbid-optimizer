import { Request, Response, NextFunction } from "express";
import { prisma } from "../utils/db";
import csv from "csvtojson";

// Testing Panel controller

const testPanelController = async (req: Request, res: Response) => {
  res.json({ message: "Panel Controller Running" });
};

// Get all Panels that have been uploaded

const getAllPanels = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const panels = await prisma.mPanel.findMany({});
    const modifiedPanels = panels.map((panel) => ({
      id: panel.sPanelID,
      sName: panel.sName,
      sMaterialName: panel.sMaterialName,
      nLength: panel.nLength,
      nWidth: panel.nWidth,
      nQty: panel.nQty,
      bIsEnabled: panel.bIsEnabled,
    }));
    return res.json(modifiedPanels);
  } catch (error) {
    console.log("error", error);
    next(error);
  }
};

const getSinglePanel = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { id } = req.params;
  try {
    const panel = await prisma.mPanel.findUnique({
      where: { sPanelID: id },
    });
    if (!panel) {
      throw new Error("No Panel with given ID found");
    }
    res.json(panel);
  } catch (error) {
    console.log("error", error);
    next(error);
  }
};

// Create a panel POST REQUEST

const createPanel = async (req: Request, res: Response, next: NextFunction) => {
  // console.log("req.body", req.body);
  const { nLength, nWidth, nQty, sName, sMaterialName, bIsEnabled } = req.body;
  try {
    // Create the stock sheet
    const panel = await prisma.mPanel.create({
      data: {
        sName,
        nLength,
        nWidth,
        nQty,
        sMaterialName,
        bIsEnabled: true,
      },
    });
    // console.log("stockSheet", stockSheet);
    // Create the panel and connect it to the created stock sheet
    // const panel = await prisma.panel.create({
    //   data: {
    //     panelName,
    //     panelLength,
    //     panelWidth,
    //     panelQty,
    //     // stockSheet: {
    //     //   connect: { id: stockSheet.id },
    //     // },
    //   },
    // });
    // console.log("panel", panel);
    // Return both the created stock sheet and panel
    res.json({ data: panel });
  } catch (error) {
    console.log("error", error);
    next(error);
  }
};

const updatePanel = async (req: Request, res: Response, next: NextFunction) => {
  const { id } = req.params;
  // console.log("id", id);
  // console.log("req.body", req.body);
  const { nLength, nWidth, nQty, sName, bIsEnabled, sMaterialName } = req.body;

  try {
    const panel = await prisma.mPanel.findUnique({
      where: { sPanelID: id },
    });
    // console.log("panel", panel);
    if (!panel) {
      throw new Error("No Panel with this ID found");
    }

    const updateData = {
      sName: sName || panel.sName,
      nLength: isNaN(+nLength) ? panel.nLength : +nLength,
      nWidth: isNaN(+nWidth) ? panel.nWidth : +nWidth,
      nQty: isNaN(+nQty) ? panel.nQty : +nQty,
      sMaterialName: sMaterialName || panel.sMaterialName,
      bIsEnabled: bIsEnabled !== undefined ? bIsEnabled : panel.bIsEnabled,
    };

    await prisma.mPanel.update({
      where: { sPanelID: id },
      data: updateData,
    });

    return res.json({ message: "Updated Successfully" });
  } catch (error) {
    next(error);
  }
};

const deletePanel = async (req: Request, res: Response, next: NextFunction) => {
  const { id } = req.params;
  console.log("id", id);
  try {
    const panel = await prisma.mPanel.findUnique({ where: { sPanelID: id } });
    // console.log("panel", panel);
    if (!panel) {
      throw new Error("No panel with this ID found");
    } else {
      await prisma.mPanel.delete({ where: { sPanelID: id } });
      return res.json({ message: "Deleted Successfully" });
    }
  } catch (error) {
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
          // console.log("response", response);
          for (let i = 0; i < response.length; i++) {
            panelData.push({
              nLength: +response[i].length,
              nWidth: +response[i].width,
              nQty: +response[i].qty,
              sName: response[i].name,
              sMaterialName: response[i].material,
              bIsEnabled: true,
            });
          }
          await prisma.mPanel.createMany({ data: panelData });
        });
    }
    return res.status(200).json({ message: "Uploaded CSV" });
  } catch (error) {
    console.log("error while uploading CSV", error);
    next(error);
  }
};

export default {
  createPanel,
  testPanelController,
  uploadCsv,
  getAllPanels,
  getSinglePanel,
  deletePanel,
  updatePanel,
};
