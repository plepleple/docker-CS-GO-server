FROM ubuntu:15.04
MAINTAINER Piotr "plepleple" Golan <piotr.golan@gmail.com>
# System update and upgrade:
RUN apt-get update && apt-get -y upgrade
# Install basic tools:
RUN apt-get -y install mc wget screen openssh-server
# create user steamadmin:steamadmin and start SSH service
RUN groupadd steamadmin
RUN useradd -m steamadmin -p steamadmin -g steamadmin
RUN service ssh start
# Install SteamCMD dependences
RUN apt-get -y install lib32gcc1
# Make directories for SteamCMD
RUN mkdir /steamcmd
RUN chown steamadmin:steamadmin /steamcmd
RUN chmod 775 /steamcmd
RUN su - steamadmin
RUN cd /steamcmd
# Download and extract SteamCMD
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
RUN tar -xvzf steamcmd_linux.tar.gz -C /steamcmd
# Install SteamCMD and CS:GO server
RUN /steamcmd/steamcmd.sh +login anonymous +force_install_dir /steamcmd/csgoserver +app_update 740 validate +quit
# Run basic server
RUN screen -d -m /steamcmd/csgoserver/srcds_run -game csgo -console -usercon +game_type 1 +game_mode 2 +mapgroup mg_allclassic +map de_dust2
