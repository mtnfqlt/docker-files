ARG image
FROM $image
ARG port_list setup_args
EXPOSE $port_list
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$setup_args"
ENTRYPOINT ["./start.sh"]
