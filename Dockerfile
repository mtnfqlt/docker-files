ARG image
FROM $image
ARG port_list
EXPOSE $port_list
WORKDIR /srv
ADD ./ ./
COPY --from=resources /local/path /container/path
RUN ./setup.sh
ENTRYPOINT ["./start.sh"]
