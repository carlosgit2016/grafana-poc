### Outcomes v1
- Have prometheus stack deployed in the cluster
- Prometheus is scraping basic metrics from the cluster
- Grafana is connected to Prometheus and is able to visualize the metrics

### Outcomes v2
- Have the rest of the Grafana stack deployed to the cluster
- Send prometheus metrics to mimir
- Grafana is able to visualize the metrics from mimir 


### Questions to answer (Before)
- What is the purpose of prometheus, what does it can do ?
Software that can collect metrics in a standardized way going to a specific endpoint that uses a set of supported protocols and then send it to a supported storage backend.

- How is the connection between Grafana and Prometheus ?
Grafana can connect to Prometheus and fetch the metrics from it, or it can use its own time-series database mimir  

- What are the overlays between prometheus and Grafana ?
Both Prometheus and Grafana stack offers time-series database

### Questions to answer (After)
- What is the purpose of prometheus, what does it can do ?
- How is the connection between Grafana and Prometheus ?
- What are the overlays between prometheus and Grafana ?
