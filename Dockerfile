ARG image
FROM $image
ARG port_list en_rctl rctl_port=54321 command setup_list
EXPOSE $expose $rctl_port
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$setup_list"
ENV EN_RCTL=$en_rctl RCTL_PORT=$rctl_port CMD=$command
ENTRYPOINT ["./init.sh"]
