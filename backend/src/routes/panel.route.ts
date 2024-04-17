import { Router } from "express";
import PanelController from "../controller/panel.controller";
import upload from "../middleware/multer.middleware";

const router = Router();

router.get("/test", PanelController.testPanelController);
router
  .route("/")
  .get(PanelController.getAllPanels)
  .post(PanelController.createPanel);
router.route("/upload").post(upload.single("file"), PanelController.uploadCsv);
router.route("/:id").get(PanelController.getSinglePanel);
export default router;
