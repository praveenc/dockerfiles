# Hosting Gitea on an External Drive (Hard Disk, Thumbdrive , SD Card etc)

## Pre-requisites (Mac)

- Install Docker Desktop Community for mac (with docker-compose)
  - Engine: 18.09.2
  - Compose: 1.23.2
  - Machine: 0.16.1
  - Notary: 0.6.1
  - Credential Helper: 0.60
  - Kubernetes: v1.10.11
- `Gitea 1.15.7` version (Dec 2021)
- `Postgres 11` docker image
  - `docker pull postgres:11`
  - We use the full version of `postgres` instead of the alpine image `postgres:11.2-alpine` as the alpine version doesn't include `pg_dump` for backing up the database
- Mount the Volume and create `gitea` data folders on the mounted volume For e.g. on macOS, external drives are automatically mounted to `/Volumes/{DRIVE_NAME}/`, if you are using a new external drive then create a folder named `gitea` and sub-folders named `data` and `postgres`. The `data` folder will store all `git` repo info and `postgres` will store all `postgresql` related data. This new mounted Volume will now act as a persistent data volume for your self-hosted git server

## Installation Instructions

- Edit [docker-compose.yml](docker-compose.yml) and modify the following sections to match your Volume path

  - Under `services` -> `server` -> `volumes` modify path before `:/data`

    ```(yaml)
    volumes:
      - '/VolumePath/to/gitea/data/:/data'
    ```

  - Under `services` -> `db` -> `volumes` modify path before `:/var/lib/postgresql/data`

    ```(yaml)
    volumes:
      - '/VolumePath/to/gitea/postgres/:/var/lib/postgresql/data'
    ```

- Save [docker-compose.yml](docker-compose.yml)

- Run `docker-compose` from the current directory

   ```(shell)
   docker-compose up -d
   ```

## Configuring Gitea the first time

- After `docker-compose up -d` from the previous step, `gitea` site should now be available at [http://localhost:3000](http://localhost:3000)
- Click on `Register`, this should take you to the `Gitea Setup` screen
- leave all values as is, at the bottom of the screen expand `Administrator Settings` and choose a `username` and `password` for an admin user. This user will become the administrator for managing all aspects of `gitea`
- click on `Install Gitea` button at the bottom of the screen
- This completes installation and logs you in with the `admin` user created above. At this stage, you can create a separate user(s) if you'd like.
- You can now create git repositories by clicking on the `+` sign in the UI

## Shutting Down Gitea git server

- `cd` into this folder containing `docker-compose.yml` and then

    ```(shell)
    docker-compose down
    ```

## Notes

- Repos can be cloned and subsequently pushed using the following url `http://localhost:3000/{user_name}/{repo_name.git}`
- SSH/GPG Keys can be set from the settings page `http://localhost:3000/user/settings/keys`
- Refer to [Gitea Docs](https://github.com/go-gitea/) for more information
