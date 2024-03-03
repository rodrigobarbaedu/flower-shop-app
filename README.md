# Proyecto de Aplicación Flask: Flora Vibrante 🌷

Este proyecto consiste en una aplicación de gestión de ventas y compras para una florería llamada 'Flora Vibrante'. La aplicación está desarrollada utilizando el framework Flask de Python y establece una comunicación con una base de datos para almacenar y recuperar información relevante.

---

### Funcionalidades Relevantes 🌱

La aplicación incluye las siguientes funcionalidades:

**Gestión de Ventas y Compras:** Permite realizar el registro y seguimiento de las transacciones de ventas y compras de la florería.

**Gestión de Usuarios:** Permite realizar el registro, edición y eliminación de usuarios dentro de la aplicación.

**Gestión de Productos:** Permite realizar el registro, edición y eliminación de products dentro de la aplicación.

**Gestión de Recibos:** Permite visualizar los recibos de compra por parte de los usuarios.

**Base de Datos:** Se han modelado entidades y tablas en la base de datos para almacenar información sobre clientes, productos, ventas y compras.

**Comunicación con el Servidor:** El servidor de la aplicación se encarga de manejar las solicitudes y respuestas entre la base de datos y las vistas de la aplicación. Garantiza la obtención y envío de información relevante de manera eficiente.

---

### Estructura del Proyecto 🌱

La estructura del proyecto sigue un diseño organizado en varios directorios:

- **`database/`:** Contiene scripts y archivos relacionados con la configuración y gestión de la base de datos MySQL.

- **`environment/ (No Incluido)`:** Incluye archivos relacionados con la configuración del entorno de desarrollo, como variables de entorno.

- **`source/`:** Es el directorio principal que contiene el código fuente de la aplicación Flask.

  - **`static/`:** Contiene archivos estáticos como hojas de estilo (CSS) e imágenes.

  - **`templates/`:** Almacena las plantillas HTML utilizadas por las vistas.

     - **`auth/`:** Aquí se encuentran los archivos de las vistas de autentificación.
       
     - **`public/`:** Aquí se encuentran los archivos de las vistas generales.

  - **`models/`:** Contiene los modelos de la aplicación.

    - **`entities/`:** Aquí se encuentran los archivos que modelan las entidades y tablas de la base de datos.

---

### Requisitos del Sistema 🌱

Asegúrese de tener instalados los siguientes requisitos antes de ejecutar la aplicación:

