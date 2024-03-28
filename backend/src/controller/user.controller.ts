import { Request, Response, NextFunction } from "express";
import { prismaClient } from "../utils/db";

const testUserController = (req: Request, res: Response) => {
  res.json({ message: "User Controller is running" });
};

const createUser = async (req: Request, res: Response) => {
  const { name, userName } = req.body;
  // console.log("name", name);
  const user = await prismaClient.user.create({
    data: { name, userName },
  });
  res.json(user);
};

const getAllUsers = async (req: Request, res: Response) => {
  const allUsers = await prismaClient.user.findMany({});
  res.json(allUsers);
};

const getSingleUser = async (req: Request, res: Response) => {
  const { id } = req.params;
  const user = await prismaClient.user.findUnique({ where: { id } });
  res.json(user);
};

export default { createUser, getAllUsers, getSingleUser, testUserController };
