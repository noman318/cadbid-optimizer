import { Request, Response, NextFunction } from "express";
import { prisma } from "../utils/db";
import csv from "csvtojson";

// Testing stocks controller

const testStocksController = async (req: Request, res: Response) => {
  res.json({ message: "Stock Controller Running" });
};

// Get all stocks sheets

const getAllStockSheets = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const stockSheets = await prisma.mStockSheets.findMany({});
    const modifiedStockSheets = stockSheets?.map((stock) => ({
      id: stock.sStockID,
      sName: stock.sName,
      nLength: stock.nLength,
      nWidth: stock.nWidth,
      nQty: stock.nQty,
      bIsEnabled: stock.bIsEnabled,
    }));
    return res.json(modifiedStockSheets);
  } catch (error) {
    console.log("error", error);
    next(error);
  }
};

const getSingleStockData = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { id } = req.params;
  try {
    const stockSheet = await prisma.mStockSheets.findUnique({
      where: { sStockID: id },
    });
    if (!stockSheet) {
      throw new Error("No stock sheeet with given ID found");
    }
    res.json(stockSheet);
  } catch (error) {
    console.log("error", error);
    next(error);
  }
};

// Create a Stock Sheets POST REQUEST

const createStocksSheets = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { nLength, nWidth, nQty, sName, bIsEnabled } = req.body;
  try {
    const stockSheet = await prisma.mStockSheets.create({
      data: {
        sName,
        nLength,
        nWidth,
        nQty,
        bIsEnabled: true,
      },
    });
    res.json(stockSheet);
  } catch (error) {
    console.log("error", error);
    next(error);
  }
};

const updateStockSheet = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { id } = req.params;
  console.log("id", id);
  const { nLength, nWidth, nQty, sName, bIsEnabled } = req.body;

  try {
    const stockSheet = await prisma.mStockSheets.findUnique({
      where: { sStockID: id },
    });
    // console.log("stockSheet", stockSheet);
    if (!stockSheet) {
      throw new Error("No Stock Sheet with this ID found");
    } else {
      await prisma.mStockSheets.update({
        where: { sStockID: id },
        data: {
          sName,
          nLength,
          nWidth,
          nQty,
          bIsEnabled: bIsEnabled ?? true,
        },
      });
      return res.json({ message: "Updated Successfully" });
    }
  } catch (error) {
    next(error);
  }
};

const deleteStockSheet = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { id } = req.params;
  console.log("id", id);
  try {
    const stockSheet = await prisma.mStockSheets.findUnique({
      where: { sStockID: id },
    });
    // console.log("stockSheet", stockSheet);
    if (!stockSheet) {
      throw new Error("No Stock Sheet with this ID found");
    } else {
      await prisma.mStockSheets.delete({ where: { sStockID: id } });
      return res.json({ message: "Deleted Successfully" });
    }
  } catch (error) {
    next(error);
  }
};

const uploadCsv = async (req: Request, res: Response, next: NextFunction) => {
  // console.log("req", req.file);
  // res.send("running");
  console.log("req.file", req.file);
  const file = req?.file?.path;
  // console.log("file", file);
  try {
    const stockSheetData: any = [];
    if (!file) {
      return res.status(400).send("No file uploaded");
    } else {
      csv()
        .fromFile(file)
        .then(async (response) => {
          // console.log("response", response);
          for (let i = 0; i < response.length; i++) {
            stockSheetData.push({
              nLength: +response[i].length,
              nWidth: +response[i].width,
              nQty: +response[i].qty,
              sName: response[i].name,
              bIsEnabled: true,
            });
          }
          await prisma.mStockSheets.createMany({ data: stockSheetData });
        });
    }
    return res.status(200).json({ message: "Uploaded CSV" });
  } catch (error) {
    console.log("error while uploading CSV", error);
    next(error);
  }
};

export default {
  createStocksSheets,
  testStocksController,
  uploadCsv,
  getAllStockSheets,
  getSingleStockData,
  deleteStockSheet,
  updateStockSheet,
};
