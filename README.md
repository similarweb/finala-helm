# finala-helm

## Installation

Clone the git repository
```bash
git clone git@github.com:similarweb/finala-helm.git && cd finala-helm
```

Install the Finala helm chart with a release name `my-release`:

helm 2:
```bash
helm install --name my-release .
```
helm 3:
```bash
helm install my-release .
```
## Production Recommendations

1. Work with external Elasticsearch storage
2. Use [Kube2IAM](https://github.com/jtblin/kube2iam) for Finala access.

## Configuration

The following table lists the configurable parameters of the Finala chart.

Parameter | Description | Default
--------- | ----------- | -------
`image.repository` | container image repository | `similarweb/finala`
`image.tag` | container image tag | `v1.1`
`image.pullPolicy` | container image pull policy | `IfNotPresent`
| **storage** |
`storage.type` | `internal` or `external`, internal would start a elasticsearch deployment | `internal`
| **api** |
`api.create` | If true, create API component | `true`
`api.replicas` | The replica count of the webserver | `1`
`api.annotations` | The annotations to be used in the API deployment | `{}`
`api.application.log_level` | The API application log level | `info`
`api.application.storage.elasticsearch.active` | Use elasticsearch storage | `true`
`api.application.storage.elasticsearch.index` | Elasticsearch index | `general`
`api.application.storage.elasticsearch.username` | Elasticsearch username | ``
`api.application.storage.elasticsearch.password` | Elasticsearch password | ``
`api.application.storage.elasticsearch.endpoint` | Elasticsearch endpoint (keep endpoint empty when using storage.type internal) | ``
`api.service.type` | The service type to be used | `ClusterIP`
`api.service.annotations` | The annotations used in the service | `{}`
`api.service.externalPort` | The external port for API server | `80`
`api.ingress.create` | If true, create the resources | `false`
`api.ingress.host` | The API endpoint | `http://127.0.0.1:8081`
`api.ingress.annotations` | The annotations used in the ingress | `{}`
`api.resources` | The [resources] to allocate for the API containers | undefined
| **ui** |
`ui.create` | If true, create UI component | `true`
`ui.replicas` | The replica count of the UI | `1`
`ui.annotations` | The annotations to be used in the UI deployment | `{}`
`ui.application.log_level` | The UI application log level | `info`
`ui.service.type` | The service type to be used | `ClusterIP`
`ui.annotations` | The annotations used in the service | `{}`
`ui.externalPort` | The external port for UI server | `80`
`ui.ingress.create` | If true, create the resources | `false`
`ui.ingress.host` | The user interface endpoint | `https://finala.ui.com`
`ui.ingress.annotations` | The annotations used in the ingress | `{}`
`api.resources` | The [resources] to allocate for the UI containers | undefined
| **collector** |
`collector.create` | If true, create collector component | `true`
`collector.schedule` | Schedule for the CronJob  | `* * 1 * *`
`collector.annotations` | The annotations used  | `{}`
`collector.run_at_deployment` | Run the collector on the deployment  | `true`
`collector.environmentVars` | Collector environment variables  | `{}`
`collector.resources` | The [resources] to allocate for the collector containers | undefined
`collector.application.name` | The tag name of the collector | `general`
`collector.application.log_level` | The collector application log level | `info`
`collector.application.api_server.bulk_interval` | The bulk interval of sending the resources detected to the api component | `5s`
| **notifier** |
`notifier.create` | Should we create Notifier component| `true`
`notifier.schedule` | Schedule for the Notifier CronJob  | `0 8 * * 0`
`notifier.annotations` | The annotations for Notifier  | `{}`
`notifier.environmentVars` | Notifier environment variables  | `{}`
`notifier.resources` | The [resources] to allocate for the Notifier containers | undefined
`notifier.application.log_level` | The Notifier application log level | `info`
