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
    const stockSheets = await prisma.stock_Sheets.findMany({});
    return res.json(stockSheets);
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
    const stockSheet = await prisma.stock_Sheets.findUnique({
      where: { id },
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
  const { length, width, qty } = req.body;
  try {
    const panel = await prisma.stock_Sheets.create({
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

const uploadCsv = async (req: Request, res: Response, next: NextFunction) => {
  // console.log("req", req.file);
  // res.send("running");
  console.log("req.file", req.file);
  const file = req?.file?.path;
  console.log("file", file);
  try {
    const stockSheetData: any = [];
    if (!file) {
      return res.status(400).send("No file uploaded");
    } else {
      csv()
        .fromFile(file)
        .then(async (response) => {
          for (let i = 0; i < response.length; i++) {
            stockSheetData.push({
              length: +response[i].length,
              width: +response[i].width,
              qty: +response[i].qty,
              name: response[i].name,
            });
          }
          await prisma.stock_Sheets.createMany({ data: stockSheetData });
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
};
