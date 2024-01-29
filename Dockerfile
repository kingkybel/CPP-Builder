ARG UBUNTU_VERSION=23
FROM ubuntu:${UBUNTU_VERSION} as builder
ARG CPP_VERSION=13
ARG BOOST_VERSION=1.84.0
ARG BOOST_VERSION_UDRSCR=1_84_0

# Install necessary libraries for running the application
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y \
    wget \
    curl \
    make \
    cmake \
    g++-${CPP_VERSION} \
    libpqxx-dev \
    libwebsocketpp-dev \
    libssl-dev \
    xorg-dev \
    libx11-dev \
    libglu1-mesa-dev \
    freeglut3-dev \
    libglew2.2 \
    libglew-dev \
    libglu1-mesa \
    libgl1-mesa-glx \
    libgl1-mesa-dev \
    libglfw3-dev \
    libglfw3 \
    libomp-dev \
    libfftw3-dev \
    pulseaudio \
    libasound-dev \
    portaudio19-dev \
    libpulse-dev \
    libfftw3-dev \
    libpostproc-dev \
    libavdevice-dev \
    libportaudio2 \
    libqt5concurrent5 \
    libqt5opengl5 \
    iputils-ping \
    libgrpc-dev \
    libvtk9-dev \
    python3-vtk9 \
    qtcreator \
    qtbase5-dev \
    qt5-qmake \
    vtk9 \
    libgmp3-dev \
    libmpfr-dev \
    libgtest-dev

ENV DEBIAN_FRONTEND=dialog

RUN update-alternatives \
    --install /usr/bin/g++ g++ /usr/bin/g++-${CPP_VERSION} 100

RUN wget https://boostorg.jfrog.io/artifactory/main/release/${BOOST_VERSION}/source/boost_${BOOST_VERSION_UDRSCR}.tar.gz ; \
    tar -xf boost_${BOOST_VERSION_UDRSCR}.tar.gz ; \
    cd boost_${BOOST_VERSION_UDRSCR} ; \
    ./bootstrap.sh ; \
    ./b2 link=static install ; \
    cd .. ; \
    rm -rf boost_${BOOST_VERSION_UDRSCR}.tar.gz boost_${BOOST_VERSION_UDRSCR} ;

# Set the working directory in the container to /app
RUN mkdir -p /app/sh
COPY do_build /app/sh
WORKDIR /app/sh
RUN chmod +x /app/sh/do_build
ENTRYPOINT [ "./do_build" ]
