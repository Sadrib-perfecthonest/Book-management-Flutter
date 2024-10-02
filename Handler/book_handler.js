const Book = require('../Models/book_model')

exports.createBook = async (req, res) => {
    try {
    const book = new Book({
        id: req.body.id,
        title: req.body.title,
        author: req.body.author,
        pages: req.body.pages,
        content: req.body.content
    });

     await book.save();

    } catch (err) {
        res.status(400).json({ message: err.message });
    }
};
 exports.getallBooks = async (req, res) => {
    try {
        const books = await Book.find();
        res.json(books);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};

exports.getBookById = async (req,res) => {
  try{
  const book = await Book.findOne({id : req.params.id});
  if(!book) {
    return res.status(500).send('Book not found');
}
  res.send(book);
  

}catch{
    res.status(500).json({ message: err.message });

  }
};
exports.updateBook = async (req, res) => {
    try {
        const book = await Book.findOne({id : req.params.id});
        
        if (req.body.id != null) {
            book.id = req.body.id;
        }
        if (req.body.title != null) {
            book.title = req.body.title;
        }
        if (req.body.author != null) {
            book.author = req.body.author;
        }
        if (req.body.pages != null) {
            book.pages = req.body.pages;
        }
        if (req.body.content!= null) {
            book.content = req.body.content;
        }

        const updatedBook = await book.save();
            res.json(updatedBook);
    
    
} catch (err) {
        res.status(400).json({ message: err.message });
    }
};

exports.deleteBook = async (req, res) => {
    try {
        const book = await Book.findOne({id : req.params.id});
        if(!book){
            res.status(400).json({ message: 'Book not found' });   
        }
         await Book.deleteOne({id : req.params.id});
         res.status(200).send("Book deleted successfully");
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
};