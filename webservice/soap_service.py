# Importar las librerías necesarias
from spyne import Application, rpc, ServiceBase, Iterable, Integer, Unicode
from spyne.protocol.soap import Soap11
from spyne.server.wsgi import WsgiApplication
# Importar las librerías necesarias

# Crear un servicio web que recibe dos números y los multiplica
class MathService(ServiceBase):
    @rpc(Integer, Integer, _returns=Integer)
    def multiply(ctx, num1, num2):
        return num1 * num2
# Crear un servicio web que recibe dos números y los multiplica

# Configurar la aplicación Spyne
app = Application([MathService], 'example',
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
