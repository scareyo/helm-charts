# attic

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square)

A self-hostable Nix binary cache

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Samuel Carey | <sam@scarey.me> |  |

## Source Code

* <https://github.com/scareyo/helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://bjw-s.github.io/helm-charts | common | 3.7.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| controller.main.containers.main.repository | string | `"ghcr.io/zhaofengli/attic"` | image repository |
| controller.main.containers.main.tag | string | `"main"` | image tag |
| controller.main.statefulset | object | `{"volumeClaimTemplates":[{"name":"data"}]}` | StatefulSet configuration. |
| controller.main.type | string | `"statefulset"` | Set the controller type. |
| persistence | object | `{"data":{"enabled":true}}` | Configure persistence for the chart here. |
| persistence.data.enabled | bool | `true` | Enables or disables the persistence item. |
| service | object | `{"main":{"ports":{"http":{"port":8080}}}}` | Configure the services for the chart here. |
| service.main.ports | object | `{"http":{"port":8080}}` | Configure the Service port information here. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
