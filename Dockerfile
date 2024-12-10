ARG image
FROM $image
ARG port_list setup_list CTL_PORT MAIN_PS
EXPOSE $port_list
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$setup_list"
ENV CTL_PORT=$CTL_PORT
ENV MAIN_PS=$MAIN_PS
ENTRYPOINT ["./init.sh"]
