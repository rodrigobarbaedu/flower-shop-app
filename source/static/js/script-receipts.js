/**
 * @fileoverview Documento de JavaScript para products.html
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

    localStorage.removeItem("authenticatedUser");
    window.location.href = "../html/error.html";
  }
}

// Establecer un temporizador de 10 segundos para cerrar la sesión
setTimeout(function () {
  // Limpiar la sesión local y redirigir a la página de inicio de sesión
  localStorage.removeItem("authenticatedUser");
  window.location.href = "../html/index.html";
}, 999999999); // 10000 milisegundos = 10 segundos

// Cerrar sesión cuando se presiona el botón de cerrar sesión
function logout() {
  localStorage.removeItem("authenticatedUser");
  window.location.href = "../html/index.html";
}
*/
/* Verificación de inicio de sesión */

/* Gestión de productos */
/*
// Datos iniciales de productos (esto podría ser reemplazado por una base de datos real)
let products = [];

// Evento para el campo de precio del producto para evitar valores negativos
const productPrice = document.getElementById('product-price');
productPrice.addEventListener('change', function(event) {
  // Verificar si ingresas - (menos) en el campo de precio
  if (productPrice.value < 0) {
    alert('No se permiten valores negativos.');
    productPrice.value = 1;
  }
});

// Función para cargar los productos almacenados en el almacenamiento local
function loadProductsFromLocalStorage() {
  const storedProducts = localStorage.getItem("products");
  if (storedProducts) {
    products = JSON.parse(storedProducts);
  }
}

// Función para guardar los productos en el almacenamiento local
function saveProductsToLocalStorage() {
  localStorage.setItem("products", JSON.stringify(products));
}

// Función para guardar o actualizar un producto
function saveProduct() {
  const productForm = document.getElementById("product-form");
  const productId = document.getElementById("product-id").value;
  const productName = document.getElementById("product-name").value;
  const productDescription = document.getElementById(
    "product-description"
  ).value;
  const productPrice = document.getElementById("product-price").value;
  const productImageUrl = document.getElementById("product-image-url").value;

  if (productName && productDescription && productPrice && productImageUrl) {
    if (productId) {
      // Actualizar un producto existente
      const productIndex = products.findIndex(
        (product) => product.id === productId
      );
      if (productIndex !== -1) {
        products[productIndex] = {
          id: productId,
          name: productName,
          description: productDescription,
          price: productPrice,
          imageUrl: productImageUrl,
        };
      }
    } else {
      // Crear un nuevo producto
      const newProduct = {
        id: new Date().getTime().toString(),
        name: productName,
        description: productDescription,
        price: productPrice,
        imageUrl: productImageUrl,
      };
      products.push(newProduct);
    }
  } else {
    alert("Todos los campos son obligatorios");
  }

  // Limpia el formulario
  productForm.reset();

  // Actualiza la lista de productos
  displayProducts();

  // Después de guardar o actualizar, guarda los productos en el almacenamiento local
  saveProductsToLocalStorage();
}

// Función para editar un producto
function editProduct(productId) {
  const product = products.find((product) => product.id === productId);
  if (product) {
    document.getElementById("product-id").value = product.id;
    document.getElementById("product-name").value = product.name;
    document.getElementById("product-description").value = product.description;
    document.getElementById("product-price").value = product.price;
    document.getElementById("product-image-url").value = product.imageUrl;
  }
}

// Función para eliminar un producto
function deleteProduct(productId) {
  products = products.filter((product) => product.id !== productId);
  displayProducts();

  // Después de eliminar, guarda los productos en el almacenamiento local
  saveProductsToLocalStorage();
}

// Función para cargar la lista de productos
function displayProducts() {
  const productList = document.getElementById("product-list");
  productList.innerHTML = "";
  products.forEach((product) => {
    const row = document.createElement("tr");
    row.innerHTML = `
      <td>${product.id}</td>
      <td>${product.name}</td>
      <td>${product.description}</td>
      <td>${product.price}</td>
      <td><img src="${product.imageUrl}" alt="${product.name}" width="100"></td>
      <td>
        <button class="btn btn-success" onclick="editProduct('${product.id}')">Actualizar</button>
        <button class="btn btn-danger" onclick="deleteProduct('${product.id}')">Eliminar</button>
      </td>
    `;
    productList.appendChild(row);
  });
}

// Cargar los productos almacenados al cargar la página
loadProductsFromLocalStorage();
displayProducts();
*/

$(document).ready(function() {
    $('#product-table').DataTable({
      "paging": true,        // Habilita la paginación
      "searching": true,     // Habilita la búsqueda
      "pageLength": 8,       // Se muestran 3 filas por página
      "lengthMenu": [3, 6, 9, 12], // Se puede elegir mostrar 3, 6, 9 o 12 filas por página
    });
});