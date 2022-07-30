# Security Group Module
this module has security group

## Parameter

| Parameter | Type | Required | Default |
| :---: | :---: | :---: | :---: |
| secgroup_name  | string | yes | - |
| vpc_id  | string | yes | - |
| sg_rule  | map(object) | yes | - |
| sg_rule.map.rule_type  | string | yes | - |
| sg_rule.map.protocol  | string | yes | - |
| sg_rule.map.port_range  | string | yes | - |
| sg_rule.map.ip  | string | yes | - |
| tag  | object | yes | - |
| tag.team | string | yes | - |

## Output

| Output | type |
| :---: | :---: |
| secgroup_id | string |
