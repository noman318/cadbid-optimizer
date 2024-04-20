import { Router } from "express";
import StockSheetController from "../controller/stocks.controller";
import upload from "../middleware/multer.middleware";

const router = Router();

router
  .route("/")
  .get(StockSheetController.getAllStockSheets)
  .post(StockSheetController.createStocksSheets);

router
  .route("/upload")
  .post(upload.single("file"), StockSheetController.uploadCsv);
// router.post("/create");
router
  .route("/:id")
  .get(StockSheetController.getSingleStockData)
  .delete(StockSheetController.deleteStockSheet)
  .put(StockSheetController.updateStockSheet);

export default router;
