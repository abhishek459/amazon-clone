const express = require("express");
const User = require("../models/user");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  const { name, email, password } = req.body;

  try {
    const user = await User.findOne({ email });
    if (user) {
      return res.status(400).send({ 'msg': 'User with this email alreaady exists!' })
    }

    const newUser = new User({
      name,
      email,
      password
    })

    await newUser.save()
    res.send(newUser)
  } catch (error) {
    res.status(500).send({error: error.message})
  }
});

module.exports = authRouter;
