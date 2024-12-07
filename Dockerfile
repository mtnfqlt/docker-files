ARG from
FROM $from

ARG expose
EXPOSE $expose
WORKDIR /srv
COPY setup.sh ./
RUN ./setup.sh
ENTRYPOINT ["./start.sh"]
