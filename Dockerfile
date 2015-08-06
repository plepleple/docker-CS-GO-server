FROM ubuntu:15.04
MAINTAINER Piotr "plepleple" Golan <piotr.golan@gmail.com>
# System update and upgrade:
RUN apt-get update && apt-get -y upgrade
# Install basic tools:
RUN apt-get -y install mc wget 
# Install SteamCMD dependences
RUN apt-get -y install lib32gcc1
# User
RUN groupadd steam
RUN useradd -m steam -g steam
RUN su - steam
# Make directories for SteamCMD
RUN mkdir /steamcmd
#RUN chown steam:steam /steamcmd
#RUN chmod 777 /steamcmd
RUN cd /steamcmd
# Download SteamCMD
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
RUN tar -xvzf steamcmd_linux.tar.gz -C /steamcmd
# Install SteamCMD and CS:GO server
RUN /steamcmd/steamcmd.sh +login anonymous +force_install_dir /steamcmd/csgoserver +app_update 740 validate +quit
