# AOS Helm Chart

This Helm chart deploys the Duplo OpenTelemetry stack, including Grafana UI, synthetic monitoring, and other observability components.

## Global Configuration

| Key                          | Description                                  | Default Value                                       |
|------------------------------|----------------------------------------------|-----------------------------------------------------|
| `global.clusterName`         | Name of the Kubernetes cluster               | `duploinfra-{{infraName}}`                          |
| `global.duploAuthUrl`        | URL for Duplo authentication                 | `""`                                                |
| `global.AOSRegion`           | AWS region for the deployment                | `""`                                                |
| `global.customerName`        | Customer name                                | `""`                                                |
| `global.environment`         | Deployment environment (e.g., prod, nonprod) | `""`                                                |
| `global.namespace`           | Kubernetes namespace for the deployment      | `""`                                                |
| `global.namespaceFilter`     | Regex filter for namespaces                  | `.*otel.*`                                          |
| `global.release`             | Release version                              | `""`                                                |
| `global.grafanaProxyUrl`     | URL for Grafana Proxy                        | `""`                                                |
| `global.slackWebhookUrl`     | Slack webhook URL for notifications          | `""`                                                |
| `global.oncallWebhookUrl`    | On-call webhook URL for notifications        | `""`                                                |
| `global.automationWebhookUrl`| Automation webhook URL                       | `http://duplo-automation:5000/alertmanager/webhook` |
| `global.cloud`               | Cloud provider (e.g., aws, gcp)              | `""`                                                |
| `global.duploReleaseBranch`  | Duplo release branch                         | `main`                                              |


## Grafana UI Configuration

| Key                                                     | Description                                                                                      | Default Value                         |
|---------------------------------------------------------|--------------------------------------------------------------------------------------------------|---------------------------------------|
| `grafanaUI.enabled`                                     | Enable or disable Grafana UI                                                                     | `true`                                |
| `grafanaUI.replicas`                                    | Number of replicas                                                                               | `1`                                   |
| `grafanaUI.image`                                       | Docker image                                                                                     | `duplocloud/otel-dashboards`          |
| `grafanaUI.imageTag`                                    | Image tag                                                                                        | `""`                                  |
| `grafanaUI.resources`                                   | Resource requests and limits                                                                     | CPU: `100m`, Memory: `512Mi`          |
| `grafanaUI.volume.size`                                 | Persistent volume size                                                                           | `10Gi`                                |
| `grafanaUI.persistence.enabled`                         | Enable persistent storage                                                                        | `true`                                |
| `grafanaUI.persistence.storageClass`                    | Storage class for persistent volume                                                              | `""`                                  |
| `grafanaUI.nodeSelector`                                | Node selector for pods                                                                           | `allocationtags: duplo-observability` |
| `grafanaUI.extraEnv`                                    | Additional environment variables (YAML list)                                                     | `[]`                                  |
| `grafanaUI.plugins`                                     | Plugins installed via `GF_PLUGINS_PREINSTALL_SYNC` at startup (Grafana 12.x+). Format: `plugin-id@version`. | See `values.yaml`          |
| `grafanaUI.extraPlugins`                                | Additional plugins to install alongside the default list                                         | `""`                                  |
| `grafanaUI.syntheticMonitoring.enabled`                 | Enable synthetic monitoring for Grafana Cloud                                                    | `false`                               |
| `grafanaUI.syntheticMonitoring.plugins`                 | Synthetic monitoring plugin                                                                      | `grafana-synthetic-monitoring-app@1.45.0` |
| `grafanaUI.syntheticMonitoring.config.gc_instance_id`   | Synthetic monitoring instance ID                                                                 | `""`                                  |
| `grafanaUI.syntheticMonitoring.config.gc_loki_host_id`  | Loki host ID                                                                                     | `""`                                  |
| `grafanaUI.syntheticMonitoring.config.gc_loki_url`      | Loki URL                                                                                         | `""`                                  |
| `grafanaUI.syntheticMonitoring.config.gc_mimir_host_id` | Mimir host ID                                                                                    | `""`                                  |
| `grafanaUI.syntheticMonitoring.config.gc_mimir_url`     | Mimir URL                                                                                        | `""`                                  |
| `grafanaUI.syntheticMonitoring.config.gc_synthetic_monitoring_url` | Synthetic monitoring URL                                                            | `""`                                  |
| `grafanaUI.syntheticMonitoring.config.gc_token`         | Grafana Cloud token                                                                              | `""`                                  |
| `grafanaUI.smtp.enabled`                                | Enable SMTP notifications                                                                        | `false`                               |
| `grafanaUI.smtp.config.host`                            | SMTP server host                                                                                 | `""`                                  |
| `grafanaUI.smtp.config.port`                            | SMTP server port                                                                                 | `"465"`                               |
| `grafanaUI.smtp.config.username`                        | SMTP username                                                                                    | `""`                                  |
| `grafanaUI.smtp.config.password`                        | SMTP password                                                                                    | `""`                                  |
| `grafanaUI.smtp.config.fromAddress`                     | From email address                                                                               | `""`                                  |
| `grafanaUI.smtp.config.fromName`                        | From name for emails                                                                             | `"Duplo AOS Alerts"`                  |
| `grafanaUI.smtp.config.starttlsPolicy`                  | STARTTLS policy                                                                                  | `"MandatoryStartTLS"`                 |


