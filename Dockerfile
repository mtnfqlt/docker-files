ARG image
FROM $image
ARG port_list rctl_port=54321 main_init setup_list
EXPOSE $expose $rctl_port
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$setup_list"
ENV RCTL_PORT=$rctl_port MAIN_INIT=$main_init
CMD ["./init.sh"]
