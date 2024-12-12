ARG image
FROM $image
ARG port_list main_init setup_list
EXPOSE $expose
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$setup_list"
ENV MAIN_INIT=$main_init
CMD ["./init.sh"]