## Duplo Automation Configuration

| Key                              | Description                                              | Default Value                         |
|----------------------------------|----------------------------------------------------------|---------------------------------------|
| `duploAutomation.enabled`        | Enable or disable Duplo Automation                       | `true`                                |
| `duploAutomation.replicas`       | Number of replicas                                       | `1`                                   |
| `duploAutomation.image`          | Docker image                                             | `duplocloud/duplo-automation`         |
| `duploAutomation.imageTag`       | Image tag                                                | `""`                                  |
| `duploAutomation.volume.size`    | Persistent volume size                                   | `10Gi`                                |
| `duploAutomation.persistence.enabled` | Enable persistent storage                           | `true`                                |
| `duploAutomation.persistence.storageClass` | Storage class for persistent volume            | `""`                                  |
| `duploAutomation.nodeSelector`   | Node selector for pods                                   | `allocationtags: duplo-observability` |
| `duploAutomation.extraEnv`       | Additional environment variables (YAML list)             | `[]`                                  |


## Grafana Proxy Configuration

| Key                          | Description                          | Default Value                         |
|------------------------------|--------------------------------------|---------------------------------------|
| `grafanaProxy.enabled`       | Enable or disable Grafana Proxy      | `true`                                |
| `grafanaProxy.replicas`      | Number of replicas                   | `1`                                   |
| `grafanaProxy.image`         | Docker image                         | `duplocloud/sso-proxy`                |
| `grafanaProxy.imageTag`      | Image tag                            | `v2.0.5-otel`                         |
| `grafanaProxy.resources`     | Resource requests and limits         | CPU: `50m`, Memory: `128Mi`           |
| `grafanaProxy.nodeSelector`  | Node selector for pods               | `allocationtags: duplo-observability` |


## Grafana Cloud PDC Configuration

| Key                             | Description                                      | Default Value                               |
|---------------------------------|--------------------------------------------------|---------------------------------------------|
| `pdc.enabled`                   | Enable PDC (Private Data Source)                 | `false`                                     |
| `pdc.config.gc_instance_id`     | Instance ID for PDC configuration                | `""`                                        |
| `pdc.config.gc_url`             | Grafana Cloud URL                                | `""`                                        |
| `pdc.config.pdc_cluster`        | Cluster name for PDC configuration               | `""`                                        |
| `pdc.config.pdc_token`          | Token for PDC configuration                      | `""`                                        |
| `pdc.config.pdc_uid`            | PDC UID                                          | `""`                                        |
| `pdc.config.api_key`            | GC Service Account Key for datasource            | `""`                                        |
| `pdc.config.aos_mimir_url`      | AOS Mimir URL                                    | `http://duplo-metrics-nginx:80/prometheus`  |
| `pdc.resources.limits.memory`   | Memory limit                                     | `1Gi`                                       |
| `pdc.resources.requests.cpu`    | CPU request                                      | `1`                                         |
| `pdc.resources.requests.memory` | Memory request                                   | `1Gi`                                       |
| `pdc.image`                     | Docker image                                     | `alpine/k8s`                                |
| `pdc.imageTag`                  | Image tag                                        | `1.35.4`                                    |
| `pdc.nodeSelector`              | Node selector for pods                           | `allocationtags: duplo-observability`       |


