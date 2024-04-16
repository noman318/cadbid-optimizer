import { Router } from "express";
import StockSheetController from "../controller/stocks.controller";
import upload from "../middleware/multer.middleware";

const router = Router();

router
  .route("/")
  .get(StockSheetController.testStocksController)
  .post(StockSheetController.createStocksSheets);

router
  .route("/upload")
  .post(upload.single("file"), StockSheetController.uploadCsv);
// router.post("/create");

export default router;
