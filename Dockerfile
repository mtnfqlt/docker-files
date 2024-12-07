ARG from
FROM $from
ARG expose
RUN echo "Base image: $from" && echo "Exposed port: $expose"

#FROM debian:bookworm-slim
#EXPOSE 22
#WORKDIR /srv
#COPY setup.sh ./
#RUN ./setup.sh
#ENTRYPOINT ["./start.sh"]
