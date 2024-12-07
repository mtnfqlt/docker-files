ARG from
FROM $from
ARG expose
EXPOSE $expose
WORKDIR /srv
COPY setup.sh ./
ARG repo_url branch setup_list
RUN ./setup.sh $repo_url $branch $setup_list
ENTRYPOINT ["./start.sh"]
