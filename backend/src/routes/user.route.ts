import { Router } from "express";
import UserController from "../controller/user.controller";

const router = Router();

router.get("/", UserController.testUserController);
router.post("/create", UserController.createUser);
router.get("/all", UserController.getAllUsers);
router.post("/login", UserController.loginUser);
router.get("/:id", UserController.getSingleUser);

export default router;
