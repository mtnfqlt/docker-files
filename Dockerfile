FROM debian:bookworm-slim
EXPOSE 22
WORKDIR /srv
ADD ./ ./
RUN ./build.sh
ENTRYPOINT ["./start.sh"]
