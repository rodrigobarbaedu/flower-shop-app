// Import Libraries
const express = require('express');
const axios = require('axios');
const bodyParser = require('body-parser');
const exphbs = require('express-handlebars');
const path = require('path');
// Import Libraries

// Create Express Server and define port to listen
const app = express();
const port = 3000;
app.engine('.hbs', exphbs.engine({ extname: '.hbs', defaultLayout: 'main' }));
app.set('view engine', '.hbs');
// Create Express Server and define port to listen

// Setting up middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

app.set('view engine', '.hbs');
// Setting up middleware

/* ----- Routes ----- */

// Home
app.get('/', (req, res) => {
    res.render('index');
});
// Home

// Products
app.get('/products', async (req, res) => {
    try {
        const response = await axios.get('http://localhost:5001/webservice/get-products');

        const list = response.data;
        const convert_products = list.replace(/'/g, '"');

        const products = JSON.parse(convert_products);
        
        console.log(products);
        res.render('products', { products });
    } catch (error) {
        res.status(500).send(error.message);
    }
});
// Products

// Run server
app.listen(port, () => {
    console.log(`Servidor Node.js corriendo en http://localhost:${port}`);
});
// Run server
