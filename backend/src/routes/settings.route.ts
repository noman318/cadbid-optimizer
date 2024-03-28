import { Router } from "express";
import settingsController from "../controller/settings.controller";

const router = Router();

router.post("/create", settingsController.createSetting);
router.get("/all", settingsController.getAllSettings);
router.get("/:id", settingsController.getSettings);

export default router;
