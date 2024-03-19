# Importar las librerías necesarias
from flask import Flask, request
from suds.client import Client
# Importar las librerías necesarias

# Iniciar el servidor Flask
app = Flask(__name__)
# Iniciar el servidor Flask

# Servicio web que recibe una solicitud POST con dos números y los multiplica
@app.route('/webservice/multiply', methods=['POST'])
def soap():
    try:
        # Imprime la solicitud XML en la consola de Flask
        print(request.data)  

        # Obtener los parámetros del formulario recibidos
        num1 = request.json['num1']
        num2 = request.json['num2']

        # Conectar al servicio SOAP
        client = Client('http://localhost:5002/soap?wsdl')

        # Llamar a la operación SOAP de multiplicación
        result = client.service.multiply(num1, num2)

        # Envia los datos a la vista de la aplicación hecha en Node.js
        return "Solicitud SOAP recibida y procesada correctamente. La respuesta es: " + str(result)

    except Exception as e:
        return str(e)
# Servicio web que recibe una solicitud POST con dos números y los multiplica

# Iniciar el servidor Flask en http://localhost:5001
if __name__ == '__main__':
    app.run(debug=True, port=5001)
# Iniciar el servidor Flask en http://localhost:5001
    
