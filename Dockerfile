ARG image
FROM $image
ARG port repo_url branch setup_role_list pre_setup_script post_setup_script
EXPOSE $port
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$port" "$repo_url" "$branch" "$setup_role_list" "$pre_setup_script" "$post_setup_script"
ENTRYPOINT ["./up.sh"]
