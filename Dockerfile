ARG image
FROM $image
ARG port_list repo_url branch setup_role_list pre_setup_script post_setup_script php_mod_list
EXPOSE $port_list
WORKDIR /srv
ADD ./ ./
RUN ./setup.sh "$port_list" "$repo_url" "$branch" "$setup_role_list" "$pre_setup_script" "$post_setup_script" "$php_mod_list"
ENTRYPOINT ["./entrypint.sh"]
