ARG from
FROM $from
ARG expose repo_url branch setup_list pre_setup_script post_setup_script
EXPOSE $expose
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$expose" "$repo_url" "$branch" "$setup_list" "$pre_setup_script" "$post_setup_script"
ENTRYPOINT ["./start.sh"]
