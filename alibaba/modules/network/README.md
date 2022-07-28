# Network Module
this module has VPC, Vswitch, and NAT Gateway

## Parameter

| Parameter | Type | Required | Default |
| :---: | :---: | :---: | :---: |
| vpc_name | string | yes | - |
| vpc_cidr | string | yes | - |
| region | string | yes | - |
| vsw | list(object) | yes | - |
| vsw.name | string | yes | - |
| vsw.cidr | string | yes | - |
| vsw.zone | string | yes | - |
| nat_name | string | no | null |
| nat_vsw | string | no | null |
| nat_payment | string | no | PayAsYouGo |
| nat_type | string | no | Enhanced | 
| tag  | object | yes | - |
| tag.team | string | yes | - |

## Output

| Output | type |
| :---: | :---: |
| vpc_id | string |
| vpc_cidr | string |
| vsw_id | list |
| natgw_id | string |
| natgw_ip | string |
| natgw_snat | string |