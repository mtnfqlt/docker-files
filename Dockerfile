ARG from expose
FROM debian:bookworm-slim
EXPOSE 22
RUN echo $from
RUN echo $expose
#WORKDIR /srv
#COPY setup.sh ./
#RUN ./setup.sh
#ENTRYPOINT ["./start.sh"]
