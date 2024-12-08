ARG image
FROM $image
ARG ports repo_url branch setup_role_list pre_setup_script post_setup_script
EXPOSE $port_list
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$port_list" "$repo_url" "$branch" "$setup_role_list" "$pre_setup_script" "$post_setup_script"
ENTRYPOINT ["./start.sh"]
