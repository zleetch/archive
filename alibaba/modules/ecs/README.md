# ECS Module
this module has ECS

## Parameter

| Parameter | Type | Required | Default |
| :---: | :---: | :---: | :---: |
| ecs_name  | string | yes | - |
| ecs_type  | string | no | c6 |
| ecs_cpu  | number | no | 4 |
| ecs_mem  | number | no | 8 |
| image_name  | string | no | ubuntu |
| image_version  | string | no | 22 |
| vsw_name  | string | yes | - |
| replica  | number | no | 1 |
| zone  | list(string) | yes | - |
| attach_eip  | bool | no | false |
| sg_id  | list(string) | yes | - |
| region  | string | yes | - |
| keypair  | string | yes | - |
| system_size  | number | no | 20 |
| system_type  | string | no | cloud_efficiency |
| tag  | object | yes | - |
| tag.team | string | yes | - |

## Output

| Output | type |
| :---: | :---: |
| ecs_id | list(string) |