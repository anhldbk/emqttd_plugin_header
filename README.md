emqttd_plugin_header
================================

## Overview
This plugin is for `eMQTT`. It adds a header containing meta data for every published message.

The headers is in JSON format:
```js
{
  "from": "<sender who published the messsage>",
  "timestamp": "<int, epoch time at which the message received by eMQTT>",
  "ip": "<ip adress of sender>",
  "port": "<port of sender>"
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

// if you run the code above, it will print something out like:
// { "from": "pong", "timestamp": 1464754795043, "ip": "127.0.0.1", "port": 44952}\nHolla
```

## How to build?

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

## History

#### 1.0.0 / June 1st, 2016
- Released the very first version. Headers added will contain fields `from` & `timestamp`

#### 1.0.1 / July 15th, 2016
- Added `ip` & `port` into headers

#### 1.0.1 / August 12th, 2016
- Fixed for messages with empty payload. Such messages will not be added with headers. This allows users to clear `retained` messages by publishing empty ones

## Author
[Anh Le](https://github.com/anhldbk).

Thank you [Feng Lee](https://github.com/emqplus) for the great broker
