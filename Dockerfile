ARG image
FROM $image
ARG port_list setup_list
EXPOSE $port_list
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$setup_list"
CMD ["./init.sh", 54321, apache2-foreground]

# ENV CTL_PORT=54321 MAIN_PS=apache2-foreground
# CMD ["./init.sh", $CTL_PORT, $MAIN_PS]
