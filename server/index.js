const express = require('express')
const mongoose = require('mongoose')

const authRouter = require('./routes/auth')

const app = express();
const PORT = 3000;

app.use(express.json())
app.use(authRouter)

mongoose.connect('mongodb+srv://abhishek:test123@cluster0.qs8jf.mongodb.net/?retryWrites=true&w=majority').then(() => {
    console.log('Database connected successfully')
}).catch((e) => {
    console.log(e)
})

app.listen(PORT, '0.0.0.0', () => {
    console.log(`Connected at port ${PORT}`)
})