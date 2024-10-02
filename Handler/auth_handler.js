const User = require('../Models/user_model');
const jwt = require('jsonwebtoken');
const bcrpt = require('bcrypt')
const config = require('../config');
exports.register = async (req, res) => {
    
    try {
        const { username, email, password } = req.body;
        const existinguser = await User.findOne({email});
         if(existinguser){
            return res.status(400).json({message: 'User already registered'});
         }        
         

         const hashedPassword = await bcrpt.hash(password, 10);
        const user = new User({ username,email, password: hashedPassword });
        
       await user.save();
        // jwt token for authorization
        const token = jwt.sign({email: user.email},config.SECRETK,{
           expiresIn: '120h' 
        });
       
        res.status(201).json({message: "Registration Successful",token: token })
    } catch (err){
        res.status(500).send('Error registering user');
    }
};

exports.login = async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email});
        if (!user) {
            return res.status(404).json({message:
            'user not found'});
        }
        // matching password in login screen
         const  matchpassword = await bcrpt.compare(password,user.password);
         if(!matchpassword){
         res.status(400).json({
            message:"Invalid credentials",});
        }
        
        const token = jwt.sign({email: user.email},config.SECRETK,{
            expiresIn: '120h' 
         });
       
        res.status(201).json({message: "Login Successful",token: token })
 
    } catch (err) {
        res.status(500).json({message: 'Error logging in'});
    }
};