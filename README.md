# eskibana
Docker container running both Elasticsearch and Kibana, useful for dev or local env where you need to test/mess with ES/Kibana without needing to go through a more complicated set up.

---

Use - (change/update ports for ES/Kibana if you have FW restrictions) 

docker run -d -p `<esport>:<esport>` -p `<kibanaport>:<kibanaport>` `<pathtocontainerregistry>/<containername>:<containertag>`

Here is how I have mine configured - 

```docker run -d -p 8080:9200 -p 80:5601 someurl.here.com/eskibana/eskibana:dev-v0.2.1```

