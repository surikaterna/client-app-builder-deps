FROM ubuntu:19.04

WORKDIR /usr/src/app

ARG NODE_VERSION="v10.16.3"
ARG NODE_ARCH="linux-x64"
ARG NODE_DIST_NAME="node-${NODE_VERSION}-${NODE_ARCH}"
ARG GRADLE_VERSION="5.6.2"
ARG ANDROID_SDK_BUILD_TOOL="19.1.0"
ARG JDK="8"

ENV PATH=/usr/src/app/tools:/usr/src/app/tools/bin/:${PATH}
ENV PATH=/usr/src/app/gradle-${GRADLE_VERSION}/bin/:${PATH}

# Update and install common/util packages.
RUN apt update
RUN apt install -y vim "openjdk-${JDK}-jdk" zip make

# Install Android SDK sdkmanager.
ADD https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip sdk-tools-linux.zip
RUN unzip sdk-tools-linux.zip
RUN yes | sdkmanager --licenses && \
    sdkmanager "build-tools;${ANDROID_SDK_BUILD_TOOL}"

# Gradle.
ADD https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip gradle-bin.zip
RUN unzip gradle-bin.zip

# Nodejs
ADD https://nodejs.org/dist/${NODE_VERSION}/${NODE_DIST_NAME}.tar.gz nodejs.tar.gz
RUN tar -xf nodejs.tar.gz
RUN mv "${NODE_DIST_NAME}" "/usr/local/lib/node" && \
    ln -s /usr/local/lib/node/bin/node /usr/local/bin/node && \
    ln -s /usr/local/lib/node/bin/npm /usr/local/bin/npm 

CMD tail -f /dev/null
