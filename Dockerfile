FROM ubuntu
MAINTAINER Piotr "plepleple" Golan <piotr.golan@gmail.com>
# System update and upgrade:
RUN apt-get -y update && apt-get -y upgrade
# Install basic tools:
RUN apt-get -y install mc wget screen openssh-server
# create user steamadmin:steamadmin
RUN groupadd steamadmin
RUN useradd -m steamadmin -p steamadmin -g steamadmin
# Install SteamCMD dependences
RUN apt-get -y install lib32gcc1
# Make directories for SteamCMD
RUN mkdir /steamcmd
RUN cd /steamcmd
# Download and extract SteamCMD
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
RUN tar -xvzf steamcmd_linux.tar.gz -C /steamcmd
# Install SteamCMD and CS:GO server
RUN /steamcmd/steamcmd.sh +login anonymous +force_install_dir /steamcmd/csgoserver +app_update 740 validate +quit
# Folder privilages
RUN chown -R steamadmin:steamadmin /steamcmd
RUN chmod -R 775 /steamcmd
