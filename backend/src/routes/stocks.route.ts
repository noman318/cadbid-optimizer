import { Router } from "express";
import StockSheetController from "../controller/stocks.controller";

const router = Router();

router
  .route("/")
  .get(StockSheetController.testStocksController)
  .post(StockSheetController.createStocksSheets);
// router.post("/create");

export default router;
