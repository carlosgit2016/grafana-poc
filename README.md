### Outcomes v1
- Have prometheus stack deployed in the cluster - DONE
- Prometheus is scraping basic metrics from the cluster - DONE
- Grafana is connected to Prometheus and is able to visualize the metrics - DONE

### Outcomes v2
- Have the rest of the Grafana stack deployed to the cluster - DONE
- Send prometheus metrics to mimir - DONE
- Grafana is able to visualize the metrics from mimir - DONE

### Outcomes v3
- Deploy grafana alloy
- Configure it to send promrules to mimir
- Deploy Loki 
- Configure Alloy to send logs to mimir 
- Configure mimir tenants
- Configure prometheus to run in the agent mode

### Outcomes v4
- Expose an OTel endpoint in the cluster and use a service example to send telemtry data to it
- Configure a custom job in prometheus to scrape a random metric from a service that outputs the log to somewhere in the node
- Deploy grafana agent to the cluster and send data to mimir
- Install dashboard templates for kube-metrics/node-explorer
- Configure mimir to be accessible from internet using TLS authentication
- Configure prometheus to send metrics to mimir in a secure way through internet


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


### Notes
- Ingester is necessary to have 2 replicas at minimum
  
### Valid information for MC
- Why not use PrometheusRule declaration instead of Grafana Rules/Terraform provider
  - To standardize the alerts (considering that we will need to use Grafana Alerting anyway)