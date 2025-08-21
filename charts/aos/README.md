# AOS Helm Chart

This Helm chart deploys the Duplo OpenTelemetry stack, including Grafana UI, synthetic monitoring, and other observability components.

## Global Configuration

The following global settings can be configured in the `values.yaml` file:

| Key                          | Description                                  | Default Value                                       |
|------------------------------|----------------------------------------------|-----------------------------------------------------|
| `global.clusterName`         | Name of the Kubernetes cluster               | `duploinfra-{{infraName}}`                          |
| `global.duploAuthUrl`        | URL for Duplo authentication                 | `""`                                                |
| `global.AOSRegion`           | AWS region for the deployment                | `""`                                                |
| `global.customerName`        | Customer name                                | `""`                                                |
| `global.environment`         | Deployment environment (e.g., prod, nonprod) | `""`                                                |
| `global.namespace`           | Kubernetes namespace for the deployment      | `""`                                                |
| `global.namespaceFilter`     | Regex filter for namespaces                  | `.*otel.*`                                          |
| `global.release`             | Release version                              | `2.1.1`                                             |
| `global.grafanaProxyUrl`     | URL for Grafana Proxy                        | `""`                                                |
| `global.slackWebhookUrl`     | Slack webhook URL for notifications          | `""`                                                |
| `global.oncallWebhookUrl`    | On-call webhook URL for notifications        | `""`                                                |
| `global.automationWebhookUrl`| Automation webhook URL                       | `http://duplo-automation:5000/alertmanager/webhook` |
| `global.cloud`               | Cloud provider (e.g., aws, gcp)              |`""`                                                 |
| `global.duploReleaseBranch`  | Duplo release branch                         | `main`                                              |


## Grafana UI Configuration

The `grafanaUI` section in `values.yaml` controls the Grafana UI deployment:

| Key                                                     | Description                                      | Default Value                         |
|---------------------------------------------------------|--------------------------------------------------|---------------------------------------|
| `grafanaUI.enabled`                                     | Enable or disable Grafana UI                     | `true`                                |
| `grafanaUI.replicas`                                    | Number of replicas for Grafana UI                | `1`                                   |
| `grafanaUI.image`                                       | Docker image for Grafana UI                      | `duplocloud/otel-dashboards`          |
| `grafanaUI.imageTag`                                    | Tag for the Grafana UI image                     | `""`                                  |
| `grafanaUI.resources`                                   | Resource requests and limits for Grafana UI      | CPU: `100m`, Memory: `512Mi`          |
| `grafanaUI.volume.size`                                 | Persistent volume size for Grafana UI            | `10Gi`                                |
| `grafanaUI.nodeSelector`                                | Node selector for Grafana UI pods                | `allocationtags: duplo-observability` |
| `grafanaUI.extraEnv`          | Additional environment variables for Grafana UI (YAML list) | `[]` (none) |
| `grafanaUI.plugins`                                     | List of Grafana plugins to install               | `grafana-exploretraces-app,yesoreyeram-infinity-datasource,volkovlabs-form-panel`|
| `grafanaUI.syntheticMonitoring.enabled`                 | Enable synthetic monitoring for Grafana Cloud    | `false`                               |
| `grafanaUI.syntheticMonitoring.config.GC_INSTANCE_ID`   | Synthetic monitoring instance ID                 | `""`                                  |
| `grafanaUI.syntheticMonitoring.config.GC_LOKI_HOST_ID`  | Loki host ID for synthetic monitoring            | `""`                                  |
| `grafanaUI.syntheticMonitoring.config.GC_LOKI_URL`      | Loki URL for synthetic monitoring                | `""`                                  |
| `grafanaUI.syntheticMonitoring.config.GC_MIMIR_HOST_ID` | Mimir host ID for synthetic monitoring           | `""`                                  |
| `grafanaUI.syntheticMonitoring.config.GC_MIMIR_URL`     | Mimir URL for synthetic monitoring               | `""`                                  |
| `grafanaUI.smtp.enabled`         | Enable SMTP for Grafana UI notifications                | `false`                                |
| `grafanaUI.smtp.config.host`     | SMTP server host                                       | `""`                                   |
| `grafanaUI.smtp.config.port`     | SMTP server port                                       | `"465"`                                |
| `grafanaUI.smtp.config.username` | SMTP username                                          | `""`                                   |
| `grafanaUI.smtp.config.password` | SMTP password                                          | `""`                                   |
| `grafanaUI.smtp.config.fromAddress` | From email address                                 | `""`                                   |
| `grafanaUI.smtp.config.fromName` | From name for emails                                   | `"Duplo AOS Alerts"`                   |
| `grafanaUI.smtp.config.starttlsPolicy` | STARTTLS policy                                 | `"MandatoryStartTLS"`                  |

## Grafana Cloud PDC Configuration

