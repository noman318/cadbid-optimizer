import { Request, Response, NextFunction } from "express";
import { prisma } from "../utils/db";
import { Session } from "express-session"; // Import Session type from express-session

const testUserController = (req: Request, res: Response) => {
  res.json({ message: "User Controller is running" });
};

const createUser = async (req: Request, res: Response) => {
  const { name, userName } = req.body;
  // console.log("name", name);
  const user = await prisma.user.create({
    data: { name, userName },
  });
  res.json(user);
};

const getAllUsers = async (req: Request, res: Response) => {
  const allUsers = await prisma.user.findMany({});
  res.json(allUsers);
};

const getSingleUser = async (req: Request, res: Response) => {
  const { id } = req.params;
  const user = await prisma.user.findUnique({ where: { id } });
  res.json(user);
};
const getUserById = async (nEmailUserID: string) => {
  try {
    const userId = parseInt(nEmailUserID);
    const user = await prisma.memailuser.findUnique({
      where: { nEmailUserID: userId },
    });

    return user;
  } catch (error) {
    return error;
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

    const userData = await prisma.user.findMany({});
    console.log("userData", userData);
    if (userData) {
      res.json({ message: "found" });
    }
    // res.json({ message: "Not Found" });
    return;
    //@ts-expect-error

    const existingUser = await getUserById(user.nEmailUserID!.toString());
    //@ts-expect-error
    if (!existingUser || existingUser.bEmailVerified === 0) {
      return res.status(401).json({ message: "Unauthorized" });
    }
    req.session.user = existingUser;
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
