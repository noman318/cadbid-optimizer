import { Router } from "express";
import PanelController from "../controller/panel.controller";
import upload from "../middleware/multer.middleware";

const router = Router();

router.get("/test", PanelController.testPanelController);
router.route("/").post(PanelController.createPanel);
router.route("/upload").post(upload.single("file"), PanelController.uploadCsv);
export default router;
