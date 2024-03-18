// Importar librerías
const express = require('express');
const axios = require('axios');
const bodyParser = require('body-parser');
// Importar librerías

// Crear servidor en Express y definir puerto de escucha
const app = express();
const port = 3000;
// Crear servidor en Express y definir puerto de escucha

// Configurar servidor
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('public'));
// Configurar servidor

// Definir rutas para consumir servicio web de Flask SOAP
app.post('/multiply', async (req, res) => {
    try {
        const num1 = parseInt(req.body.num1);
        const num2 = parseInt(req.body.num2);

        // Consumir el servicio Flask SOAP
        const response = await axios.post('http://localhost:5001/webservice/multiply', { num1, num2 });

        res.send(response.data);
    } catch (error) {
        res.status(500).send(error.message);
    }
});
// Definir rutas para consumir servicio web de Flask SOAP

// Iniciar servidor
app.listen(port, () => {
    console.log(`Servidor Node.js corriendo en http://localhost:${port}`);
});
// Iniciar servidor
