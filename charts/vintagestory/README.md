# vintagestory

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![AppVersion: 1.20.7](https://img.shields.io/badge/AppVersion-1.20.7-informational?style=flat-square)

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
| server.roles | list | `[{"code":"suvisitor","color":"Green","defaultGameMode":1,"description":"Can only visit this world and chat but not use/place/break anything","landClaimAllowance":"0","name":"Survival Visitor","privileges":["chat"]},{"code":"crvisitor","color":"DarkGray","defaultGameMode":2,"description":"Can only visit this world, chat and fly but not use/place/break anything","landClaimAllowance":"0","name":"Creative Visitor","privileges":["chat"]},{"code":"limitedsuplayer","defaultGameMode":1,"description":"Can use/place/break blocks only in permitted areas (priv level -1), create/manage player groups and chat","landClaimAllowance":"0","name":"Limited Survival Player","privileges":["controlplayergroups","manageplayergroups","chat","build","useblock","attackcreatures","attackplayers","selfkill"]},{"code":"limitedcrplayer","color":"LightGreen","defaultGameMode":2,"description":"Can use/place/break blocks in only in permitted areas (priv level -1), create/manage player groups, chat, fly and set his own game mode (= allows fly and change of move speed)","landClaimAllowance":"0","name":"Limited Creative Player","privileges":["controlplayergroups","manageplayergroups","chat","build","useblock","gamemode","freemove","attackcreatures","attackplayers","selfkill"]},{"code":"suplayer","color":"White","defaultGameMode":1,"description":"Can use/place/break blocks in unprotected areas (priv level 0), create/manage player groups and chat. Can claim an area of up to 8 chunks.","landClaimAllowance":"262144","name":"Survival Player","privilegeLevel":"0","privileges":["controlplayergroups","manageplayergroups","chat","areamodify","build","useblock","attackcreatures","attackplayers","selfkill"]},{"code":"crplayer","color":"LightGreen","defaultGameMode":2,"description":"Can use/place/break blocks in all areas (priv level 100), create/manage player groups, chat, fly and set his own game mode (= allows fly and change of move speed). Can claim an area of up to 40 chunks.","landClaimAllowance":"1310720","landClaimMaxAreas":"6","name":"Creative Player","privilegeLevel":100,"privileges":["controlplayergroups","manageplayergroups","chat","areamodify","build","useblock","gamemode","freemove","attackcreatures","attackplayers","selfkill"]},{"code":"sumod","color":"Cyan","defaultGameMode":1,"description":"Can use/place/break blocks everywhere (priv level 200), create/manage player groups, chat, kick/ban players and do serverwide announcements. Can claim an area of up to 4 chunks.","landClaimAllowance":"1310720","landClaimMaxAreas":"60","name":"Survival Moderator","privilegeLevel":200,"privileges":["controlplayergroups","manageplayergroups","chat","areamodify","build","useblock","buildblockseverywhere","useblockseverywhere","kick","ban","announce","readlists","attackcreatures","attackplayers","selfkill"]},{"code":"crmod","color":"Cyan","defaultGameMode":2,"description":"Can use/place/break blocks everywhere (priv level 500), create/manage player groups, chat, kick/ban players, fly and set his own or other players game modes (= allows fly and change of move speed). Can claim an area of up to 40 chunks.","landClaimAllowance":"1310720","landClaimMaxAreas":"60","name":"Creative Moderator","privilegeLevel":500,"privileges":["controlplayergroups","manageplayergroups","chat","areamodify","build","useblock","buildblockseverywhere","useblockseverywhere","kick","ban","gamemode","freemove","commandplayer","announce","readlists","attackcreatures","attackplayers","selfkill"]},{"autoGrant":true,"code":"admin","color":"LightBlue","defaultGameMode":1,"description":"Has all privileges, including giving other players admin status.","landClaimAllowance":"2147483647","landClaimMaxAreas":"99999","name":"Admin","privilegeLevel":99999,"privileges":["build","useblock","buildblockseverywhere","useblockseverywhere","attackplayers","attackcreatures","freemove","gamemode","pickingrange","chat","kick","ban","whitelist","setwelcome","announce","readlists","give","areamodify","setspawn","controlserver","tp","time","grantrevoke","root","commandplayer","controlplayergroups","manageplayergroups","selfkill"]}]` | List of roles. See templates/config.yaml for the complete set of available fields. |
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
