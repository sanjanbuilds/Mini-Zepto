let allProducts = [];

async function fetchProducts(){

    const response = await fetch(

        "http://127.0.0.1:5000/products"

    );

    const data = await response.json();

    allProducts = data;

    displayProducts(data);

}

function displayProducts(products){

    const productsDiv =
    document.getElementById("products");

    productsDiv.innerHTML = "";

    products.forEach(product => {

        productsDiv.innerHTML += `

        <div class="card">

            <div class="category">
                ${product.category}
            </div>

            <div class="name">
                ${product.name}
            </div>

            <div class="price">
                ₹${product.discountedSellingPrice}
            </div>

            <div class="mrp">
                ₹${product.mrp}
            </div>

            <div class="discount">
                ${product.discountPercent}% OFF
            </div>

            <button>
                Add to Cart
            </button>

        </div>

        `;

    });

}

document
.getElementById("search")

.addEventListener("input", function(){

    const value =
    this.value.toLowerCase();

    const filtered =
    allProducts.filter(product =>

        product.name
        .toLowerCase()
        .includes(value)

    );

    displayProducts(filtered);

});

fetchProducts();