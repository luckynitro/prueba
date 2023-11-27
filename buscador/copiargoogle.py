import requests
from bs4 import BeautifulSoup

def buscar_resultados(termino):
    url = f'https://www.google.com/search?q={termino}'
    response = requests.get(url)

    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        resultados = soup.find_all('h3', class_='t')  # Ajusta según la estructura de la página de resultados

        # Puedes imprimir los resultados o devolverlos como una lista, según tus necesidades
        for resultado in resultados:
            print(resultado.text)

# Ejemplo de uso
buscar_resultados('Python web scraping')

