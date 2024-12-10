ARG image
FROM $image
ARG port_list setup_list
EXPOSE $port_list
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$setup_list"
ENV CTL_PORT=$APP_DEBUG
ENV MAIN_PS=$MAIN_PS
ENTRYPOINT ["./init.sh"]
