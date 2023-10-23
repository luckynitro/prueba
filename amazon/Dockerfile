# Utiliza una imagen de Python como base
FROM python:3.8-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos necesarios al contenedor
COPY requirements.txt .
COPY app.py .

# Instala las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Exponer el puerto en el que tu aplicación Flask estará escuchando
EXPOSE 5000

# Configurar las variables de entorno para el enlace de afiliados de Amazon
ENV AMAZON_AFFILIATE_LINK https://www.amazon.es?&linkCode=ll2&tag=lucky0d40-21&

# Comando para ejecutar tu aplicación
CMD ["python", "app.py"]




