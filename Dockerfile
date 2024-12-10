ARG image
FROM $image
ARG port_list setup_list
EXPOSE 54321 $port_list
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$setup_list"
ARG main_ps=apache2-foreground
ENV MAIN_PS=${main_ps}
CMD ["./init.sh", "54321", "${MAIN_PS}"]

# ENV CTL_PORT=54321 MAIN_PS=apache2-foreground
# CMD ["./init.sh", $CTL_PORT, $MAIN_PS]
