ARG image
FROM $image
ARG port_list setup_list
EXPOSE $port_list
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$setup_list"
ENTRYPOINT ["./init.sh"]
