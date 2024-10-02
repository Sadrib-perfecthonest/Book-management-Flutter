const express = require('express')
const router = express.Router();

const bookHandlers = require('../Handler/book_handler')


router.post('/', bookHandlers.createBook);
router.get('/',bookHandlers.getallBooks);
router.get('/:id',bookHandlers.getBookById);
router.put('/:id',bookHandlers.updateBook);
router.delete('/:id',bookHandlers.deleteBook);



module.exports = router;