const mongoose = require('mongoose')
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')

const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },
    email: {
        type: String,
        required: true,
        trim: true,
    },
    password: {
        type: String,
        required: true
    },
    address: {
        type: String,
        default: ''
    },
    type: {
        type: String,
        default: 'user'
    },
    token: {
        type: String
    }
})

userSchema.pre('save', async function (next) {
    const user = this

    if (user.isModified('password')) {
        user.password = await bcrypt.hash(user.password, 8)
    }

    next()
})

userSchema.statics.findByCredentials = async (email, password) => {
    const user = await User.findOne({ email })
    if (!user) {
        throw new Error('Email or Password incorrect')
    }

    const isMatch = await bcrypt.compare(password, user.password)
    if (!isMatch) {
        throw new Error('Email or Password incorrect')
    }

    return user
}

userSchema.methods.generateAuthToken = async function () {
    const user = this
    const token = jwt.sign({ id: user._id.toString() }, 'somesecretsauce')
    user.token = token
    await user.save()
    return token
}

const User = mongoose.model('User', userSchema)

module.exports = User