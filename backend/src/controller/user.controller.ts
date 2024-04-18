import { Request, Response, NextFunction } from "express";
import { prisma } from "../utils/db";
import { Session } from "express-session"; // Import Session type from express-session
import bcrypt from "bcryptjs";
const testUserController = (req: Request, res: Response) => {
  res.json({ message: "User Controller is running" });
};

const createUser = async (req: Request, res: Response) => {
  const { sName, sUserName, sPassword } = req.body;
  // console.log("name", name);
  const hashedPassword = await bcrypt.hash(sPassword, 10);
  console.log("hashedPassword", hashedPassword);
  try {
    const user = await prisma.mUserNew.create({
      data: { sName, sUserName, sPassword: hashedPassword },
    });
    res.json(user);
  } catch (error) {
    console.log("error", error);
  }
};

const getAllUsers = async (req: Request, res: Response) => {
  try {
    const allUsers = await prisma.mUserNew.findMany({});
    res.json(allUsers);
  } catch (error) {
    console.log("error", error);
  }
};

const getSingleUser = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const user = await prisma.mUserNew.findUnique({ where: { sUserID: id } });
    res.json(user);
  } catch (error) {
    console.log("error", error);
  }
};

// const user = getUserById("1");
// console.log("user", user);

interface CustomRequest extends Request {
  session: Session & { user?: any }; // Make sure session property matches Session type
}
const loginUser = async (req: CustomRequest, res: Response) => {
  try {
    console.log("req.body", req.body);
    const { email } = req.body;
    console.log("email", email);

    // const user = await prisma.user.findUnique({ where: { userName: email } });

    // res.json({ message: "Not Found" });
    // return;

    return res.status(200).json({ success: true });
  } catch (error) {
    console.error("Error processing login:", error);
    return res.status(500).json({ message: "Internal Server Error" });
  }
};

export default {
  createUser,
  getAllUsers,
  getSingleUser,
  testUserController,
  loginUser,
};
