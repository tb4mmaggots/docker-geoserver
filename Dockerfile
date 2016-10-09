FROM tomcat:8.5-alpine

ARG GS_VERSION

RUN export GS_MAJOR=$(echo ${GS_VERSION} | awk -F "." '{print $1"."$2}') \
    && mkdir /tmp/geoserver/ /tmp/geoserver/geofence/ /tmp/geoserver/cas/ \
    && wget -c http://downloads.sourceforge.net/project/geoserver/GeoServer/${GS_VERSION}/geoserver-${GS_VERSION}-war.zip -O /tmp/geoserver/geoserver.zip \
    && wget -c http://downloads.sourceforge.net/project/geoserver/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-cas-plugin.zip -O /tmp/geoserver/cas/cas.zip \
    && wget -c http://ares.boundlessgeo.com/geoserver/$GS_MAJOR.x/community-latest/geoserver-${GS_MAJOR}-SNAPSHOT-geofence-plugin.zip -O /tmp/geoserver/geofence/geofence.zip \
    && unzip /tmp/geoserver/geoserver.zip -d /tmp/geoserver \
    && unzip /tmp/geoserver/geofence/geofence.zip -d /tmp/geoserver/geofence \
    && unzip /tmp/geoserver/cas/cas.zip -d /tmp/geoserver/cas \
    && mkdir $CATALINA_HOME/webapps/geoserver \
    && unzip /tmp/geoserver/geoserver.war -d $CATALINA_HOME/webapps/geoserver \
    && unzip /tmp/geoserver/cas/cas.zip -d $CATALINA_HOME/webapps/geoserver/WEB-INF/lib/ \
    && unzip /tmp/geoserver/geofence/geofence.zip -d $CATALINA_HOME/webapps/geoserver/WEB-INF/lib/ \
    && rm -rf $CATALINA_HOME/webapps/geoserver/data \
    && rm -rf /tmp/geoserver
