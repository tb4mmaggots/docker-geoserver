FROM tomcat:8.5-alpine

ARG GS_VERSION

#Download geoserver & required plugins
#RUN curl -Ls -o /tmp/geoserver.zip $GS_URL \
#    && curl -Ls -o /tmp/geofence.zip $GS_GF_PROBE_URL \
#    && curl -Ls -o /tmp/cas.zip $GS_CAS_URL

#Repackage geoserver with requirements
#RUN unzip /tmp/geoserver.zip geoserver.war -d /tmp/ \
#    && mkdir /tmp/geoserver && mkdir /tmp/geofence && mkdir /tmp/cas \
#    && unzip /tmp/geoserver.war -d /tmp/geoserver/ \
#    && unzip /tmp/geofence.zip -d /tmp/geofence/ \
#    && unzip /tmp/cas.zip -d /tmp/cas/ \
#    && mv /tmp/geofence/*.jar /tmp/geoserver/WEB-INF/lib/ \
#    && mv /tmp/cas/*.jar /tmp/geoserver/WEB-INF/lib/ \
#    && cd /tmp/geoserver && zip -rv /usr/local/tomcat/webapps/geoserver.war .

#GS_URL: http://sourceforge.net/projects/geoserver/files/GeoServer/2.8.3/geoserver-2.8.3-war.zip
#        GS_GF_PROBE_URL: http://ares.boundlessgeo.com/geoserver/2.8.x/community-latest/geoserver-2.8-SNAPSHOT-geofence-plugin.zip
#        GS_CAS_URL: https://sourceforge.net/projects/geoserver/files/GeoServer/2.8.3/extensions/geoserver-2.8.3-cas-plugin.zip/download

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

