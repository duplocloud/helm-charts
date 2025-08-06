# 🛠️ **DuploCloud Helm Charts**  
This repository contains public Helm charts for deploying the DuploCloud Observability Stack and other Duplo services.

---

## 📦 Helm Charts Structure

```
charts/
└── aos/
   ├── Chart.yaml
   ├── values.yaml
   └── templates/
      └── <Helm template files>
.github/
└── workflows/
README.md
```

---

## 🚀 Available Charts

| Chart Name | Description                                                                             |
|------------|-----------------------------------------------------------------------------------------|
| `aos`      | DuploCloud OpenTelemetry Stack (Grafana, synthetic monitoring, observability components) |

---

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
helm install <release-name> duplocloud/<chartname> -n <namespace> --values custom-values.yaml
```

### 3️⃣ Upgrade the Chart

```bash
helm upgrade <release-name> duplocloud/<chart-name> -n <namespace> --values custom-values.yaml
```

### 🧰 Development (Local Installation)

From the repository root directory, run:

```bash
helm install <release-name> ./charts/<chart-name> -n <namespace> --values custom-values.yaml
```

---

## 📬 Support

For questions, issues, or feature requests, please open an issue or contact the DuploCloud team.
