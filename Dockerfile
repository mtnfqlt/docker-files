#ARG from
FROM $from
ARG from expose
EXPOSE $expose
WORKDIR /srv
COPY setup.sh ./
RUN ./setup.sh
ENTRYPOINT ["./start.sh"]
