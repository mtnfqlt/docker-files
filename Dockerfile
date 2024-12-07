ARG from
FROM $from
ARG expose repo_url branch setup_list
EXPOSE $expose
WORKDIR /srv
COPY setup.sh ./
RUN ./setup.sh $repo_url $branch
ENTRYPOINT ["./start.sh"]
