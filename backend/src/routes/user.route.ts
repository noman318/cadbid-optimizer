import { Router } from "express";
import UserController from "../controller/user.controller";

const router = Router();

router
  .route("/")
  .get(UserController.getAllUsers)
  .post(UserController.createUser);
router.route("/login").post(UserController.loginUser);
// router.post("/create", UserController.createUser);
// router.get("/all", UserController.getAllUsers);
// router.post("/login", UserController.loginUser);
router.route("/:id").get(UserController.getSingleUser);

export default router;
