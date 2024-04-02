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
    res.render('dashboard');
});
// Home

// Products
app.get('/products', async (req, res) => {
    try {
        const response = await axios.get('http://localhost:5001/webservice/get-products');

        const list = response.data;
        const convert_products = list.replace(/'/g, '"');

        const products = JSON.parse(convert_products);
        
        res.render('products', { products });
    } catch (error) {
        res.status(500).send(error.message);
    }
});
// Products

// Users
app.get('/users', async (req, res) => {
    try {
        const response = await axios.get('http://localhost:5001/webservice/get-users');

        const list = response.data;
        console.log(list);
        const convert_users = list.replace(/'/g, '"');

        const users = JSON.parse(convert_users);
        
        res.render('users', { users });
    } catch (error) {
        res.status(500).send(error.message);
    }
});
// Users

// Sales
app.get('/sales', async (req, res) => {
    try {
        const response = await axios.get('http://localhost:5001/webservice/get-orders');

        const list = response.data;
        const convert_sales = list.replace(/'/g, '"');

        const sales = JSON.parse(convert_sales);
        
        res.render('sales', { sales });
    } catch (error) {
        res.status(500).send(error.message);
    }
});
// Sales

// Run server
app.listen(port, () => {
    console.log(`Servidor Node.js corriendo en http://localhost:${port}`);
});
// Run server
