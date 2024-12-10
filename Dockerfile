ARG image
FROM $image
ARG port_list setup_list main_ps
EXPOSE 54321 $port_list
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$setup_list"
ENV CTL_PORT=54321 MAIN_PS=apache2-foreground
CMD ["./init.sh", $CTL_PORT, $MAIN_PS]
