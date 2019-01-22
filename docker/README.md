## Build

```
    sudo docker build -t werice .
```

## Run

```
    sudo docker run        \
        --name werice      \
        --hostname werice  \
        --publish 22222:22 \
        --workdir /home/an9wer \
        --mount type=bind,source=$(pwd)/..,target=/home/an9wer/werice \
        -it werice /bin/bash
```
