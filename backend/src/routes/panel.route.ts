import { Router } from "express";
import PanelController from "../controller/panel.controller";

const router = Router();

router.get("/test", PanelController.testPanelController);
router.route("/").post(PanelController.createPanel);

export default router;
