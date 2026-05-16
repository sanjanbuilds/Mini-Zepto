from flask import Flask, jsonify
from flask_cors import CORS
import pymysql

app = Flask(__name__)

CORS(app)

# MYSQL CONNECTION

connection = pymysql.connect(

    host='localhost',

    user='root',

    password='123456',

    database='zepto_db'

)

# GET ALL PRODUCTS

@app.route('/products')

def get_products():

    cursor = connection.cursor()

    query = "SELECT * FROM products"

    cursor.execute(query)

    rows = cursor.fetchall()

    products = []

    for row in rows:

        products.append({

            "product_id": row[0],
            "name": row[1],
            "category": row[2],
            "mrp": row[3],
            "discountPercent": row[4],
            "availableQuantity": row[5],
            "discountedSellingPrice": row[6],
            "weightInGms": row[7],
            "outOfStock": row[8],
            "quantity": row[9]

        })

    return jsonify(products)

# GET CART ITEMS

@app.route('/cart')

def get_cart():

    cursor = connection.cursor()

    query = """

    SELECT

    cart.cart_id,
    products.name,
    products.discountedSellingPrice,
    cart.quantity

    FROM cart

    JOIN products

    ON cart.product_id = products.product_id

    """

    cursor.execute(query)

    rows = cursor.fetchall()

    cart_items = []

    for row in rows:

        cart_items.append({

            "cart_id": row[0],
            "name": row[1],
            "price": row[2],
            "quantity": row[3]

        })

    return jsonify(cart_items)

# GET ORDERS

@app.route('/orders')

def get_orders():

    cursor = connection.cursor()

    query = "SELECT * FROM orders"

    cursor.execute(query)

    rows = cursor.fetchall()

    orders = []

    for row in rows:

        orders.append({

            "order_id": row[0],
            "user_id": row[1],
            "total_amount": row[2],
            "order_date": str(row[3])

        })

    return jsonify(orders)

# START SERVER

app.run(debug=True)