## AI Suite Configuration

| Key                            | Description                                | Default Value |
|--------------------------------|--------------------------------------------|---------------|
| `aiSuite.enabled`              | Enable or disable AI Suite integration     | `false`       |
| `aiSuite.duplo_token`          | Duplo token for AI Suite                   | `""`          |
| `aiSuite.duplo_default_tenant` | Default tenant for AI Suite                | `""`          |
| `aiSuite.agent_instance_id`    | Instance ID for the AI Suite agent         | `""`          |
| `aiSuite.agent_name`           | Name for the AI Suite agent                | `""`          |


## Secrets Configuration

| Key                       | Description                  | Default Value  |
|---------------------------|------------------------------|----------------|
| `secrets.grafanaUI.username` | Grafana UI admin username | `duplocloud`   |
| `secrets.grafanaUI.password` | Grafana UI admin password | `""`           |
| `secrets.gpgPassphrase`      | GPG passphrase for secrets | `""`           |


## Integration Job Configuration

| Key                        | Description                          | Default Value                         |
|----------------------------|--------------------------------------|---------------------------------------|
| `integrationJob.enabled`   | Enable or disable the integration job | `true`                               |
| `integrationJob.image`     | Docker image                         | `alpine/k8s`                          |
| `integrationJob.imageTag`  | Image tag                            | `1.35.4`                              |
| `integrationJob.nodeSelector` | Node selector for the job pod     | `allocationtags: duplo-observability` |


## Observability Collector Configuration

| Key                                 | Description                          | Default Value                         |
|-------------------------------------|--------------------------------------|---------------------------------------|
| `observabilityCollector.enabled`    | Enable or disable the cron job       | `true`                                |
| `observabilityCollector.schedule`   | Cron schedule                        | `0 0 * * *`                           |
| `observabilityCollector.image`      | Docker image                         | `duplocloud/duplo-observability`      |
| `observabilityCollector.imageTag`   | Image tag                            | `stable`                              |
| `observabilityCollector.jobVersion` | Job version                          | `2.1.0`                               |
| `observabilityCollector.nodeSelector` | Node selector for pods             | `allocationtags: duplo-observability` |


## OTEL Validation Job

The `otelValidationJob` is a Helm post-install/post-upgrade hook that validates the full observability stack after every deploy. It checks signals (logs, metrics, traces, profiles) and Grafana configuration, then sends a Slack notification with the results.

### Configuration

| Key                                    | Description                                | Default Value                         |
|----------------------------------------|--------------------------------------------|---------------------------------------|
| `otelValidationJob.enabled`            | Enable or disable the validation job       | `true`                                |
| `otelValidationJob.image`              | Docker image                               | `alpine/k8s`                          |
| `otelValidationJob.imageTag`           | Image tag                                  | `1.35.4`                              |
| `otelValidationJob.grafanaUrl`         | Internal Grafana URL for API calls         | `http://grafana-ui:3000`              |
| `otelValidationJob.lokiDsUid`          | Grafana datasource UID for Loki            | `duplo-logging`                       |
| `otelValidationJob.mimirDsUid`         | Grafana datasource UID for Mimir           | `duplo-metrics`                       |
| `otelValidationJob.tempoDsUid`         | Grafana datasource UID for Tempo           | `duplo-tracing`                       |
| `otelValidationJob.pyroDsUid`          | Grafana datasource UID for Pyroscope       | `duplo-profiling`                     |
| `otelValidationJob.alertmanagerDsUid`  | Grafana datasource UID for Alertmanager    | `duplo-alertmanager`                  |
| `otelValidationJob.nodeSelector`       | Node selector for the job pod              | `allocationtags: duplo-observability` |

