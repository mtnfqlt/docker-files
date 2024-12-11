ARG image
FROM $image
ARG port_list ctl_port=54321 main_ps setup_list
EXPOSE $expose $ctl_port
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$setup_list"
ENV CTL_PORT=$ctl_port CMD=$command
ENTRYPOINT ["./init.sh"]
