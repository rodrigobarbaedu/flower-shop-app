# Importar las librerías necesarias
from spyne import Application, rpc, ServiceBase, Iterable, Integer, Unicode
from spyne.server.wsgi import WsgiApplication
from spyne.protocol.soap import Soap11
from mysql import connector
# Importar las librerías necesarias

# Web Service - get_orders
class WebService(ServiceBase):
    @rpc(_returns=Iterable(Unicode))
    def get_orders(self):
        # Conexión a la base de datos
        mydb = connector.connect(
            host="localhost",
            user="root",
            password="root",
            database="flower_shop"
        )

        # Crear un cursor para la base de datos
        mycursor = mydb.cursor()

        # Ejecutar la consulta SQL
        sql = "SELECT * FROM orders"
        mycursor.execute(sql)

        # Obtener los resultados
        myresult = mycursor.fetchall()

        # Retornar los resultados
        return myresult
# Web Service - get_orders

# Configurar la aplicación Spyne
app = Application([WebService], 'example',
                  in_protocol=Soap11(validator='lxml'),
                  out_protocol=Soap11())

wsgi_app = WsgiApplication(app)
# Configurar la aplicación Spyne

# Iniciar el servidor SOAP en http://localhost:5002/soap
if __name__ == '__main__':
    from wsgiref.simple_server import make_server
    server = make_server('0.0.0.0', 5002, wsgi_app)
    server.serve_forever()
# Iniciar el servidor SOAP en http://localhost:5000/soap
