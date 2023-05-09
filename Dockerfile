############################################################
# Dockerfile that builds an OHD Gameserver
############################################################
FROM cm2network/steamcmd:root

LABEL maintainer="test@test.com"

ENV STEAMAPPID 950900
ENV STEAMAPP ohd
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

# ENV STEAM_BETA_APP 774961
# ENV STEAM_BETA_PASSWORD ""
# ENV STEAM_BETA_BRANCH ""

ENV WORKSHOPID 736590
ENV MODPATH "${STEAMAPPDIR}/HarshDoorstop/Content/Mods"
ENV MODS "()"

COPY etc/entry.sh ${HOMEDIR}

RUN set -x \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& mkdir -p "${STEAMAPPDIR}/HarshDoorstop/Content/Mods" \
	&& chmod 755 "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" "${STEAMAPPDIR}/HarshDoorstop/Content/Mods" \
	&& chown "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" "${STEAMAPPDIR}/HarshDoorstop/Content/Mods"

ENV Port=7777 \
	QueryPort=27005 \
	RCONPort=7779 \
	MaxPlayers=80

# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

# Expose ports
EXPOSE 7777/udp \
	27005/tcp \
	27005/udp \
	7779/tcp \
	7779/udp
