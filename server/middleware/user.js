const jwt = require('jsonwebtoken')
const User = require('../models/user')

const userAuth = async (req, res, next) => {
    try {
        const token = req.header('token')
        const decoded = jwt.verify(token, 'somesecretsauce')
        const user = await User.findOne({ _id: decoded.id, 'token': token })

        if (!user) {
            throw new Error()
        }

        req.user = user
        next()
    } catch (error) {
        res.status(401).send({ msg: 'Session expired, please login again' })
    }
    next()
}

module.exports = userAuth