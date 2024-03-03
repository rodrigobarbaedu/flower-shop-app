/* Rodrigo Barba - Shinia */

/**
 * @fileoverview Documento de JavaScript para dashboard.html
 */

/* Verificación de inicio de sesión */
/*
var authenticatedUser = localStorage.getItem("authenticatedUser");

if (!authenticatedUser) {
    // El usuario no ha iniciado sesión, redirige a la página de error
    window.location.href = "../html/error.html";
} else {
    if (authenticatedUser === "rodrigobarba") {
        var element = document.getElementsByClassName("admin-link");
        for (var i = 0; i < element.length; i++) {
            element[i].style.display = "none";
        }
    }
}

// Establecer un temporizador de 10 segundos para cerrar la sesión
setTimeout(function () {
    // Limpiar la sesión local y redirigir a la página de inicio de sesión
    localStorage.removeItem("authenticatedUser");
    window.location.href = "../html/index.html";
}, 10); // 10000 milisegundos = 10 segundos

// Cerrar sesión cuando se presiona el botón de cerrar sesión
function logout() {
    localStorage.removeItem("authenticatedUser");
    window.location.href = "../html/index.html";
}
*/