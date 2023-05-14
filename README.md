## MQTT client test
Scripts to try MQTT client for RabbitMQ.

status: work in progress, testing playground

## Setup

### gems
```
gem install ruby-mqtt
gem install bunny
gem install sneakers
gem install ruby-protocol-buffers
```


### Docker
download image: `docker pull rabbitmq`

to start it for the first time:
`docker run -it --name myrabbitmq -p 5672:5672 -p 15672:15672 -p 1883:1883 -p 15675:15675 rabbitmq:3`

to run it again:
`docker start -ai myrabbitmq`

### RabbitMQ plugins installation
through terminal tab in docker or start a bash shell:
`docker exec -it myrabbitmq /bin/bash`

```
rabbitmq-plugins enable rabbitmq_management
rabbitmq-plugins enable rabbitmq_mqtt
rabbitmq-plugins enable rabbitmq_web_mqtt
rabbitmq-plugins enable rabbitmq_amqp1_0
rabbitmq-plugins enable rabbitmq_shovel rabbitmq_shovel_management
```

### RabbitMQ configuration
in etc/rabbitmq/conf.d/10-defaults.conf:
```
mqtt.exchange = mqtt.topic
```
### run subscribers
web subscriber:

```
sneakers work Subscriber --require web_subscriber.rb
```
device subscriber: in device_subscriber.rb


### management interface
http://localhost:15672/

