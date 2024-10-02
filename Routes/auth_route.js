const express = require('express')
const router = express.Router()
const Authhandler = require('../Handler/auth_handler')
const{validateRegister,validateLogin}= require('../Middleware/A middleware')

router.post('/Register',validateRegister,Authhandler.register);
router.post('/Login',validateLogin,Authhandler.login);


module.exports = router