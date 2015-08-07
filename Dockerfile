FROM ubuntu:15.04
MAINTAINER Piotr "plepleple" Golan <piotr.golan@gmail.com>
# System update and upgrade:
RUN apt-get update && apt-get -y upgrade
# Install basic tools:
RUN apt-get -y install mc wget screen openssh-server
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
# Run basic server
screen -d -m /steamcmd/csgoserver/srcds_run -game csgo -console -usercon +game_type 1 +game_mode 2 +mapgroup mg_allclassic +map de_dust2
