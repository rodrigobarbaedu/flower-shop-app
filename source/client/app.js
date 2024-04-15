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

shopping_cart = [];
total_checkout = 0;

// Home
app.get('/', (req, res) => {
    res.render('dashboard');
});
// Home

/* ----- SOAP ----- */

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

// Sales/Receipt
app.get('/sales/receipt/:id', async (req, res) => {
    try {
        const response = await axios.get(`http://localhost:5001/webservice/get-order-receipt/${req.params.id}`);

        const list = response.data;
        const convert_sales = list.replace(/'/g, '"');

        const order_data = JSON.parse(convert_sales);

        const essential_data = order_data[0];
        const get_orders_by_id = order_data[1];
        const get_users_by_id = order_data[2];
        const total_price = order_data[3][0];

        res.render('receipt', { essential_data, get_orders_by_id, get_users_by_id, total_price });
    } catch (error) {
        res.status(500).send(error.message);
    }
});
// Sales/Receipt

// Shop
app.get('/shop', async (req, res) => {
    try {
        const response = await axios.get('http://localhost:5001/webservice/get-products');

        const list = response.data;
        const convert_products = list.replace(/'/g, '"');

        const products = JSON.parse(convert_products);
        total_checkout = function() {
            let total = 0;
            shopping_cart.forEach(item => {
                total += item.price * item.quantity;
            });
            return total;
        }

        const isEmpty = shopping_cart.length === 0;
        
        res.render('shop', { products, shopping_cart, total_checkout, isEmpty });
    } catch (error) {
        res.status(500).send(error.message);
    }
});
// Shop

// Shop/Add POST
app.post('/shop/add/:id', async (req, res) => {
    try {
        const response = await axios.get(`http://localhost:5001/webservice/get-product/${req.params.id}`);

        const list = response.data;
        const convert_product = list.replace(/'/g, '"');

        const product = JSON.parse(convert_product);
        const quantity = req.body.quantity;

        // Check if product is already in the shopping cart
        const index = shopping_cart.findIndex(item => item.product_id === product[0]);

        if (index !== -1) {
            shopping_cart[index].quantity += parseInt(quantity);
        } else {
            shopping_cart.push(
                {
                    id: shopping_cart.length + 1,
                    user_id: 0,
                    product_id: product[0],
                    name: product[1],
                    price: product[5],
                    quantity: parseInt(quantity),
                    subtotal: product[5] * parseInt(quantity)
                }
            );
        }

        res.redirect('/shop');
    } catch (error) {
        res.status(500).send(error.message);
    }
});
// Shop/Add POST

// Shop/Remove POST
app.post('/shop/remove/:id', async (req, res) => {
    try {
        shopping_cart = shopping_cart.filter(item => item.id != req.params.id);

        res.redirect('/shop');
    } catch (error) {
        res.status(500).send(error.message);
    }
});
// Shop/Remove POST

// Shop/Clear
app.get('/shop/clear', async (req, res) => {
    try {
        shopping_cart = [];

        res.redirect('/shop');
    } catch (error) {
        res.status(500).send(error.message);
    }
});
// Shop/Clear

// Shop/Receipt POST
app.post('/shop/receipt', async (req, res) => {
    try {
        const name = req.body.name;
        const lastname = req.body.lastname;
        const date = new Date().toISOString().slice(0, 19).replace('T', ' ');

        total = total_checkout();

        res.render('receipt-final', {shopping_cart, total, name, lastname, date});

        shopping_cart = [];
        total_checkout = 0;
    } catch (error) {
        res.status(500).send(error.message);
    }
});
// Shop/Receipt POST

/* ----- SOAP ----- */

/* ----- REST ----- */

// Products
app.get('/rest/products', (req, res) => {
    axios.get('http://localhost:5001/api/products')
    .then(response => {
        const products = response.data;
        res.render('products-rest', { products });
    })
    .catch(error => {
        res.status(500).send(error.message);
    })
});
// Products

// Products / Add
app.post('/rest/products', (req, res) => {
    axios.post('http://localhost:5001/api/products', {
        name: req.body.name,
        description: req.body.description,
        quantity: req.body.quantity,
        alert_quantity: req.body.alert_quantity,
        price: req.body.price,
        url_image: req.body.url_image
    })
    .then(response => {
        console.log(response.data);
        res.redirect('/rest/products');
    })
    .catch(error => {
        res.status(500).send(error.message);
    })
});
// Products / Add

// Products / Edit
app.get('/rest/products/edit/:id', (req, res) => {
    axios.get(`http://localhost:5001/api/products-params/${req.params.id}`)
    .then(response => {
        const product = response.data;
        res.render('products-rest-edit', { product });
    })
    .catch(error => {
        res.status(500).send(error.message);
    })
});

app.post('/rest/products/edit', (req, res) => {
    axios.put(`http://localhost:5001/api/products`, {
        id: req.body.id,
        name: req.body.name,
        description: req.body.description,
        quantity: req.body.quantity,
        alert_quantity: req.body.alert_quantity,
        price: req.body.price,
        url_image: req.body.url_image
    })
    .then(response => {
        console.log(response.data);
        res.redirect('/rest/products');
    })
    .catch(error => {
        res.status(500).send(error.message);
    })
});
// Products / Edit

// Products / Delete
app.post('/rest/products/:id', (req, res) => {
    axios.delete(`http://localhost:5001/api/products/${req.body.id}`)
    .then(response => {
        console.log(response.data);
        res.redirect('/rest/products');
    })
    .catch(error => {
        res.status(500).send(error.message);
    })
});
// Products / Delete

/* ----- REST ----- */

// Run server
app.listen(port, () => {
    console.log(`Servidor Node.js corriendo en http://localhost:${port}`);
});
// Run server