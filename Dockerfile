#FROM sebp/lighttpd
#FROM httpd:alpine
FROM openjdk:8-jdk
LABEL maintainer="Wu Yuntao <wu-yuntao@qq.com>"


ENV ANDROID_COMPILE_SDK=28
ENV ANDROID_BUILD_TOOLS=28.0.2
ENV ANDROID_SDK_TOOLS=4333796
ENV ANDROID_HOME=/android-sdk-linux

RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1
RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
RUN unzip -d android-sdk-linux android-sdk.zip
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null
RUN export PATH=$PATH:$ANDROID_HOME/platform-tools/
#RUN chmod +x ./gradlew
# temporarily disable checking for EPIPE error and use yes to accept all licenses
#RUN set +o pipefail
RUN yes | android-sdk-linux/tools/bin/sdkmanager --licenses
#RUN set -o pipefail

#RUN apk add --update --no-cache git openssh-client && rm -rf /var/cache/apk/*
#RUN mkdir ~/.ssh
#RUN chmod 700 ~/.ssh
#RUN git config --global user.name CIUser 
#RUN git config --global user.email cnhefang@gmail.com 
#
#COPY ./data/id_rsa* /root/.ssh/
#RUN chmod 600 ~/.ssh/*
#
#COPY ./data/start2.sh /usr/local/bin/
#COPY ./data/index.html /usr/local/apache2/htdocs/
#
#CMD ["start2.sh"]

CMD ["bash"]
