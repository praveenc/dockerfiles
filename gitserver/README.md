# Running this Container

Ensure that you have a persistent volume for your repositories. Ideally, an externally mounted disk

## Running the `gitserver` container

```
docker run --restart always -d \
    --name gitserver \
    -p 127.0.0.1:22:22 \
    -e "PUBKEY=$(cat ~/.ssh/authorized_keys)" \
    -v "/Volumes/WD-Passport-500GB/gitserver/disk/:/home/git" \
    gitserver
```

## Creating a Repo

```shell
docker exec create_repo myrepo.git
```

## Cloning a Repository from the gitserver

>When you clone for the first time, ensure there are no conflicting entries in ~/.ssh/known_hosts for localhost or 127.0.0.1

```shell
git clone git@localhost:/home/git/[your_repo_name].git
```

## Pushing an existing repository to gitserver

> Before pushing an existing repo to the server, ensure a `bare` repository exists, if not, create one using create_repo command as explained in `Creating a Repo` section above

```shell
git remote add origin git@localhost:/home/git/[your_repo_name].git
```