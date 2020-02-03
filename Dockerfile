FROM archlinux

# Setup user
RUN useradd --create-home --shell /bin/bash rothaq
USER rothaq
WORKDIR /home/rothaq/desktop

# Copy all the scripts/repo content
COPY . /home/rothaq/desktop

# Run the deploy script / ansible (submodules pull, pacman install, etc)
# Run the verify script (check some submodules are pulled, some scripts are linked, some directories are linked)
CMD ["echo", "'Running the deploy and verify script'"]
