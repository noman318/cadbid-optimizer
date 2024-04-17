import { Request, Response, NextFunction } from "express";

const notFound = async (req: Request, res: Response, next: NextFunction) => {
  const error = new Error(`Not Found : ${req.originalUrl}`);
  return res.status(404).send(error);
};

const errorHandler = async (
  err: Error,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  let statusCode = res.statusCode === 200 ? 500 : res.statusCode;
  let errorMessage = err.message;
  res.status(statusCode).json({
    message: errorMessage,
    stack: process.env.NODE_ENV === "production" ? null : err.stack,
  });
};

export default { notFound, errorHandler };