The `pdc` section in `values.yaml` controls the Private Data Source (PDC) deployment:

| Key                                           | Description                                      | Default Value                               |
|-----------------------------------------------|--------------------------------------------------|---------------------------------------------|
| `pdc.enabled`                                 | Enable PDC (Private Data Source) for Grafana UI  | `false`                                     |
| `pdc.config.gc_instance_id`                   | Instance ID for PDC configuration                | `""`                                        |
| `pdc.config.pdc_cluster`                      | Cluster name for PDC configuration               | `""`                                        |
| `pdc.config.pdc_token`                        | Token for PDC configuration                      | `""`                                        |
| `pdc.config.pdc_uid`                          | PDC uid                                          | `""`                                        |
| `pdc.config.api_key`                          | GC Service Account Key for datasource            | `""`                                        |
| `pdc.config.aos-mimir-url`                    | AOS mimir url                                    | `"http://duplo-metrics-nginx:80/prometheus"`|
| `pdc.resources.limits.memory`                 | Memory limit for PDC                             | `1Gi`                                       |
| `pdc.resources.requests.cpu`                  | CPU request for PDC                              | `1`                                         |
| `pdc.resources.requests.memory`               | Memory request for PDC                           | `1Gi`                                       |
| `pdc.image`                                   | Docker image for PDC                             | `alpine/k8s`                                |
| `pdc.imageTag`                                | Tag for the PDC image                            | `1.32.1`                                    |
| `pdc.nodeSelector`                            | Node selector for PDC pods                       | `allocationtags: duplo-observability`       |

## AI Suite Configuration

The `aiSuite` section in `values.yaml` controls the AI Suite integration:

| Key                        | Description                                | Default Value |
|----------------------------|--------------------------------------------|--------------|
| `aiSuite.enabled`          | Enable or disable AI Suite integration     | `false`      |
| `aiSuite.duplo_token`      | Duplo token for AI Suite                   | `""`         |
| `aiSuite.duplo_default_tenant` | Default tenant for AI Suite                | `""`         |
| `aiSuite.agent_instance_id`         | Instance ID for the AI Suite agent         | `""`         |
| `aiSuite.agent_name`                | Name for the AI Suite agent                | `""`         |

## Duplo Automation Configuration

The `duploAutomation` section in `values.yaml` controls the Duplo Automation deployment:

| Key                              | Description                                              | Default Value         |
|----------------------------------|----------------------------------------------------------|----------------------|
| `duploAutomation.enabled`        | Enable or disable Duplo Automation                       | `true`               |
| `duploAutomation.replicas`       | Number of replicas for Duplo Automation                  | `1`                  |
| `duploAutomation.image`          | Docker image for Duplo Automation                        | `duplocloud/duplo-automation` |
| `duploAutomation.imageTag`       | Tag for the Duplo Automation image                       | `""`                 |
| `duploAutomation.volume.size`    | Persistent volume size for Duplo Automation              | `10Gi`               |
| `duploAutomation.nodeSelector`   | Node selector for Duplo Automation pods                  | `allocationtags: duplo-observability` |
| `duploAutomation.extraEnv`       | Additional environment variables for Duplo Automation (YAML list) | `[]` (none) |

## Example: Adding Custom Environment Variables

You can add extra environment variables to the deployment using the `extraEnv` field in your `values.yaml`:

```yaml
grafanaUI:
  # ... other settings ...
  extraEnv:
    - name: CUSTOM_VAR1
      value: "value1"
    - name: CUSTOM_VAR2
      value: "value2"

duploAutomation:
  # ... other settings ...
  extraEnv:
    - name: CUSTOM_VAR1
      value: "value1"
    - name: CUSTOM_VAR2
      value: "value2"
```

These variables will be injected into the respective containers as environment variables.

## 📝 Usage Instructions

### 1️⃣ Add the Helm Repository

```bash
helm repo add duplocloud https://duplocloud.github.io/helm-charts
helm repo update
```

### 2️⃣ Install the Chart

> **Note:** Make sure your Kubernetes context is set correctly and specify the desired namespace (replace `<namespace>` as needed).
> **Note:** The `custom-values.yaml` file contains your custom configuration for the Helm chart.  
> You can start with the default [`values.yaml`](./charts/aos/values.yaml) and modify it as needed.

```bash
# Replace <chart-name> with 'aos' (the only available chart)
helm install aos duplocloud/aos -n <namespace> --values custom-values.yaml
```

### 3️⃣ Upgrade the Chart

```bash
helm upgrade aos duplocloud/aos -n <namespace> --values custom-values.yaml --dry-run --debug
helm upgrade aos duplocloud/aos -n <namespace> --values custom-values.yaml
```

### 🧰 Development (Local Installation)

From the repository root directory, run:

```bash
helm install aos ./charts/aos -n <namespace> --values custom-values.yaml
```