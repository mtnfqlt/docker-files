ARG image
FROM $image
ARG ports repo_url branch setup_role_list pre_setup_script post_setup_script
EXPOSE $ports
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$ports" "$repo_url" "$branch" "$setup_role_list" "$pre_setup_script" "$post_setup_script"
ENTRYPOINT ["./start.sh"]
