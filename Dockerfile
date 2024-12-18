ARG image
FROM $image
ARG expose
EXPOSE $expose
WORKDIR /srv
COPY ./ ./
ARG main_init
ENV MAIN_INIT=$main_init
ARG setup_list
RUN ./setup.sh "$setup_list"
CMD ["./init.sh"]
