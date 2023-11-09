const express = require("express");
const User = require("../models/userschema");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const cookieParser = require("cookieparser");
const router = express.Router();

router.post("/signup", (req, res) => {
  // console.log(req.body);
  const { name, phone, email, password, cpassword } = req.body;

  if (!name || !phone || !email || !password || !cpassword) {
    return res.status(422).json({ error: "Please fill all the fields" });
  }

  User.findOne({ email: email })
    .then((userExist) => {
      if (userExist) {
        return res.status(422).json({ error: "Email already exists" });
      }
      const user = new User({ name, phone, email, password, cpassword });
      user
        .save()
        .then(() => {
          res.status(201).json({ message: "User registered successfully" });
        })
        .catch((err) => res.status(500).json({ error: "Failed to register" }));
    })
    .catch((err) => {
      console.log(err);
    });

  
});


router.post("/login", async (req, res) => {
  try{
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ error: "Please fill all the fields" });
    }

    const userLogin = await User.findOne({ email: email });
    // console.log(userLogin);

    if(userLogin){
      const isMatch = await bcrypt.compare(password, userLogin.password);

      if(!isMatch){
        res.status(400).json({error: "Invalid credentials"});
      }else{
        const token = await userLogin.generateAuthToken();
        // console.log(token);

        res.cookie("jwtoken", token, {
          expires: new Date(Date.now() + 25892000000),
          httpOnly: true
        });

        res.status(200).json({message: "User logged in successfully"});
      }
    }else{
      res.status(400).json({ error: "Invalid credentials" });
    }

  }catch (err) {
    console.log(err);
  }
  

});

module.exports = router;
