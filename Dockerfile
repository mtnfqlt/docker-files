ARG image
FROM $image
ARG ctl_port=54321 port_list setup_list main_ps
EXPOSE $ctl_port $port_list
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$setup_list"
CMD ["./init.sh", "$ctl_port", "$main_ps"]
