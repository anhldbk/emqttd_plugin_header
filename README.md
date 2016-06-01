emqttd_plugin_header
================================

## Overview
This plugin is for `eMQTT`. It adds a header containing meta data for every published message.

The headers is in JSON format:
```js
{
  "from": "user-who-published-the-message",
  timestamp: <int, time at which the message received by eMQTT>
}
```

Messages received by subscribers will have following format:
```text
<header>\n<original-message>
```

The 2 parts are separated by a new line character.

## Example
The following pseudo-code describing what happens if this plugin is loaded into `eMQTT`:
```js
// We're using MQTT.js in this example
var mqtt = require('mqtt');
var pong  = mqtt.connect(
    {
        host: 'localhost',
        port: 1883,
        username: 'pong',
        password: 'pong'
    }
);
pong.subscribe('system');

pong.publish('system', 'Holla', {qos: 2});

pong.on('message', function(topic, message){
  console.log(message);
})

// if you run the code above, it will print:
// { "from": "pong", "timestamp": 1464754795043 }\nHolla
```

## How to build?

```shell
cd emqttd
```

Add the plugin as submodule of `emqttd` project.

If the submodules exist:

```shell
git submodule update --remote plugins/emqttd_plugin_header
```

Or else:
```shell
git submodule add https://github.com/anhldbk/emqttd_plugin_header  plugins/emqttd_plugin_header
```

And then build emqttd project via

```shell
make
make dist
```

## How to use?
Activate the plugin by the following command:

```shell
bin/emqttd_ctl plugins load emqttd_plugin_header
```

## Author
[Anh Le](https://github.com/anhldbk).

Thank you [Feng Lee](https://github.com/emqplus) for the great broker

