const express = require('express');
const mongoose = require('mongoose');
const app = express()
const config = require('./config');
const AuthRouter = require('../Backend Book manager/Routes/auth_route');
const BookRouter = require('../Backend Book manager/Routes/book_route')

const url = 'mongodb://localhost/BookManager';
mongoose.connect(url,{useNewUrlParser: true,useUnifiedTopology: true} );
const con = mongoose.connection ;
con.on('open',function(){
    console.log("Connected..")
})

app.use(express.json())// reads as strings we use it
const cors = require('cors');
app.use(cors())


app.use('/Auths',AuthRouter);
app.use('/books',BookRouter);

app.listen(config.port,'0.0.0.0',() => {
    console.log('Server Started')
})

