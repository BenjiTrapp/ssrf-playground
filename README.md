[![Docker](https://github.com/BenjiTrapp/ssrf-playground/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/BenjiTrapp/ssrf-playground/actions/workflows/docker-publish.yml)

![](www/static/tag.png)

<br><br>

<img height="200" align="left" src="www/static/evilmonkey.png" > <br>Use this tiny playground to get intouch with SSRF (Server Side Request Forgery) and learn some common ways to pwn things with such a vulnerability. This Challenge is thought to be used as a challenge in a CTF Event and works fine in combination with Frameworks like [CTFd](https://github.com/BenjiTrapp/CTFd-helm-chart) or Facebooks CTF Framework. During your campaign this [SSRF Cheatsheet](https://cheatsheetseries.owasp.org/cheatsheets/Server_Side_Request_Forgery_Prevention_Cheat_Sheet.html) might help you. This Challenge contains three hidden flags. 
<br><br>
<br><br>
<br><br>
**Content:**
* [Let's discuss your Mission](https://github.com/BenjiTrapp/ssrf-playground#lets-discuss-your-mission)
* [Solution and lessons learned](https://github.com/BenjiTrapp/ssrf-playground#solution-and-lessons-learned)
* [How to get started](https://github.com/BenjiTrapp/ssrf-playground#how-to-get-started)
* [Now some words of warning and disclaimer](https://github.com/BenjiTrapp/ssrf-playground#now-some-words-of-warning-and-disclaimer)
* [It's Dangerous to walk alone - take this!](https://github.com/BenjiTrapp/ssrf-playground#its-dangerous-to-walk-alone---take-this)

---
### Let's discuss your Mission
Docker containers have a lot of pitfalls, depending on the environment the container runs. This Image is build as a jack of all trades so you have multiple opportunities to learn from common mistakes. Make things polyglot means triple the fun :goberserk:

**You will learn how to**:
1. Retrieve valueable which is stored in a file
2. Access kubernetes ServiceAccountToken (startingpoint to takeover a running Pod in k8s)
3. Hijack an AWS Account by raiding the EC2 metadata. The admin moved the regular IP `http://169.254.169.254` to `localhost:1338` - but there is no security by obscurity. 

### Solution and lessons learned
If you're done or just lame - take a look at my [Solution](https://github.com/BenjiTrapp/ssrf-playground/blob/main/exploit/SOLUTION.md). The most crucial part of this isn't the way on how to capute the flag, it's about the mitigation. Read it carefully and if I've missed something, please send me a Pull Request

### How to get started
The easiest way is to use the prebuild Docker image and spin the docker container up like usual: 

```bash
$ docker pull ghcr.io/benjitrapp/ssrf-playground:main
$ docker run docker run --name ssrf-playground -p 8080:80 -d -t ssrf-playground
```

Otherwise you can also build and run the Dockerfile locally. To start this simply use the Makefile like this:

```bash
# Build and run in one step
$ make all

# For control freaks use this path:
$ make run
$ make build
```

**Note:** Dependeing on your OS you may required to add `sudo` infront of each statement 


### Now some words of warning and disclaimer: 
> I'm not responsible for any harm caused by this CTF challenge. Do not deploy in productio and sandbox the Container since it's intentionally broken by design.

### It's Dangerous to walk alone - take this!

##### What is Server Side Request Forgery (SSRF)?
> Allows an attacker to send malicous requests to an arbitrary domain of the attacker‘s choosing by abusing a vulnerable web server

<p align=center>
<img width="600" alt="image" src="https://user-images.githubusercontent.com/8672357/160492625-2752e5ea-6d19-4d0b-b399-332d275395b4.png">
</p>
  
The visualization above shows, that a gibberish web server can be tricked to either access files, API etc which resides on the same location or access different other ressources somewhere in the background or surrounding environment

##### SSRF is used for
Targeting internal systems behind a WAF (Web Application Firewall)
* Reach out for systems that are normally unreachable for an attacker from the external network 
* Access and interact with the Server if the Server is listening on the loopback interface address (127.0.0.1/localhost)
* Bypassing Whitelisting, Host-based authentication services and WAFs => Who can be trusted?
* Internal Scan for Server, other broken Server/Protocols 
* …and many more nasty things

##### Did you heared already how Capital One got hacked?
[Here](https://www.justice.gov/usao-wdwa/press-release/file/1188626/download) you can read the official investigations documents by the US Government about the breach. This story is quite worth to read.

**Details of the breach**:  A Hacker downloaded 30 GB of Capital One credit application data from a rented cloud data Server

The incident affected:
* 100 million US people
* 6 million Canadian
* 80.000 bank account numbers
* 140.000 Social Security numbers
* 1 million Social Insurance numbers for Canadian credit card customers

The Attacker Paige A. Thompson, former Capital One and Amazon Inc employee (here is her [CV](https://gitlab.com/netcrave/Resume/blob/master/cv/experience.tex) doxed herself by bragging on Twitter. 

The hackitself was performed hidden behind a VPN and from the TOR network and was very sophisticated. She managed it to bypass the WAF (Web Application Firewall) by absuing a SSRF weakness and accessed the IMDSv1 (EC2 Metadata Service) to get access to the AWS Account. 

<p align=center>
<img width="600" alt="image" src="https://user-images.githubusercontent.com/8672357/160493361-c18c499a-5a42-4ee5-bec2-c0255291c80e.png">
</p>

Since this kind of attack really happened in the wild - this challenge should teach you how this attack was performed and enhance it by absuing Kubernetes/OpenShift the same way. Have fun and enjoy - by the way don't forget to take a look at the `/exploit/SOLUTION.md` to also learn about how to mitigate the things you learned.

