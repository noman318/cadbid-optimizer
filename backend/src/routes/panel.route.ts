import { Router } from "express";
import PanelController from "../controller/panel.controller";

const router = Router();

router.get("/", PanelController.testPanelController);
router.post("/create", PanelController.createPanel);

export default router;
