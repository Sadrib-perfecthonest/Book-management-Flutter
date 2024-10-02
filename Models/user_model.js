const mongoose = require('mongoose')

// here we are create a schema we use  new mongoose.schema
const userschema = new mongoose.Schema({
  username: {
    type: String,
    required:[true,'please enter the user name'],
    unique: true
  },
  email: {
    type: String,
    required:true,
    unique:true
  },
  password : {
    type: String,
    required:[true,'Please enter the passwords '],
    minlength:[6,'Minimum password length is 6 characters']

},

}) // this is how we connect with database the structure we want this schema

// hashing part for password hashing what it does uniquely transforming that given key or a string into another value
// we install npm bcrpt for hashing
/*const bcrpt = require('bcrypt')

// fire a function before doc saved to db here we take password

userschema.pre('save',async function(next){
  const salt = await bcrpt.genSalt(10); // first we salt
  this.password = await bcrpt.hash(this.password,salt);
  next();
})*/

// here by export schema we have model from mongoose.model
// module.exports means object in a file specifies the value to be exported from that file
module.exports = mongoose.model('User',userschema);