Gruyere Cookbook
=============
Deploy a Google Gruyere environment.
[![Cookbook Version](https://img.shields.io/cookbook/v/gruyere.svg)](https://community.opscode.com/cookbooks/gruyere) [![Build Status](https://secure.travis-ci.org/wargames-cookbooks/gruyere.png)](http://travis-ci.org/wargames-cookbooks/gruyere)


Requirements
------------

#### Platform
- `Ubuntu 14.04`
- `Debian 9.0`

#### Cookbooks
- `apache2` - https://supermarket.chef.io/cookbooks/apache2

Attributes
----------

#### gruyere::default
| Key                               | Type   |  Description                                      |
| ----------------- | ------ | ----------------------------------------------------------------- |
| `[gruyere][path]` | String | Path where application will be deployed (default: `/opt/gruyere`) |

#### gruyere::apache2_proxy
| Key                                  | Type   |  Description                                                 |
| ------------------------------------ | ------- | ----------------------------------------------------------- |
| `[gruyere][apache2][server_name]`    | String  | Apache2 server name (default: `gruyere`)                    |
| `[gruyere][apache2][server_aliases]` | Array   | Array of apache2 virtualhost aliases (default: `[gruyere]`) |

Usage
-----
#### gruyere::default

Just include `gruyere` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[gruyere]"
  ]
}
```

This will setup gruyere that accepts connections from localhost only.

#### gruyere::apache2_proxy

If you want access gruyere from another host, prefer using `apache2_proxy` recipe:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[gruyere::apache2_proxy]"
  ]
}
```

#### Running tests

- First, install dependencies:  
`bundle install`

- Run Checkstyle and ChefSpec:  
`bundle exec rake`

- Run Kitchen tests:  
`bundle exec rake kitchen`  

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add-component-x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Sliim <sliim@mailoo.org> 

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
