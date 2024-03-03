/**
 * @fileoverview Documento de JavaScript para users.html
 */

$(document).ready(function() {
    $('#users-table').DataTable({
        "paging": true,        // Habilita la paginación
        "searching": true,     // Habilita la búsqueda
        "pageLength": 3,       // Se muestran 3 filas por página
        "lengthMenu": [3, 6, 9, 12], // Se puede elegir mostrar 3, 6, 9 o 12 filas por página
        "language": {          // Se configura el idioma del plugin
            "url": "//cdn.datatables.net/plug-ins/1.10.16/i18n/Spanish.json"
        },
        "scrollX": "200px",
        "ordering": true,      // Habilita la ordenación
        "info": true,          // Muestra información sobre la paginación
        "lengthChange": true   // Permite cambiar el número de elementos mostrados por página
    });
});