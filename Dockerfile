FROM mdavi/java8:8u25
MAINTAINER mardavi84@gmail.com

RUN apt-get update && \
	apt-get install -y unzip libgtk2.0-0 libcanberra-gtk-module libxext-dev libxrender-dev libxtst-dev && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /tmp/*

RUN wget http://doc.ccw-ide.org/products/Counterclockwise-0.31.1.STABLE001-linux.gtk.x86_64.zip -O /tmp/Counterclockwise.zip -q

ADD conf /tmp/conf
ADD scripts /scripts
RUN chmod a+x /scripts/*.sh

RUN echo 'Installing Counterclockwise' && \
	unzip /tmp/Counterclockwise.zip -d /opt && \
	mkdir -p /opt/counterclockwise-0.31.1.STABLE001/configuration/.settings && \
	cp -a /tmp/conf/org.eclipse.ui.ide.prefs /opt/counterclockwise-0.31.1.STABLE001/configuration/.settings/org.eclipse.ui.ide.prefs && \
	cp -a /tmp/conf/config.ini /opt/counterclockwise-0.31.1.STABLE001/configuration/config.ini && \
	rm -rf /tmp/*

RUN mkdir -p /home/developer && \
	echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
	echo "developer:x:1000:" >> /etc/group && \
	echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
	chmod 0440 /etc/sudoers.d/developer && \
	chown developer:developer -R /home/developer && \
	chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo

USER developer
ENV HOME /home/developer
WORKDIR /home/developer
CMD /scripts/clojure.sh
