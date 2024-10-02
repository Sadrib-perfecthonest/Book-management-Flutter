const mongoose = require('mongoose')

// here we are create a schema we use  new mongoose.schema
const Bookschema = new mongoose.Schema({
  id: {
    type: String,
    required:true,
    
  },
  title: {
    type: String,
    required:true,
    
  },
  author: {
    type: String,
    required:true,
  
  },
  pages : {
    type: Number,
    required:true
  },
  content :{
    type: String,
    required:true
  }  

});

module.exports = mongoose.model('Book',Bookschema)
