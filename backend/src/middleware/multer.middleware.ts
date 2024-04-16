import multer from "multer";
import path from "path";

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    // console.log("req", req);
    console.log("file", file);
    cb(null, path.join(__dirname, "../public/uploads"));
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname);
  },
});

// Create multer instance
const upload = multer({ storage: storage });
// const singleUpload = upload.single("file")
export default upload;
