ARG image
FROM $image
ARG port_list ctl_port=54321 main_ps setup_list CTL_PORT MAIN_PS
EXPOSE $port_list $ctl_port
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$setup_list"
ENV CTL_PORT=$ctl_port MAIN_PS=$main_ps
ENTRYPOINT ["./init.sh"]
