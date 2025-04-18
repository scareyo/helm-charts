# vintagestory

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: 1.20.7](https://img.shields.io/badge/AppVersion-1.20.7-informational?style=flat-square)

Vintage Story dedicated game server

See [common](https://github.com/bjw-s/helm-charts/tree/common-3.7.3/charts/library/common) for more values

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| scareyo | <sam@scarey.me> |  |

## Source Code

* <https://github.com/scareyo/helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://bjw-s.github.io/helm-charts | common | 3.7.3 |

## Values

### Controller configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| controllers.main.containers.main.image.repository | string | `"zsuatem/vintagestory"` | Image repository |
| controllers.main.containers.main.image.tag | string | `"1.20.7"` | Image tag |
| controllers.main.initContainers.mods.enabled | bool | `false` | Enable mod installation |
| controllers.main.initContainers.mods.env.MODS | string | `""` | A comma-separated list of mod URLs to install |
| controllers.main.statefulset.volumeClaimTemplates[0].retain | bool | `true` | Keep the data volume on helm uninstall |
| controllers.main.statefulset.volumeClaimTemplates[0].size | string | `"64Gi"` | Size of the data volume |
| controllers.main.statefulset.volumeClaimTemplates[0].storageClass | string | `nil` | Storage class for the data volume |

### Persistence configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| persistence.config.enabled | bool | `true` | Enable ConfigMap configuration |

### Server configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| server.advertiseServer | bool | `false` | Advertise the server on the public server listing. |
| server.allowFallingBlocks | bool | `true` | Allow blocks to fall. |
| server.allowFireSpread | bool | `true` | Allow fire to spread. |
| server.allowPvp | bool | `true` | Allow players to hit each other. |
| server.clientConnectionTimeout | int | `150` | Client connection timeout in seconds. |
| server.compressPackets | bool | `true` | Compress data sent to clients. |
| server.defaultRole | string | `"suplayer"` | Default player role. |
| server.description | string | `nil` | Can be longer than name, visible in the public server listing. You can use VTML here. |
| server.language | string | `"en"` | 2-letter code of localization to use on this server. Determines language of server messages. |
| server.maxChunkRadius | int | `12` | Maximum player view distance. |
| server.maxClients | int | `16` | Maximum number of players. |
| server.name | string | `"Vintage Story Server"` | Short string, visible in the public server listing. |
| server.passTimeWhenEmpty | bool | `false` | Pass time when no players are online. |
| server.password | string | `nil` | Password required to join the server. Disabled if null. |
| server.roles | list | `[{"code":"suplayer","defaultGameMode":1,"description":"Can use/place/break blocks in unprotected areas (priv level 0), create/manage player groups and chat. Can claim an area of up to 8 chunks.","landClaimAllowance":"262144","name":"Survival Player","privileges":["controlplayergroups","manageplayergroups","chat","areamodify","build","useblock","attackcreatures","attackplayers","selfkill"]}]` | List of roles. See templates/config.yaml for the complete set of available fields. |
| server.roles[0] | object | `{"code":"suplayer","defaultGameMode":1,"description":"Can use/place/break blocks in unprotected areas (priv level 0), create/manage player groups and chat. Can claim an area of up to 8 chunks.","landClaimAllowance":"262144","name":"Survival Player","privileges":["controlplayergroups","manageplayergroups","chat","areamodify","build","useblock","attackcreatures","attackplayers","selfkill"]}` | Role code. |
| server.roles[0].defaultGameMode | int | `1` | Default gamemode for role. 0 - Guest, 1 - Survival, 2 - Creative, 3 - Spectator. |
| server.roles[0].description | string | `"Can use/place/break blocks in unprotected areas (priv level 0), create/manage player groups and chat. Can claim an area of up to 8 chunks."` | Role description. |
| server.roles[0].landClaimAllowance | string | `"262144"` | Volume allowed in cubic meters for the land claims of each player who has this role. |
| server.roles[0].name | string | `"Survival Player"` | Role name. |
| server.roles[0].privileges | list | `["controlplayergroups","manageplayergroups","chat","areamodify","build","useblock","attackcreatures","attackplayers","selfkill"]` | List of role privileges (full list may be shown by "/list privileges" command). |
| server.spawn | list | `[0,0]` | Spawn position. |
| server.welcomeMessage | string | `"Welcome {0}, may you survive well and prosper"` | The message shown to players when they join. Placeholder {0} will be replaced with Player's nickname. |

### World configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| world.allowCreativeMode | bool | `true` | Allow creative mode. |
| world.config | string | `nil` | World configuration in JSON format. See "/worldconfig" command for properties. |
| world.name | string | `"A new world"` | World name. |
| world.playstyle | string | `"surviveandbuild"` | World playstyle. |
| world.playstyleLanguage | string | `"surviveandbuild-bands"` | World playstyle language code. |
| world.seed | string | `nil` | World seed. Does not guarantee exactly the same world each time. |
| world.sizeX | string | `"1024000"` | Width of the map. |
| world.sizeY | string | `"256"` | Height of the map. |
| world.sizeZ | string | `"1024000"` | Depth of the map. |
| world.type | string | `"standard"` | World type. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
