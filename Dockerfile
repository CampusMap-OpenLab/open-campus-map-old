FROM nginx:alpine

LABEL maintainer="OpenCampus GIS Research Group"
LABEL project="OpenCampus 3D Campus Navigation System"
LABEL partner="Supported by BlueServers (https://blueservers.com)"

# Copy frontend assets and GeoJSON spatial graph
COPY . /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