1. **Python 3.x:** Si no tiene instalado Python, puede descargarlo desde el sitio oficial [python.org](https://www.python.org/downloads/).

2. **MySQL:** Para instalar MySQL, siga las instrucciones específicas para su sistema operativo desde el [sitio oficial de MySQL](https://dev.mysql.com/downloads/).

---

### Configuración de la Base de Datos 🌱

Siga estos pasos para configurar la base de datos:

1. **Importar el Dump de la Base de Datos:**

   - **Método 1 (Consola):**
   
     - Asegúrese de tener MySQL Shell instalado y ejecutándose.

     - Desde la terminal, use el siguiente comando de MySQL Shell para importar el dump de la base de datos. Ajuste la ruta del archivo según la ubicación de su proyecto.

       ```bash
       mysql -u root -p root flower_shop < database/dumps/flower-shop-dump.sql
       ```

       Ingrese la contraseña cuando se le solicite.

   - **Método 2 (Recomendado) (MySQL Workbench Community):**

     - Inicie sesión como usuario `root` en MySQL Workbench Community.

     - Vaya al apartado de importación.

     - Seleccione el dump desde `database/dumps/flower-shop-dump.sql`.

     - Inicie la importación.

2. **Configurar Credenciales de la Aplicación:**

   - Si desea cambiar las credenciales predeterminadas para el usuario y la contraseña de la base de datos en la aplicación (Por defecto son 'root' y 'root', para usuario y contraseña respectivamente), modifique el archivo `source/config.py`.

     ```python
     # Configuraciones
     class development_config():
         DEBUG = True
         SECRET_KEY = "qhrf$edjYTJ)*21nsThdK"
         MYSQL_HOST = "localhost"
         MYSQL_USER = ""  # Cambie al nuevo nombre de usuario
         MYSQL_PASSWORD = ""  # Cambie a la nueva contraseña
         MYSQL_DB = "flower_shop"
     # Configuraciones

     # Configuraciones (Entorno)
     config = {"development": development_config}
     # Configuraciones (Entorno)
     ```

     Reemplace `MYSQL_USER` y `MYSQL_PASSWORD` con sus preferencias.

---

### Instrucciones de Ejecución para Linux 🌱

#### `run_program.sh`

1. **Permisos:**
   - Asegúrate de que el archivo tenga permisos de ejecución:
     ```bash
     chmod +x run_program.sh
     ```

2. **Ejecución:**
   - Ejecuta el script:
     ```bash
     ./run_program.sh
     ```
   
3. **Selección de Opciones:**
   - El script presentará un menú interactivo como el siguiente:

     ```text
     Selecciona una opción:
      1. Crear entorno virtual con una versión específica de Python
      2. Activar entorno virtual
      3. Instalar dependencias desde requirements.txt
      4. Visualizar dependencias de requirements.txt
      5. Ejecutar programa
      6. Desactivar entorno virtual
      7. Salir
     ```

   - Se deberán seleccionar las opciones de manera secuencial hasta llegar a la opción 5.

5. **Pasos Detallados:**
  
    1. **Crear entorno virtual con una versión específica de Python:**
       - Solicita al usuario que ingrese la versión de Python deseada.
       - Utiliza `python$python_version -m venv environment` para crear un entorno virtual llamado "environment" con la versión específica de Python proporcionada.
       - Muestra un mensaje indicando que el entorno virtual se creó con éxito.
    
    2. **Activar entorno virtual:**
       - Intenta activar el entorno virtual utilizando `source ./environment/bin/activate` o `. ./environment/bin/activate`.
       - Muestra un mensaje indicando que el entorno virtual se ha activado.
    
    3. **Instalar dependencias desde requirements.txt:**
       - Verifica si el entorno virtual está activado.
       - Si es así, utiliza `pip install -r requirements.txt` para instalar las dependencias del archivo `requirements.txt`.
       - Muestra un mensaje indicando que las dependencias se han instalado.
    
    4. **Visualizar dependencias de requirements.txt:**
       - Verifica si el entorno virtual está activado.
       - Si es así, utiliza `cat requirements.txt` para mostrar las dependencias listadas en el archivo `requirements.txt`.
    
    5. **Ejecutar programa:**
       - Utiliza `python3 ./source/app.py` para ejecutar el programa Flask.
       - El script asume que el punto de entrada del programa Flask es `app.py`.
       - Ahora podrá acceder a la aplicación desde 'localhost' o 'http://127.0.0.1:5000/'.
    
    6. **Desactivar entorno virtual:**
       - Utiliza `deactivate` para desactivar el entorno virtual.
       - Muestra un mensaje indicando que el entorno virtual se ha desactivado.
    
    7. **Salir:**
       - Muestra un mensaje indicando que el script está saliendo.
       - Finaliza la ejecución del script con `exit 0`.

---

### Instrucciones de Ejecución para Windows 🌱

#### `run_program.ps1`

1. **Ejecución:**
   - Ejecuta el script en PowerShell:
     ```powershell
     .\run_program.ps1
     ```

2. **Selección de Opciones:**
   - El script presentará un menú interactivo como el siguiente:

     ```text
     Selecciona una opción:
      1. Crear entorno virtual con una versión específica de Python
      2. Activar entorno virtual
      3. Instalar dependencias desde requirements.txt
      4. Visualizar dependencias de requirements.txt
      5. Ejecutar programa
      6. Desactivar entorno virtual
      7. Salir
     ```

   - Se deberán seleccionar las opciones de manera secuencial hasta llegar a la opción 5.

3. **Pasos Detallados:**

    1. **Crear entorno virtual con una versión específica de Python:**
       - Solicita al usuario que ingrese la versión de Python deseada.
       - Utiliza `python$python_version -m venv environment` para crear un entorno virtual llamado "environment" con la versión específica de Python proporcionada.
       - Muestra un mensaje indicando que el entorno virtual se creó con éxito.
    
    2. **Activar entorno virtual:**
       - Intenta activar el entorno virtual utilizando `source ./environment/bin/activate` o `. ./environment/bin/activate`.
       - Muestra un mensaje indicando que el entorno virtual se ha activado.
    
    3. **Instalar dependencias desde requirements.txt:**
       - Verifica si el entorno virtual está activado.
       - Si es así, utiliza `pip install -r requirements.txt` para instalar las dependencias del archivo `requirements.txt`.
       - Muestra un mensaje indicando que las dependencias se han instalado.
    
    4. **Visualizar dependencias de requirements.txt:**
       - Verifica si el entorno virtual está activado.
       - Si es así, utiliza `cat requirements.txt` para mostrar las dependencias listadas en el archivo `requirements.txt`.
    
    5. **Ejecutar programa:**
       - Utiliza `python3 ./source/app.py` para ejecutar el programa Flask.
       - El script asume que el punto de entrada del programa Flask es `app.py`.
       - Ahora podrá acceder a la aplicación desde 'localhost' o 'http://127.0.0.1:5000/'.
    
    7. **Desactivar entorno virtual:**
       - Utiliza `deactivate` para desactivar el entorno virtual.
       - Muestra un mensaje indicando que el entorno virtual se ha desactivado.
    
    8. **Salir:**
       - Muestra un mensaje indicando que el script está saliendo.
       - Finaliza la ejecución del script con `exit 0`.
