$(document).ready(function() {
    $('#product-table').DataTable({
        "paging": true,        // Habilita la paginación
        "searching": true,     // Habilita la búsqueda
        "pageLength": 5,       // Se muestran 5 filas por página
        "lengthMenu": [5, 10, 15, 25], // Se puede elegir mostrar 5, 10, 15 o 25 filas por página
        "language": {          // Se configura el idioma del plugin
            "url": "//cdn.datatables.net/plug-ins/1.10.16/i18n/Spanish.json"
        },
        "ordering": true,      // Habilita la ordenación
        "info": true,          // Muestra información sobre la paginación
        "lengthChange": true   // Permite cambiar el número de elementos mostrados por página
    });
  });