### What It Validates

The job runs in 3 phases:

**Phase 1 — Setup**
- Waits for all sibling helm hook jobs to complete (timeout: 5 min)
- Waits for Grafana to be healthy via `/api/health` (timeout: 5 min)
- Resolves each datasource UID to a numeric ID via Grafana API

**Phase 2 — Signal Checks** _(confirms live data is flowing for the cluster)_

| Signal | Query |
|--------|-------|
| Loki logs | LogQL `{cluster="<name>"}` — last 15 min |
| Mimir metrics | PromQL `kube_pod_info{cluster="<name>"}` |
| Tempo traces | TraceQL `resource.k8s.cluster.name = "<name>"` |
| Pyroscope profiles | CPU profiles for cluster — last 15 min |

> If any signal check fails, Phase 3 is skipped and the job exits with failure.

**Phase 3 — Grafana Config Checks**

| Check | Min Required |
|-------|-------------|
| Dashboards | 0 (info) |
| Grafana alert rules | ≥ 1 |
| Contact points | info only |
| Grafana notification policies | ≥ 1 |
| Mimir recording rules | 0 (info) |
| Mimir alert rules | ≥ 1 |
| Alertmanager notification policies | ≥ 1 |

**Phase 4 — Summary**
- Prints `✅ / ❌ / ⚠️` results to stdout
- Sends a Slack notification (if `global.slackWebhookUrl` is set) with a deep link to Loki logs

### Status Icons

| Icon | Meaning |
|------|---------|
| `✅` | Check passed |
| `❌` | Check failed — job exits with code 1 |
| `⚠️` | No data yet — instrumentation may be pending, does not fail |
| `ℹ️` | Informational only — never fails |


## Blackbox Exporter Configuration

The `blackboxexporter` section controls the Blackbox Exporter subchart. The subchart is aliased as `blackboxexporter` in `Chart.yaml`, so all configuration (including subchart values) lives under a single `blackboxexporter:` key.

| Key                                                    | Description                                 | Default Value |
|--------------------------------------------------------|---------------------------------------------|---------------|
| `blackboxexporter.enabled`                             | Enable or disable Blackbox Exporter         | `false`       |
| `blackboxexporter.config.modules`                      | Probe modules configuration                 | See below     |
| `blackboxexporter.serviceMonitor.selfMonitor.enabled`  | Enable ServiceMonitor for the exporter itself | `false`     |

### Probe Modules

The subchart ships `http_2xx` by default. Add custom modules in your `custom-values.yaml`:

```yaml
blackboxexporter:
  enabled: true
  config:
    modules:
      http_2xx_insecure:
        prober: http
        timeout: 5s
        http:
          follow_redirects: true
          preferred_ip_protocol: ip4
          tls_config:
            insecure_skip_verify: true
          valid_http_versions: ["HTTP/1.0", "HTTP/1.1", "HTTP/2.0", "HTTP/3.0"]
      tcp_connect:
        prober: tcp
        timeout: 5s
  serviceMonitor:
    selfMonitor:
      enabled: true
```


## Example: Adding Custom Environment Variables

```yaml
grafanaUI:
  extraEnv:
    - name: CUSTOM_VAR1
      value: "value1"

duploAutomation:
  extraEnv:
    - name: CUSTOM_VAR1
      value: "value1"
```


## 📝 Usage Instructions

### 1️⃣ Add the Helm Repository

```bash
helm repo add duplocloud https://duplocloud.github.io/helm-charts
helm repo update
```

### 2️⃣ Install the Chart

> **Note:** Make sure your Kubernetes context is set correctly and specify the desired namespace (replace `<namespace>` as needed).
> The `custom-values.yaml` file contains your custom configuration. Start with the default [`values.yaml`](./values.yaml) and modify as needed.

```bash
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
