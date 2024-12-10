ARG image
FROM $image
ARG port_list setup_list
EXPOSE $port_list
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$setup_list"
ENV CTL_PORT=54321
ENV MAIN_PS=apache2-foreground
ENTRYPOINT ["./init.sh"]
