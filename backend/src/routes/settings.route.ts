import { Router } from "express";
import settingsController from "../controller/settings.controller";

const router = Router();

router
  .route("/")
  .get(settingsController.getAllSettings)
  .post(settingsController.createSetting);
router.route("/:id").get(settingsController.getSettings);

export default router;
