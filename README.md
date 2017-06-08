# docker-geoserver

### Description
[GeoServer](http://geoserver.org/) container build with required plugins to work with official [GeoFence](https://github.com/geoserver/geofence) repo.

### Dependencies
- [Docker](https://www.docker.com/)
- [Optional] [Docker Compose](https://docs.docker.com/compose/)

### Build
1. Clone repo `$ git clone https://github.com/tb4mmaggots/docker-geoserver.git`
2. Go to cloned directory `$ cd docker-geoserver`
3. Build container

   `$ docker build -t geoserver:2.11.1` 
   
   OR 
   
   `$ docker-compose build`

### Run
`$ docker run -d --name geoserver -p 8080:8080 -v $(pwd)/data:/usr/local/tomcat/webapps/geoserver/data geoserver:2.11.1` 

OR 

`$ docker-compose up -d`

### Automated Build

`$ docker pull tb4mmaggots/geoserver`
