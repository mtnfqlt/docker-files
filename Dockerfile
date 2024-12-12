ARG image
FROM $image
ARG expose main_init setup_list
ENV MAIN_INIT=$main_init
EXPOSE $expose
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$setup_list"
CMD ["./init.sh"]
