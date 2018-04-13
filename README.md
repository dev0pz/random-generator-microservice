# Random Generator Microservice

## PRNG microservice (with password generation)


<br />

### **TL;DR** 

**Example:**

[link to Docker Hub](https://hub.docker.com/r/devopz/random-microservice/)


`$ docker run -d --name rng -p 3000:3000 devopz/random-microservice`


then give it a try:

`$ curl localhost:3000`


**Example Response (application/json):**

<pre>
{
    "entropy": 3170,
    "msg": "done",
    "passwd": "Bvwz47!ab?1_5L9wb_jW#",
    "rnd": "e41b67d5c3f9c103afc02fa86c39037b740873dc8ff2604123985dba5ae09235a805b3ec7940b20368b56f8a325dce8bdc2c705e68c6a1cd2d4ce0ad92f171c2",
    "rndnum": "2826282327640598433396253918541991660841532951654428203923931795362055713597423136098253394426033242605500826053035106635988955342611784084274123195812239"
}
</pre>

<br />

or just ask for a quick random password:

`$ curl localhost:3000?passwd=1`



**Example Response (text/plain):**
<pre>
3_9!7BR~Qm3%yEY=97W73
</pre>