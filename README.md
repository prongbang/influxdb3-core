# influxdb3-core

## Create Token

```sh
microk8s kubectl get pods -n <ns>
microk8s kubectl -n <ns> exec -it influxdb3-core-0 -- influxdb3 create token --admin
```
