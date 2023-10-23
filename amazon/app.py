from flask import Flask, redirect
import os

app = Flask(__name__)

# Obtén el enlace de afiliados de las variables de entorno
affiliate_link = os.getenv('AMAZON_AFFILIATE_LINK', 'https://www.amazon.es')

@app.route('/')
def index():
    # Redirige a tu enlace de afiliados de Amazon
    return redirect(affiliate_link, code=301)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8081)

