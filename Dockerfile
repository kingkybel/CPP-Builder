ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION} as builder
ARG CPP_VERSION

# Install necessary libraries for running the application
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y  g++-${CPP_VERSION}
RUN apt-get install -y \
    wget \
    curl \
    make \
    cmake \
    libpqxx-dev \
    libboost-all-dev \
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
    vtk9
ENV DEBIAN_FRONTEND=dialog

# Set the working directory in the container to /app
WORKDIR /app
RUN mkdir build
WORKDIR /app/build
